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

-- get all Invoices
SELECT * FROM Invoices;

-- get all InvoiceLines
SELECT * FROM InvoiceLines;

-- get a single card game's data for the Update Card Game form
SELECT cardgame_id, title, stock_qty, priceperpack FROM CardGames WHERE cardgame_id = :cardgame_id_selected_from_browse;

-- get a customer's data for the Update Customer form
SELECT customer_id, name, phone_num, birthday, email FROM Customers WHERE customer_id = :customer_id_selected_from_browse;

-- get a developers's data for the Update Developer form
SELECT dev_id, dev_name, description, staff_comments FROM Developers WHERE dev_id = :dev_id_selected_from_browse;

-- get a genre's data for the Update Genre form
SELECT genre_id, genre_type, description FROM Genres WHERE genre_id = :genre_id_selected_from_browse;

-- get a Invoices's data for the Update Invoices form
SELECT purchase_id, purchase_date, customer_id FROM Invoices WHERE purchase_id = :purchase_id_selected_from_browse;

-- get a InvoiceLines data for the Update InvoiceLines form
SELECT invoiceline_id, purchase_qty, line_cost, cardgame_id, purchase_id FROM InvoiceLines WHERE invoicelines_id = :invoicelines_id_selected_from_browse;

-- add a new card game
INSERT INTO CardGames(title, stock_qty, price_per_pack) VALUES (:title, :stock_qty, :price_per_pack);

-- add a new customer
INSERT INTO Customers(name, phone_num, birthday, email) VALUES (:name, :phone_num, :birthday, :email);

-- add a new developer
INSERT INTO Developers(dev_name, dev_description, staff_comments) VALUES (:dev_name, :description, :staff_comments);

-- add a new genre
INSERT INTO Genres(genre_type, genre_description) VALUES (:genre_type, :description);

-- add a new Invoices, customer_id may be NULL
INSERT INTO Invoices(purchase_date, customer_id) VALUES (:purchase_date, :customer_id);

-- add a new InvoiceLines (M: M relationship) from adding new Invoices
INSERT INTO InvoiceLines for(purchase_qty, line_cost, cardgame_id, purchase_id) VALUES (:purchase_qty, :linecost, :cardgame_id, purchase_id);

-- update a cardgame's data based on submission of the Update Card Game form 
UPDATE CardGames SET title = :title, stock_qty= :stock_qty, price_per_pack = :priceperpack WHERE cardgame_id= :cardgame_id_from_the_update_form;

-- update a customer's data based on submission of the Update Customers form 
UPDATE Customers SET name = :name, phone_num= :phone_num, birthday = :birthday, email = :email WHERE customer_id= :customer_id_from_the_update_form;

-- update a Developer's data based on submission of the Update Developer form 
UPDATE Developers SET dev_name = :dev_name, dev_description = :description, staff_comments = :comments WHERE dev_id= :dev_id_from_the_update_form;

-- update a genre's data based on submission of the Update Genre form 
UPDATE Genres SET genre_type = :genre_type, genre_description= :description WHERE genre_id= :genre_id_from_the_update_form;

-- update a Invoice's data based on submission of the Update Invoice form , customer_id may be NULL
UPDATE Invoices SET purchase_date: purchase_date, customer_id: customer_id WHERE purchase_id= :purchase_id_from_the_update_form;

-- update a InvoiceLines's data based on submission of the Update InvoiceLines form 
UPDATE InvoiceLines SET purchase_qty = :purchase_qty, line_cost = :line_cost , cardgame_id = cardgame_id, purchase_id = :purchase_id WHERE invoicelines_id= :invoicelines_id_from_the_update_form;

-- delete a card game
DELETE FROM CardGames WHERE cardgame_id = :cardgame_id_selected_from_browse_page;

-- delete a customer
DELETE FROM Customers WHERE customer_id = :customer_id_selected_from_browse_page;

-- delete a developer
DELETE FROM Developers WHERE dev_id = :dev_id_selected_from_browse_page;

-- delete a genre
DELETE FROM Genres WHERE genre_id = :genre_id_selected_from_browse_page;

-- delete a Invoice
DELETE FROM Invoice WHERE purchase_id = :purchase_id_selected_from_browse_page;

-- delete a InvoiceLines
DELETE FROM InvoiceLines WHERE InvoiceLines_id = :invoicelines_id_selected_from_browse_page;

-- add a new CardGame Genre relationship(M: M relationship)
INSERT INTO CardGames_Genres (genre_id_inter, cardgame_id_inter) VALUES (:genre_id, :cardgame_id) WHERE cardgame_id = cardgame_id_from_drop_down;

-- UPDATE a CardGame Genre relationship
Update CardGames_Genres SET genre_id_inter: NULL WHERE id = :cardgame_id_from_drop_down;

-- search up genre to card game relationships
SELECT CardGames.cardgame_id, CardGames.title, Genres.genre_id , Genres.genre_type FROM CardGames
INNER JOIN CardGames_Genres ON CardGames.cardgame_id = CardGames_Genres.cardgame_id_inter
INNER JOIN Genres ON Genres.genre_id = CardGames_Genres.genre_id_inter;

-- search up developer to card game relationships
SELECT CardGames.cardgame_id, CardGames.title, Developers.dev_name FROM CardGames
INNER JOIN CardGamesDevelopersdetails ON CardGames.cardgame_id = CardGamesDevelopersdetails.CardGames_cardgame_id
INNER JOIN Developers ON Developers.dev_id = CardGamesDevelopersdetails.Developers_dev_id;

-- dis-associate a genre from a card game (M-to-M relationship deletion)
DELETE FROM CardGames_Genres WHERE CardGames.cardgame_id = :cardgame_id_selected_from_drop_down AND Genres.genre_id = :genre_id_from_title_input;

-- get all InvoiceLines
SELECT * FROM InvoiceLines WHERE input = :input_from_drop_down AND id:input_id_from_input_box
