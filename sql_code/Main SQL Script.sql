-- MySQL Script generated by MySQL Workbench
-- Mon Nov 13 23:14:57 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project03
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Project03
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project03` DEFAULT CHARACTER SET utf8 ;
USE `Project03` ;

-- -----------------------------------------------------
-- Table `Project03`.`Seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project03`.`Seller` (
  `Seller_short_code` VARCHAR(14) NOT NULL,
  `seller_visible_date` VARCHAR(45) NOT NULL,
  `seller_name` VARCHAR(45) NOT NULL,
  `Seller_Phone_Contact` VARCHAR(20) NOT NULL,
  `Seller_Mail_Contact` VARCHAR(45) NOT NULL,
  `shop_url` VARCHAR(80) NOT NULL,
  `seller_region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Seller_short_code`),
  UNIQUE INDEX `Seller short code_UNIQUE` (`Seller_short_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project03`.`Buyer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project03`.`Buyer` (
  `Buyer_ID` VARCHAR(14) NOT NULL,
  `Buyer_visible_date` DATETIME NOT NULL,
  `Buyer_name` VARCHAR(45) NOT NULL,
  `Buyer_Contact_Phone` VARCHAR(45) NOT NULL,
  `Buyer_Contact_Mail` VARCHAR(45) NOT NULL,
  `Buyer_Address` VARCHAR(45) NOT NULL,
  `Buyer_region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Buyer_ID`),
  UNIQUE INDEX `Buyer_ID_UNIQUE` (`Buyer_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project03`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project03`.`Items` (
  `Item_ID` VARCHAR(14) NOT NULL,
  `Item_name` VARCHAR(45) NOT NULL,
  `main_cluster` VARCHAR(45) NOT NULL,
  `main_cat1` VARCHAR(45) NULL,
  PRIMARY KEY (`Item_ID`),
  UNIQUE INDEX `Item_ID_UNIQUE` (`Item_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project03`.`Shop_Cart_Info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project03`.`Shop_Cart_Info` (
  `Shop_cart_ID` INT NOT NULL AUTO_INCREMENT,
  `Item_ID` VARCHAR(14) NOT NULL,
  `Seller_short_code` VARCHAR(14) NOT NULL,
  `Price` FLOAT NOT NULL,
  PRIMARY KEY (`Shop_cart_ID`),
  UNIQUE INDEX `Shop_cart_ID_UNIQUE` (`Shop_cart_ID` ASC) VISIBLE,
  INDEX `fk_Shop_Cart_Info_Items_idx` (`Item_ID` ASC) VISIBLE,
  INDEX `Cart_ID_Seller_idx` (`Seller_short_code` ASC) VISIBLE,
  CONSTRAINT `fk_Cart_ID_Item`
    FOREIGN KEY (`Item_ID`)
    REFERENCES `Project03`.`Items` (`Item_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Cart_ID_Seller`
    FOREIGN KEY (`Seller_short_code`)
    REFERENCES `Project03`.`Seller` (`Seller_short_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project03`.`Pay_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project03`.`Pay_method` (
  `Pay_ID` INT NOT NULL AUTO_INCREMENT,
  `Method_Payment` VARCHAR(45) NOT NULL,
  `Transaction_Trans_ID` INT NOT NULL,
  `Transaction_Shop_Cart_Info_Shop_cart_ID` INT NOT NULL,
  `Transaction_Buyer_Buyer_ID` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Pay_ID`, `Transaction_Trans_ID`, `Transaction_Shop_Cart_Info_Shop_cart_ID`, `Transaction_Buyer_Buyer_ID`),
  UNIQUE INDEX `Pay_ID_UNIQUE` (`Pay_ID` ASC) VISIBLE,
  UNIQUE INDEX `Method_Payment_UNIQUE` (`Method_Payment` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project03`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project03`.`Transaction` (
  `Trans_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_date` DATETIME NOT NULL,
  `Buyer_ID` VARCHAR(14) NOT NULL,
  `Pay_ID` INT NOT NULL,
  `Shop_cart_ID` INT NOT NULL,
  `Amount` INT NOT NULL,
  `Shop_Cart_Info_Items_Item_ID` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Trans_ID`, `Shop_Cart_Info_Items_Item_ID`),
  UNIQUE INDEX `Trans_ID_UNIQUE` (`Trans_ID` ASC) VISIBLE,
  INDEX `fk_Trans_Cart_idx` (`Shop_cart_ID` ASC) VISIBLE,
  INDEX `fk_Trans_Buyer_idx` (`Buyer_ID` ASC) VISIBLE,
  INDEX `fk_Trans_Pay_idx` (`Pay_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Trans_Cart`
    FOREIGN KEY (`Shop_cart_ID`)
    REFERENCES `Project03`.`Shop_Cart_Info` (`Shop_cart_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Trans_Buyer`
    FOREIGN KEY (`Buyer_ID`)
    REFERENCES `Project03`.`Buyer` (`Buyer_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Trans_Pay`
    FOREIGN KEY (`Pay_ID`)
    REFERENCES `Project03`.`Pay_method` (`Pay_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
