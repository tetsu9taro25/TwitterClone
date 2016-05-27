DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_id` INTEGER UNSIGNED NOT NULL,
  `text` TEXT NOT NULL,
  `image` VARCHAR(255),
  `mention` INTEGER,
  `deleted` TINYINT NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` INTEGER UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `screen_name` VARCHAR(255) UNIQUE NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `mail` VARCHAR(255),
  `password` TEXT NOT NULL,
  `text` TEXT,
  `image` VARCHAR(255),
  `deleted` TINYINT NOT NULL NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` INTEGER UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_id` INTEGER UNSIGNED NOT NULL,
  `follow_user_id` INTEGER UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `mention`;
CREATE TABLE `mention` (
  `id` INTEGER UNSIGNED UNIQUE NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `message_id` INTEGER UNSIGNED NOT NULL,
  `mention` INTEGER UNSIGNED NOT NULL
)
