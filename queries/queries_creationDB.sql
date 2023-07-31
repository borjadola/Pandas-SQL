create database blockbuster

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blockbuster` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blockbuster` ;

-- -----------------------------------------------------
-- Table `blockbuster`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Actor` (
  `actor_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Customer` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(100) NOT NULL,
  `c.p.` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `update` DATETIME NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Language` (
  `language_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Films`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Films` (
  `film_id` INT NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `release_year` YEAR NOT NULL,
  `rental_duration` INT NOT NULL,
  `rental_rate` DECIMAL(10,0) NULL DEFAULT NULL,
  `length` INT NOT NULL,
  `replacement_cost` VARCHAR(45) NOT NULL,
  `rating` VARCHAR(20) NOT NULL,
  `special_features` VARCHAR(100) NULL DEFAULT NULL,
  `language_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`film_id`),
  INDEX `fk_Films_Language1_idx` (`language_id` ASC) VISIBLE,
  INDEX `fk_Films_Category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_Films_Category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `blockbuster`.`Category` (`category_id`),
  CONSTRAINT `fk_Films_Language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `blockbuster`.`Language` (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Inventory` (
  `inventory_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_Inventory_Films1_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory_Films1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`Films` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Staff` (
  `staff_id` INT NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`Rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`Rental` (
  `rental_id` INT NOT NULL,
  `rental_date` VARCHAR(45) NULL DEFAULT NULL,
  `return_date` VARCHAR(45) NULL DEFAULT NULL,
  `inventory_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_Rental_Inventory1_idx` (`inventory_id` ASC) VISIBLE,
  INDEX `fk_Rental_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Rental_Staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Rental_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `blockbuster`.`Customer` (`customer_id`),
  CONSTRAINT `fk_Rental_Inventory1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `blockbuster`.`Inventory` (`inventory_id`),
  CONSTRAINT `fk_Rental_Staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `blockbuster`.`Staff` (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`film_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`film_actor` (
  `film_id` INT NOT NULL,
  `actor_id` INT NOT NULL,
  INDEX `fk_Films_has_Actor_Actor1_idx` (`actor_id` ASC) VISIBLE,
  INDEX `fk_Films_has_Actor_Films1_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_Films_has_Actor_Actor1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `blockbuster`.`Actor` (`actor_id`),
  CONSTRAINT `fk_Films_has_Actor_Films1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`Films` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
