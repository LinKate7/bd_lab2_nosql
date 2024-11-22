DROP DATABASE IF EXISTS publishing;
CREATE DATABASE publishing;
USE publishing;

CREATE TABLE `users` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255),
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `created_at` timestamp
);

CREATE TABLE `genres` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `is_deleted` boolean DEFAULT false
);

CREATE TABLE `authors` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `date_of_birth` date,
  `nationality` varchar(255),
  `biography` text,
  `email` varchar(255),
  `phone` varchar(255),
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `books` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `isbn` varchar(255),
  `genre_id` integer,
  `publish_date` date,
  `number_of_pages` integer,
  `rating` integer,
  `language_id` integer,
  `publisher_id` integer,
  `format_id` integer,
  `edition` varchar(255),
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp,
  `created_at` timestamp
);

CREATE TABLE `publishers` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `address` varchar(255),
  `city` varchar(255),
  `country` varchar(255),
  `email` varchar(255),
  `phone` varchar(255),
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `languages` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `code` varchar(255)
);

CREATE TABLE `book_authors` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `book_id` integer,
  `author_id` integer,
  `contribution_type` varchar(255),
  `is_deleted` boolean DEFAULT false
);

CREATE TABLE `book_editors` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `book_id` integer,
  `editor_id` integer,
  `contribution_type` varchar(255),
  `is_deleted` boolean DEFAULT false
);

CREATE TABLE `editors` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `phone` varchar(255),
  `department` varchar(255),
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `reviews` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `book_id` integer,
  `reviewer_id` integer,
  `rating` integer,
  `review_text` text,
  `review_date` date,
  `is_deleted` boolean DEFAULT false
);

CREATE TABLE `reviewers` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `affiliation` varchar(255)
);

CREATE TABLE `stores` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `address` varchar(255),
  `city` varchar(255),
  `country` varchar(255),
  `website` varchar(255),
  `email` varchar(255),
  `phone` varchar(255),
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `book_stores` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `store_id` integer,
  `book_id` integer,
  `stock_quantity` integer,
  `price` numeric
);

CREATE TABLE `orders` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `customer_id` integer,
  `order_date` date,
  `total_amount` numeric,
  `status` varchar(255),
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `customers` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `address` varchar(255),
  `city` varchar(255),
  `country` varchar(255),
  `phone` varchar(255),
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `order_details` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `order_id` integer,
  `book_id` integer,
  `quantity` integer,
  `unit_price` numeric
);

CREATE TABLE `royalties` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `author_id` integer,
  `book_id` integer,
  `royalty_percentage` decimal,
  `payment_date` date,
  `amount` numeric,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `promotions` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `book_id` integer,
  `start_date` date,
  `end_date` date,
  `discount_percentage` decimal,
  `is_deleted` boolean DEFAULT false,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `contracts` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `author_id` integer,
  `book_id` integer,
  `contract_date` date,
  `expiry_date` date,
  `contract_details` text,
  `last_modified_by` integer,
  `last_modified_at` timestamp
);

CREATE TABLE `formats` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `is_deleted` boolean DEFAULT false
);

ALTER TABLE `authors` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `books` ADD FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`);

ALTER TABLE `books` ADD FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`);

ALTER TABLE `books` ADD FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`);

ALTER TABLE `books` ADD FOREIGN KEY (`format_id`) REFERENCES `formats` (`id`);

ALTER TABLE `books` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `publishers` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `book_authors` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_authors` ADD FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `book_editors` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_editors` ADD FOREIGN KEY (`editor_id`) REFERENCES `editors` (`id`);

ALTER TABLE `editors` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`reviewer_id`) REFERENCES `reviewers` (`id`);

ALTER TABLE `stores` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `book_stores` ADD FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

ALTER TABLE `book_stores` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `royalties` ADD FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `royalties` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `royalties` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `promotions` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `promotions` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);

ALTER TABLE `contracts` ADD FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `contracts` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `contracts` ADD FOREIGN KEY (`last_modified_by`) REFERENCES `users` (`id`);
