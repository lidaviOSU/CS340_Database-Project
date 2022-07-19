-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the Card Games database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-- get all Card Games
SELECT * FROM CardGames;

-- get all Customers
SELECT * from Customers;

-- get all Developers
SELECT * from Developers;

-- get all Genres
SELECT * FROM Genres;

-- get all Reference materials
SELECT * FROM ReferenceMaterials;

-- get all Sales
SELECT * FROM Sales;

-- get all SalesDetails
SELECT * FROM SalesDetails;

-- get a single card game's data for the Update Card Game form
SELECT cardgame_id, title, stock_qty, priceperpack FROM CardGames WHERE cardgame_id = :cardgame_id_selected_from_browse;

-- get a customer's data for the Update Customer form
SELECT customer_id, name, phone_num, birthday, email FROM Customers WHERE customer_id = :customer_id_selected_from_browse;

-- get a developers's data for the Update Developer form
SELECT dev_id, dev_name, description, staff_comments FROM Developers WHERE dev_id = :dev_id_selected_from_browse;

-- get a genre's data for the Update Genre form
SELECT genre_id, genre_type, description FROM Genres WHERE genre_id = :genre_id_selected_from_browse;

-- get a ReferenceMaterial's data for the Update ReferenceMaterials form
SELECT sourcemat_id, description, staff_comments FROM ReferenceMaterials WHERE sourcemat_id = :sourcemat_id_selected_from_browse;

-- get a Sales's data for the Update Sales form
SELECT purchase_id, purchase_date FROM Sales WHERE purchase_id = :purchase_id_selected_from_browse;

-- get a Sales Detail's data for the Update SalesDetails form
SELECT SalesInvoice_id, customer_custommer_id, purchaseqty, totalcost, CardGames_cardgame_id, Sales_purchase_id FROM SalesDetails WHERE SalesInvoice_id = :SalesInvoice_id_selected_from_browse;

-- add a new card game
INSERT INTO CardGames (title, stock_qty, priceperpack) VALUES (:title, :stock_qty, :priceperpack);

-- add a new customer
INSERT INTO Customers (name, phone_num, birthday, email) VALUES (:name, :phone_num, :birthday, :email);

-- add a new developer
INSERT INTO Developers (dev_name, description, staff_comments) VALUES (:dev_name, :description, :staff_comments);

-- add a new genre
INSERT INTO Genres (genre_type, description) VALUES (:genre_type, :description);

-- add a new ReferenceMaterial
INSERT INTO ReferenceMaterials (description, staff_comments) VALUES (:description, :staff_comments);

-- add a new Sale
INSERT INTO Sales (purchase_date) VALUES (:purchase_date);

-- add a new SalesDetail
INSERT INTO SalesDetails (customer_custommer_id, purchaseqty, totalcost, CardGames_cardgame_id, Sales_purchase_id) VALUES (:customer_custommer_id, :purchaseqty, :totalcost, :cardgame_id, purchase_id);

-- update a cardgame's data based on submission of the Update Card Game form 
UPDATE CardGames SET title = :title, stock_qty= :stock_qty, priceperpack = :priceperpack WHERE id= :cardgame_id_from_the_update_form;

-- update a customer's data based on submission of the Update Customers form 
UPDATE Customers SET name = :name, phone_num= :phone_num, birthday = :birthday, email = :email WHERE id= :customer_id_from_the_update_form;

-- update a Developer's data based on submission of the Update Developer form 
UPDATE Developers SET dev_name = :dev_name, description = :description, staff_comments = :comments WHERE id= :dev_id_from_the_update_form;

-- update a genre's data based on submission of the Update Genre form 
UPDATE Genres SET genre_type = :genre_type, description= :description WHERE id= :genre_id_from_the_update_form;

-- update a Reference Material's data based on submission of the Update Reference Material form 
UPDATE ReferenceMaterials SET description = :description, staff_comments= :staff_comments WHERE id= :sourcemat_id_from_the_update_form;

-- update a Sale's data based on submission of the Update Sales form 
UPDATE Sales SET purchase_date: purchase_date WHERE id= :purchase_id_from_the_update_form;

-- update a Sales Detail's data based on submission of the Update SalesDetails form 
UPDATE SalesDetails SET customer_custommer_id = :customer_custommer_id, purchaseqty = :purchaseqty, totalcost = :totalcost ,  CardGames_cardgame_id = cardgame_id, Sales_purchase_id = :purchase_id WHERE id= :SalesInvoice_id_from_the_update_form;

-- delete a card game
DELETE FROM CardGames WHERE id = :cardgame_id_selected_from_browse_page;

-- delete a customer
DELETE FROM Customers WHERE id = :customer_id_selected_from_browse_page;

-- delete a developer
DELETE FROM Developers WHERE id = :dev_id_selected_from_browse_page;

-- delete a genre
DELETE FROM Genres WHERE id = :genre_id_selected_from_browse_page;

-- delete a Reference Material
DELETE FROM ReferenceMaterials WHERE id = :sourcemat_id_selected_from_browse_page;

-- delete a Sale
DELETE FROM Sales WHERE id = :purchase_id_selected_from_browse_page;

-- delete a Sale's Details
DELETE FROM SalesDetails WHERE id = :SaleInvoice_id_selected_from_browse_page;

-- add a new CardGame developer relationship
INSERT INTO CardGamesDevelopersdetails (CardGamesDevelopers_id, Developers_dev_id, CardGames_cardgame_id) VALUES (:cgdid, :dev_id, :cardgame_id);

-- UPDATE a CardGame developer relationship
Update CardGamesDevelopersdetails SET Developers_dev_id: NULL WHERE id = :CardGamesDevelopers_id_from_list;

-- add a new CardGame Genre relationship
INSERT INTO CardGames_Genres (CardGamesGenres_id, genre_id_inter, cardgame_id_inter) VALUES (:cggid, :genre_id, :cardgame_id);

-- UPDATE a CardGame Genre relationship
Update CardGamesDevelopersdetails SET genre_id_inter: NULL WHERE id = :CardGamesGenres_id_from_list;

-- add a new CardGame Reference Material relationship
INSERT INTO CardGames_ReferenceMaterials (CardGamesRefMaterial_id, ReferenceMaterials_sourcemat_id, CardGames_cardgame_id) VALUES (:cgrid, :sourcemat_id, :cardgame_id);

-- UPDATE a CardGame ReferenceMaterials relationship
Update CardGames_ReferenceMaterials SET ReferenceMaterials_sourcemat_id: NULL WHERE id = :CardGamesRefMaterial_id_from_list;

-- search up genre to card game relationships
SELECT CardGames.cardgame_id, CardGames.title, Genres.genre_id , Genres.genre_type FROM CardGames
INNER JOIN CardGames_Genres ON CardGames.cardgame_id = CardGames_Genres.cardgame_id_inter
INNER JOIN Genres ON Genres.genre_id = CardGames_Genres.genre_id_inter;

-- search up developer to card game relationships
SELECT CardGames.cardgame_id, CardGames.title, Developers.dev_name FROM CardGames
INNER JOIN CardGamesDevelopersdetails ON CardGames.cardgame_id = CardGamesDevelopersdetails.CardGames_cardgame_id
INNER JOIN Developers ON Developers.dev_id = CardGamesDevelopersdetails.Developers_dev_id;

-- search up Reference Material to card game relationships
SELECT CardGames.cardgame_id, CardGames.title, ReferenceMaterials.description FROM CardGames
INNER JOIN CardGames_ReferenceMaterials ON CardGames.cardgame_id = CardGames_ReferenceMaterials.CardGames_cardgame_id
INNER JOIN ReferenceMaterials ON ReferenceMaterials.sourcemat_id = CardGames_ReferenceMaterials.ReferenceMaterials_sourcemat_id;

-- dis-associate a genre from a card game (M-to-M relationship deletion)
DELETE FROM CardGames_Genres WHERE CardGames.cardgame_id = :cardgame_id_selected_from_list AND Genres.genre_id = :genre_id_selected_from_list;

-- dis-associate a developer from a card game (M-to-M relationship deletion)
DELETE FROM CardGamesDevelopersdetails WHERE CardGames.cardgame_id = :cardgame_id_selected_from_list AND Developers.dev_id = :dev_id_selected_from_list;

-- dis-associate a Reference Material from a card game (M-to-M relationship deletion)
DELETE FROM CardGames_ReferenceMaterials WHERE CardGames.cardgame_id = :cardgame_id_selected_from_list AND ReferenceMaterials.sourcemat_id = :sourcemat_id_selected_from_list;
