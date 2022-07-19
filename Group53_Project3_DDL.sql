-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cs340_lidavi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cs340_lidavi
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `cs340_lidavi` DEFAULT CHARACTER SET utf8 ;
USE `cs340_lidavi` ;
SET FOREIGN_KEY_CHECKS = 0;
-- -----------------------------------------------------
-- Table `cs340_lidavi`.`CardGames`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CardGames`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`CardGames`(
  `cardgame_id` INT NOT NULL,
  `title` VARCHAR(150) NOT NULL,
  `stock_qty` INT DEFAULT 0 NOT NULL,
  `price_per_pack` DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (`cardgame_id`))
ENGINE = InnoDB;
INSERT INTO `CardGames` (`cardgame_id`, `title`, `stock_qty`, `price_per_pack`) VALUES
(1, 'Arkham Horror:The Card Game', 100, '20.00'),
(2, 'Marvel Champions: The Card Game', 50, '74.99'),
(3, 'Magic The Gathering', 200, '83.95'),
(4, 'Pokemon Trading Card Game', 200, '12.19'),
(5, 'Yu-Gi-Oh! Trading Card Game', 150, '8.99');


-- -----------------------------------------------------
-- Table `cs340_lidavi`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customers`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`Customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `phone_num` VARCHAR(20) NULL,
  `birthday` DATE NULL,
  `email` VARCHAR(50) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;
INSERT INTO `Customers` (`customer_id`, `name`, `phone_num`, `birthday`, `email`) VALUES
(1, 'David Luo', 818, '1990-01-01', 'davidluo@gmail.com'),
(2, 'Albert Zhang', 424, '1996-01-08', 'Zhang@gmail.com'),
(3, 'Tom Lewis', 415, '2004-06-05', 'trollewis@gmail.com'),
(4, 'John Doe', 364, '2010-09-06', 'superdoe@yahoo.com');

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`Developers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Developers`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`Developers` (
  `dev_id` INT NOT NULL AUTO_INCREMENT,
  `dev_name` VARCHAR(100) NOT NULL,
  `dev_description` TEXT NULL,
  `staff_comment` TEXT NULL,
  PRIMARY KEY (`dev_id`))
ENGINE = InnoDB;
INSERT INTO `Developers` (`dev_id`, `dev_name`, `dev_description`, `staff_comment`) VALUES
(1, 'Konami Digital Entertainment B.V.', 'Konami', NULL),
(2, 'Nintendo Co. Ltd.', 'Nintendo Company', 'popular company with younger generation'),
(3, 'Fantasy Flight Games', 'FFG', NULL),
(4, 'Wizards of the Coast', NULL, 'Popular with more older generations');

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`ReferenceMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReferenceMaterials`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`ReferenceMaterials` (
  `sourcemat_id` INT NOT NULL AUTO_INCREMENT,
  `refmaterial_description` TEXT NULL,
  `staff_comment` TEXT NULL,
  PRIMARY KEY (`sourcemat_id`),
  UNIQUE INDEX `sourcemat_id_UNIQUE` (`sourcemat_id` ASC) VISIBLE)
ENGINE = InnoDB;
INSERT INTO `ReferenceMaterials` (`sourcemat_id`, `refmaterial_description`, `staff_comment`) VALUES
(1, 'Yu-Gi-Oh! tv series', NULL),
(2, 'Pokemon', 'Pokemon series for all generation'),
(3, 'Marvel', 'Superhero based Marvel Comics'),
(4, 'Batman', 'Batman series based game');

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`Genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Genres`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`Genres` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `genre_type` VARCHAR(50) NULL,
  `genre_description` TEXT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE INDEX `genre_id_UNIQUE` (`genre_id` ASC) VISIBLE)
ENGINE = InnoDB;
INSERT INTO `Genres` (`genre_id`, `genre_type`, `genre_description`) VALUES
(1, 'Horror', 'Very mature art '),
(2, 'Tactical', 'Highly skill based game'),
(3, 'Cute', 'Cute art , appeals to kids and young adults'),
(4, 'Mature', 'Mature art'),
(5, 'Dice ', 'Dice rolling involved in game'),
(6, 'Superhero', 'Superhero themed');

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`CardGames_Genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS`CardGames_Genres` ;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`CardGames_Genres` (
  `cardgamesgenre_id` INT NOT NULL AUTO_INCREMENT,
  `cardgame_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`cardgamesgenre_id`),
  INDEX `fk_CardGames to their Genres_CardGames2_idx` (`cardgame_id` ASC) VISIBLE,
  INDEX `fk_CardGames to their Genres_Genres1_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_CardGames to their Genres_CardGames`
    FOREIGN KEY (`cardgame_id`)
    REFERENCES `cs340_lidavi`.`CardGames` (`cardgame_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CardGames to their Genres_Genres`
    FOREIGN KEY (`genre_id`)
    REFERENCES `cs340_lidavi`.`Genres` (`genre_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `CardGames_Genres` (`cardgamesgenre_id`, `cardgame_id`, `genre_id`) VALUES
(1, 1, 1),
(2, 2, 6),
(3, 2, 4),
(4, 4, 3),
(5, 3, 4),
(6, 5, 2);

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`CardGames_ReferenceMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CardGames_ReferenceMaterials`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`CardGames_ReferenceMaterials` (
  `cardgames_refmaterial_id` INT NOT NULL AUTO_INCREMENT,
  `cardgame_id` INT NOT NULL,
  `sourcemat_id` INT NOT NULL,
  PRIMARY KEY (`cardgames_refmaterial_id`),
  INDEX `fk_CardGames to their ReferenceMaterials_CardGames1_idx` (`cardgame_id` ASC) VISIBLE,
  INDEX `fk_CardGames to their ReferenceMaterials_ReferenceMaterials_idx1` (`sourcemat_id` ASC) VISIBLE,
  CONSTRAINT `fk_CardGames to their ReferenceMaterials_CardGames`
    FOREIGN KEY (`cardgame_id`)
    REFERENCES `cs340_lidavi`.`CardGames` (`cardgame_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CardGames to their ReferenceMaterials_ReferenceMaterials`
    FOREIGN KEY (`sourcemat_id`)
    REFERENCES `cs340_lidavi`.`ReferenceMaterials` (`sourcemat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `CardGames_ReferenceMaterials` (`cardgames_refmaterial_id`, `cardgame_id`, `sourcemat_id`) VALUES
(1, 5, 1),
(2, 4, 2),
(3, 2, 3);

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`Sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sales`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`Sales` (
  `purchase_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATE NOT NULL,
  PRIMARY KEY (`purchase_id`))
ENGINE = InnoDB;
INSERT INTO `Sales` (`purchase_id`, `purchase_date`) VALUES
(1, '2022-07-04'),
(2, '2022-07-04'),
(3, '2022-07-05'),
(4, '2022-07-05'),
(5, '2022-07-06');

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`SalesDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SalesDetails`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`SalesDetails` (
  `salesinvoice_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `purchase_qty` INT NOT NULL,
  `total_cost` DECIMAL(19,2) NOT NULL,
  `cardgame_id` INT NOT NULL,
  `purchase_id` INT NOT NULL,
  PRIMARY KEY (`salesinvoice_id`),
  INDEX `fk_SalesDetails_Customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_SalesDetails_Cardgames1_idx` (`cardgame_id` ASC) VISIBLE,
  INDEX `fk_Sales_Sales2_idx` (`purchase_id` ASC) VISIBLE,
  CONSTRAINT `fk_SalesDetails_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `cs340_lidavi`.`Customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_SalesDetails_Cardgames1`
    FOREIGN KEY (`cardgame_id`)
    REFERENCES `cs340_lidavi`.`CardGames` (`cardgame_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Sales_Sales2`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `cs340_lidavi`.`Sales` (`purchase_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;
INSERT INTO `SalesDetails` (`salesinvoice_id`, `customer_id`, `purchase_qty`, `total_cost`, `cardgame_id`, `purchase_id`) VALUES
(1, 1, 3, '60.00', 1, 1),
(2, 1, 1, '8.99', 5, 1),
(3, 3, 5, '60.95', 4, 2),
(4, 4, 1, '74.99', 2, 3),
(5, 2, 10, '839.50', 3, 4),
(6, 2, 2, '167.90', 3, 5);

-- -----------------------------------------------------
-- Table `cs340_lidavi`.`CardGames_Developers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CardGames_Developers`;
CREATE TABLE IF NOT EXISTS `cs340_lidavi`.`CardGames_Developers` (
  `cardgamesdeveloper_id` INT NOT NULL AUTO_INCREMENT,
  `dev_id` INT NOT NULL,
  `cardgame_id` INT NOT NULL,
  PRIMARY KEY (`cardgamesdeveloper_id`),
  INDEX `fk_table1_Developers1_idx` (`dev_id` ASC) VISIBLE,
  INDEX `fk_table1_Cardgames1_idx` (`cardgame_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Developers1`
    FOREIGN KEY (`dev_id`)
    REFERENCES `cs340_lidavi`.`Developers` (`dev_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_table1_Cardgames1`
    FOREIGN KEY (`cardgame_id`)
    REFERENCES `cs340_lidavi`.`CardGames` (`cardgame_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `CardGames_Developers` (`cardgamesdeveloper_id` , `dev_id`, `cardgame_id`) VALUES
(1, 1, 5),
(2, 2, 4),
(3, 3, 1),
(4, 3, 1),
(5, 4, 3);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET FOREIGN_KEY_CHECKS=1;


