-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema villagedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `villagedb` ;

-- -----------------------------------------------------
-- Schema villagedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `villagedb` DEFAULT CHARACTER SET utf8 ;
USE `villagedb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `role` VARCHAR(45) NOT NULL DEFAULT 'standard',
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `State`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `State` ;

CREATE TABLE IF NOT EXISTS `State` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `abbr` VARCHAR(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state_id` INT NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_state_by_state_id_idx` (`state_id` ASC),
  CONSTRAINT `fk_state_by_state_id`
    FOREIGN KEY (`state_id`)
    REFERENCES `State` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `volunteer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteer` ;

CREATE TABLE IF NOT EXISTS `volunteer` (
  `user_id` INT NOT NULL,
  `phone_number` VARCHAR(45) NULL,
  `dob` VARCHAR(45) NULL,
  `address_id` INT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `picture_url` TEXT NULL,
  `about` TEXT NULL,
  INDEX `fk_to_user_idx` (`user_id` ASC),
  PRIMARY KEY (`user_id`),
  INDEX `fk_to_address_volunteer_idx` (`address_id` ASC),
  CONSTRAINT `fk_to_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_address_volunteer`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project` ;

CREATE TABLE IF NOT EXISTS `project` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `owner_id` INT NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `description` TEXT NULL,
  `address_id` INT NULL,
  `start_time` VARCHAR(45) NULL,
  `hours_needed` INT NULL,
  `volunteers_needed` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_to_project_owner_idx` (`owner_id` ASC),
  INDEX `fk_to_address_project_idx` (`address_id` ASC),
  CONSTRAINT `fk_to_project_owner`
    FOREIGN KEY (`owner_id`)
    REFERENCES `volunteer` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_address_project`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company` ;

CREATE TABLE IF NOT EXISTS `company` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_volunteer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_volunteer` ;

CREATE TABLE IF NOT EXISTS `project_volunteer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `volunteer_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `hours_actual` INT NULL DEFAULT 0,
  `hours_pledged` INT NULL DEFAULT 0,
  `company_id` INT NULL,
  INDEX `fk_to_project_idx` (`project_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_to_company_idx` (`company_id` ASC),
  CONSTRAINT `fk_to_volunteer`
    FOREIGN KEY (`volunteer_id`)
    REFERENCES `volunteer` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category_project` ;

CREATE TABLE IF NOT EXISTS `category_project` (
  `category_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `project_id`),
  INDEX `fk_to_project_from_table_idx` (`project_id` ASC),
  CONSTRAINT `fk_to_category_from_table`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_project_from_table`
    FOREIGN KEY (`project_id`)
    REFERENCES `project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comments` ;

CREATE TABLE IF NOT EXISTS `comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `comment` VARCHAR(200) NULL,
  `date` VARCHAR(45) NULL,
  `time` VARCHAR(45) NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_to_user_idx` (`user_id` ASC),
  INDEX `fk_cooment_to_project_idx` (`project_id` ASC),
  CONSTRAINT `fk_comment_to_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cooment_to_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Items` ;

CREATE TABLE IF NOT EXISTS `Items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `items_pv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `items_pv` ;

CREATE TABLE IF NOT EXISTS `items_pv` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `items_id` INT NOT NULL,
  `pv_id` INT NOT NULL,
  `quantity` INT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_to_items_idx` (`items_id` ASC),
  INDEX `fk_to_pv_from_items_pv_idx` (`pv_id` ASC),
  CONSTRAINT `fk_to_items`
    FOREIGN KEY (`items_id`)
    REFERENCES `Items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_pv_from_items_pv`
    FOREIGN KEY (`pv_id`)
    REFERENCES `project_volunteer` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `items_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `items_project` ;

CREATE TABLE IF NOT EXISTS `items_project` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity_needed` INT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_items_project_to_project_idx` (`project_id` ASC),
  INDEX `fk_items_project_to_items_idx` (`item_id` ASC),
  CONSTRAINT `fk_items_project_to_project`
    FOREIGN KEY (`project_id`)
    REFERENCES `project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_project_to_items`
    FOREIGN KEY (`item_id`)
    REFERENCES `Items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS panda1@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'panda1'@'localhost' IDENTIFIED BY 'nuclear';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'panda1'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (1, 'admin', 'password', 'admin@admin.com', 'admin', 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (2, 'supervolunteer', 'password', 'genericemail@email.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (3, 'okayvolunteer', 'password', 'okayemail@gmail.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (4, 'thebestvolunteer', 'password', 'bestemail@gmail.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (5, 'ivolunteer', 'password', 'iemail@email.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (6, 'beastmodevolunteer', 'password', 'beastemail@email.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (7, 'sometimesvolunteer', 'password', 'sometimesemail@email.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (8, 'crazyvolunteer', 'password', 'crazyemail@gmail.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (9, 'indianajones', 'password', 'indiemail@email.com', DEFAULT, 1);
INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `role`, `active`) VALUES (10, 'georgewashington', 'password', 'president@email.com', DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `State`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (1, 'Alabama', 'AL');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (2, 'Alaska', 'AK');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (3, 'Arizona', 'AZ');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (4, 'Arkansas', 'AR');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (5, 'California', 'CA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (6, 'Colorado', 'CO');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (7, 'Connecticut', 'CT');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (8, 'Delaware', 'DE');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (9, 'District of Columbia', 'DC');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (10, 'Florida', 'FL');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (11, 'Georgia', 'GA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (12, 'Hawaii', 'HI');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (13, 'Idaho', 'ID');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (14, 'Illinois', 'IL');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (15, 'Indiana', 'IN');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (16, 'Iowa', 'IA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (17, 'Kansas', 'KS');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (18, 'Kentucky', 'KY');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (19, 'Louisiana', 'LA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (20, 'Maine', 'ME');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (21, 'Montana', 'MT');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (22, 'Nebraska', 'NE');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (23, 'Nevada', 'NV');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (24, 'New Hampshire', 'NH');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (25, 'New Jersey', 'NJ');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (26, 'New Mexico', 'NM');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (27, 'New York', 'NY');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (28, 'North Carolina', 'NC');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (29, 'North Dakota', 'ND');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (30, 'Ohio', 'OH');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (31, 'Oklahoma', 'OK');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (32, 'Oregon', 'OR');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (33, 'Maryland', 'MD');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (34, 'Massachusetts', 'MA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (35, 'Michigan', 'MI');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (36, 'Minnesota', 'MN');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (37, 'Mississippi', 'MS');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (38, 'Missouri', 'MO');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (39, 'Pennsylvania', 'PA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (40, 'Rhode Island', 'RI');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (41, 'South Carolina', 'SC');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (42, 'South Dakota', 'SD');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (43, 'Tennessee', 'TN');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (44, 'Texas', 'TX');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (45, 'Utah', 'UT');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (46, 'Vermont', 'VT');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (47, 'Virginia', 'VA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (48, 'Washington', 'WA');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (49, 'West Virginia', 'WV');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (50, 'Wisconsin', 'WI');
INSERT INTO `State` (`id`, `name`, `abbr`) VALUES (51, 'Wyoming', 'WY');

COMMIT;


-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (1, '7400 E Orchard rd', NULL, 'GreenWood Village', 6, '80111');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (2, '1600 Pennsylvania Ave', NULL, 'Washington DC', 9, '20500');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (3, '1520 E Colfax Ave', NULL, 'Denver', 6, '80218');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (4, '1701 Bryant St', NULL, 'Denver', 6, '80204');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (5, '1313 Disneyland Dr', NULL, 'Anaheim', 5, '92802');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (6, '3799 S Las Vegas Blvd', NULL, 'Las Vegas', 23, '89109');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (7, '300 N Cambell St', NULL, 'El Paso', 44, '79901');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (8, '400 Broad St', NULL, 'Seattle', 48, '98109');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (9, '500 Sea World Dr', NULL, 'San Diego', 5, '92109');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state_id`, `zip`) VALUES (10, '100 Winter Park Dr,', NULL, 'Winter Park,', 6, '80482');

COMMIT;


-- -----------------------------------------------------
-- Data for table `volunteer`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (1, '303-867-5309', '1900-01-01', 1, 'Nuclear', 'Panda', 'https://lh3.googleusercontent.com/-dApZo84g1a0/VIsoQshVUnI/AAAAAAAAAH0/6_z7NHvV8b8/w638-h638/BanksyPanda1.jpg', 'Bombs and Bambo');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (2, '123-456-7890', '1999-01-23', 2, 'Bob', 'Ross', 'https://static-cdn.jtvnw.net/jtv_user_pictures/bobross-profile_image-0b9dd167a9bb16b5-300x300.jpeg', 'Painting and stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (3, '456-677-3332', '1967-03-05', 3, 'Harry', 'Potter', 'https://vignette.wikia.nocookie.net/hari-poter-srbija/images/4/41/Harry_potter_2nd_year.jpeg/revision/latest?cb=20160218175754', 'Wizard and stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (4, '345-676-3321', '1954-06-30', 4, 'Jackie', 'Chan', 'https://socialnewsdaily.com/wp-content/uploads/2016/04/936036-jackie-chan.jpg', 'Karate and funny stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (5, '344-556-3233', '1987-05-22', 5, 'Andre', 'Giant', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Andr%C3%A9_the_Giant_in_the_late_%2780s.jpg/220px-Andr%C3%A9_the_Giant_in_the_late_%2780s.jpg', 'Giant and stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (6, '342-667-3232', '1980-04-29', 6, 'Miles', 'Davis', 'https://pixel.nymag.com/imgs/daily/vulture/2015/09/17/magazine/18-miles-davis.w700.h700.jpg', 'Stuff stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (7, '707-453-2344', '1975-07-13', 7, 'Randy', 'Savage', 'https://img.bleacherreport.net/img/images/photos/002/318/574/macho-man-randy-savage-1_crop_exact.jpg?w=1200&h=1200&q=75', 'Wrestling and stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (8, '453-235-2466', '1978-10-24', 8, 'Betty', 'White', 'http://www.magic925.com/wp-content/uploads/2018/01/Screen-Shot-2018-01-09-at-2.57.52-PM.png', 'Funny and stuff (also old)');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (9, '342-343-2356', '1988-12-25', 9, 'George', 'Costanza', 'https://pbs.twimg.com/profile_images/2606895456/Cant_Stand_Ya_.jpg', 'Weird and funny stuff');
INSERT INTO `volunteer` (`user_id`, `phone_number`, `dob`, `address_id`, `first_name`, `last_name`, `picture_url`, `about`) VALUES (10, '342-645-3223', '1732-02-22', 10, 'George', 'Washington', 'https://cdn.britannica.com/s:300x300/95/4995-004-45F5BF39.jpg', 'President and stuff');

COMMIT;


-- -----------------------------------------------------
-- Data for table `project`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (1, 'TP Steves House', 1, 1, '2019-01-18', '2019-01-18', 'TP Everywhere on and around Steves house.', 1, '08:00 pm', 6, 6);
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (2, 'Clean up a Park', 2, 1, '2019-02-01', '2019-02-02', 'Pick up trash, pull weeds, remove graffiti, etc', 5, '08:00 am', 50, 10);
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (3, 'Build a Community TreeHouse', 4, 1, '2019-04-01', '2019-04-04', 'Build a Tree House in the Park', 4, '08:00 am', 100, 10);
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (4, 'Food Bank for Homeless', 7, 1, '2019-03-20', '2019-03-20', 'Bring food and hand it out', 9, '05:00 pm', 20, 10);
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (5, 'Save The World', 10, 1, '2019-01-18', '2020-01-01', 'Stop Lex Luthor from Winning. End: World Hunger, War, and Global Warming. Clean up the oceans and save the turtles', 3, NULL, 1000000, 1000000);
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (6, 'Tear down the Berlin Wall', 8, 0, '1991-11-01', '1991-11-10', 'Tear Down this Wall!', 2, '08:00 am', 10000, 1000);
INSERT INTO `project` (`id`, `title`, `owner_id`, `active`, `start_date`, `end_date`, `description`, `address_id`, `start_time`, `hours_needed`, `volunteers_needed`) VALUES (7, 'Shed the Slopes', 3, 1, '2019-03-20', NULL, 'Make sure the slopes are still fun', 10, '08:00 am', 40, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `company`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `company` (`id`, `name`) VALUES (1, 'Skill Distillery');
INSERT INTO `company` (`id`, `name`) VALUES (2, 'Nuclear Panda inc');
INSERT INTO `company` (`id`, `name`) VALUES (3, 'Brainwave Coffee');
INSERT INTO `company` (`id`, `name`) VALUES (4, 'RealLife Service inc');
INSERT INTO `company` (`id`, `name`) VALUES (5, 'Strawberry Sultan');
INSERT INTO `company` (`id`, `name`) VALUES (6, 'Andromeda Electron');
INSERT INTO `company` (`id`, `name`) VALUES (7, 'Redwood MilkyWay');
INSERT INTO `company` (`id`, `name`) VALUES (8, 'Railroad Legend');
INSERT INTO `company` (`id`, `name`) VALUES (9, 'Party Vision LLC');
INSERT INTO `company` (`id`, `name`) VALUES (10, 'Cookie Basic ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `project_volunteer`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (1, 1, 1, 0, 1, 2);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (2, 2, 1, 0, 1, NULL);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (3, 3, 1, 0, 1, 3);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (4, 4, 1, 0, 1, 8);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (5, 5, 1, 0, 1, 5);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (6, 6, 1, 0, 1, 6);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (7, 1, 2, 0, 2, 2);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (8, 2, 2, 0, 7, NULL);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (9, 3, 2, 0, 5, 3);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (10, 7, 2, 0, 3, 5);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (11, 10, 3, 0, 2, 1);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (12, 8, 3, 0, 4, 3);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (13, 5, 3, 0, 6, 10);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (14, 2, 3, 0, 3, 10);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (15, 4, 3, 0, 10, 8);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (16, 7, 4, 0, 2, NULL);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (17, 3, 4, 0, 2, 3);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (18, 4, 4, 0, 1, 7);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (19, 2, 4, 0, 2, 5);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (20, 6, 4, 0, 1, NULL);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (21, 5, 4, 0, 2, NULL);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (22, 10, 5, 100, 1000, 1);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (23, 3, 5, 5, 10, 9);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (24, 1, 5, 300, 1000, 2);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (25, 8, 5, 10, 10, 8);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (26, 7, 5, 30, 30, 4);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (27, 5, 5, 30, 30, 5);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (28, 8, 6, 40, 20, 6);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (29, 7, 6, 30, 10, 6);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (30, 1, 6, 100, 40, 2);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (31, 10, 6, 60, 33, 1);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (32, 2, 6, 0, 1, 4);
INSERT INTO `project_volunteer` (`id`, `volunteer_id`, `project_id`, `hours_actual`, `hours_pledged`, `company_id`) VALUES (33, 1, 7, 1000, 10, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `category` (`id`, `name`, `description`) VALUES (1, 'Clean Up', 'Clean Up Stuff');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (2, 'Build', 'Construct Some Stuff');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (3, 'Demolition', 'Destroy Some Stuff');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (4, 'Distribution ', 'Hand out Food, Clothes, Supplies, ETC.');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (6, 'Other', 'Anything');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (5, 'Landscape', 'Landscaping stuff');

COMMIT;


-- -----------------------------------------------------
-- Data for table `category_project`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (5, 1);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (6, 2);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (1, 2);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (1, 3);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (4, 4);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (1, 5);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (2, 5);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (4, 5);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (5, 5);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (6, 5);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (1, 6);
INSERT INTO `category_project` (`category_id`, `project_id`) VALUES (3, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comments`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `comments` (`id`, `user_id`, `project_id`, `comment`, `date`, `time`, `active`) VALUES (1, 1, 1, 'This Project is going to be awesome!', '2019-01-15', '10:00', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Items`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `Items` (`id`, `name`) VALUES (1, 'Construction Skills');
INSERT INTO `Items` (`id`, `name`) VALUES (2, 'Shovel');
INSERT INTO `Items` (`id`, `name`) VALUES (3, 'Hoe');
INSERT INTO `Items` (`id`, `name`) VALUES (4, 'Drill');
INSERT INTO `Items` (`id`, `name`) VALUES (5, 'Hammer');
INSERT INTO `Items` (`id`, `name`) VALUES (6, 'Saw');
INSERT INTO `Items` (`id`, `name`) VALUES (7, 'Axe');
INSERT INTO `Items` (`id`, `name`) VALUES (8, 'Level');
INSERT INTO `Items` (`id`, `name`) VALUES (9, 'Gloves');
INSERT INTO `Items` (`id`, `name`) VALUES (10, 'Pick Axe');
INSERT INTO `Items` (`id`, `name`) VALUES (11, 'Bobcat');
INSERT INTO `Items` (`id`, `name`) VALUES (12, 'Hazmat Suit');
INSERT INTO `Items` (`id`, `name`) VALUES (13, 'Crutches');
INSERT INTO `Items` (`id`, `name`) VALUES (14, 'Snack');
INSERT INTO `Items` (`id`, `name`) VALUES (15, 'Body Bag');
INSERT INTO `Items` (`id`, `name`) VALUES (16, 'Rope');
INSERT INTO `Items` (`id`, `name`) VALUES (17, 'Garden Shears');
INSERT INTO `Items` (`id`, `name`) VALUES (18, 'Beer');
INSERT INTO `Items` (`id`, `name`) VALUES (19, 'Weed Killer');
INSERT INTO `Items` (`id`, `name`) VALUES (20, 'Toilet Paper');

COMMIT;


-- -----------------------------------------------------
-- Data for table `items_pv`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `items_pv` (`id`, `items_id`, `pv_id`, `quantity`) VALUES (1, 20, 1, 5);
INSERT INTO `items_pv` (`id`, `items_id`, `pv_id`, `quantity`) VALUES (2, 20, 2, 3);
INSERT INTO `items_pv` (`id`, `items_id`, `pv_id`, `quantity`) VALUES (3, 18, 3, 5);
INSERT INTO `items_pv` (`id`, `items_id`, `pv_id`, `quantity`) VALUES (4, 18, 1, 1);
INSERT INTO `items_pv` (`id`, `items_id`, `pv_id`, `quantity`) VALUES (5, 14, 5, 1);
INSERT INTO `items_pv` (`id`, `items_id`, `pv_id`, `quantity`) VALUES (6, 11, 4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `items_project`
-- -----------------------------------------------------
START TRANSACTION;
USE `villagedb`;
INSERT INTO `items_project` (`id`, `project_id`, `item_id`, `quantity_needed`) VALUES (1, 1, 20, 5);
INSERT INTO `items_project` (`id`, `project_id`, `item_id`, `quantity_needed`) VALUES (2, 1, 18, 12);
INSERT INTO `items_project` (`id`, `project_id`, `item_id`, `quantity_needed`) VALUES (3, 1, 14, 5);
INSERT INTO `items_project` (`id`, `project_id`, `item_id`, `quantity_needed`) VALUES (4, 1, 11, 1);
INSERT INTO `items_project` (`id`, `project_id`, `item_id`, `quantity_needed`) VALUES (5, 1, 12, 1);

COMMIT;

