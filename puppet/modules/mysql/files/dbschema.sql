-- create database for the dynamic site
CREATE DATABASE IF NOT EXISTS dynamic;

-- grant only the necessary privileges to our new user
GRANT ALL PRIVILEGES ON dynamic.* TO 'root'@'%';

-- make this our active database
USE dynamic;

-- create a table to store our wish list items
DROP TABLE IF EXISTS `WishListItem`;
CREATE TABLE IF NOT EXISTS `WishListItem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(255),

  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- start with some data in the table
INSERT INTO WishListItem (name, description) VALUES ('Pro Puppet book', 'I wanna be a Puppet pro.');
INSERT INTO WishListItem (name, description) VALUES ('Red Rider BB Gun', 'I will NOT shoot my eye out.');
INSERT INTO WishListItem (name, description) VALUES ('Soccer cleats', 'For ultimate frisbee. Good luck finding a size 14.');
