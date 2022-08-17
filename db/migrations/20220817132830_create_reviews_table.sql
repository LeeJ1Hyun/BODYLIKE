-- migrate:up
CREATE TABLE `reviews` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `contents` varchar(3000)  NOT NULL,
  `created_at` timestamp  NOT NULL,
  `updated_at` timestamp,
  `product_id` int  NOT NULL,
  `user_id` int  NOT NULL,
  CONSTRAINT `reviews_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);
-- migrate:down
DROP TABLE reviews;
