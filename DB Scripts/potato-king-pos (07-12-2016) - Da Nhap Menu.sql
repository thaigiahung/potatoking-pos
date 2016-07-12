-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2016 at 04:07 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `potato-king-pos`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parentCategory` int(11) DEFAULT NULL,
  `nameEn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`name`, `description`, `status`, `parentCategory`, `nameEn`, `image`, `id`, `createdAt`, `updatedAt`) VALUES
('Món Chiên', 'Bánh', 'enable', NULL, 'Fries', '/img/template/category/fries.jpg', 1, '2016-04-04 02:53:00', '2016-04-17 17:20:45'),
('Khoai Tây', 'S?t description', 'enable', 1, 'Potato', NULL, 2, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Đồ Chiên', 'L?c Description', 'enable', 1, 'Fries', NULL, 3, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Potato Dishes', 'Potato Dishes', 'enable', 2, 'Potato Dishes', NULL, 4, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Sốt', 'Sause', 'enable', 2, 'Sauce', NULL, 5, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Lắc', 'Shake', 'enable', 2, 'Shake', NULL, 6, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Fries Dishes', 'Fries Dishes', 'enable', 3, 'Fries Dishes', NULL, 7, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Sốt', 'Sauce', 'enable', 3, 'Sauce', NULL, 8, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Mini Burger', '', 'enable', NULL, 'Mini Burger', '/img/template/category/burger.jpg', 16, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Mini Taco', '', 'enable', NULL, 'Mini Taco', '/img/template/category/taco.jpg', 17, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Mini Sandwich', '', 'enable', NULL, 'Mini Sandwich', '', 18, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Mini Pancake', '', 'enable', NULL, 'Mini Pancake', '', 19, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Combo', '', 'enable', NULL, 'Combo', '/img/template/category/combo.jpg', 20, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Special', '', 'enable', NULL, 'Special', NULL, 21, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Salad & Soup', '', 'enable', NULL, 'Món Ăn Kèm', '', 22, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Drink', '', 'enable', NULL, 'Drink', '/img/template/category/drink.jpg', 23, '2016-04-04 02:53:00', '2016-04-04 02:53:00');

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE IF NOT EXISTS `device` (
  `mac` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `table` int(11) DEFAULT NULL,
  `connecting` tinyint(1) DEFAULT NULL,
  `socketId` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opening` tinyint(1) DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`mac`, `table`, `connecting`, `socketId`, `status`, `opening`, `id`, `createdAt`, `updatedAt`) VALUES
(NULL, 1, 0, 'yRB418MsPAjH0Fu8TJKs', 'enable', 0, 2, '2016-08-17 10:56:00', '2016-07-12 12:51:28'),
(NULL, 2, 0, 'GUPZJzP3M3EG89ZOTJKu', 'enable', 0, 3, '2016-05-13 02:08:00', '2016-07-12 19:06:31'),
(NULL, 3, 0, 'zQ72TdShH470DcwCjzmL', 'enable', 0, 4, '2018-01-20 06:42:00', '2016-07-09 16:01:59'),
(NULL, 4, 0, 'EnHXKDfl6RXNqYVBwrWl', 'enable', 0, 5, '2016-01-12 04:21:00', '2016-07-10 15:37:45'),
(NULL, 5, 0, 'orOq0Tha2PvtJJK-QQI8', 'enable', 0, 6, '2015-12-30 13:18:00', '2016-07-10 17:11:49'),
(NULL, 7, 0, 'guqdVn0ZCoBayx0Wjzl9', 'enable', 0, 7, '2015-12-31 07:09:00', '2016-07-09 14:55:01'),
(NULL, 9, 0, NULL, 'enable', 0, 8, '2015-12-29 02:53:00', '2015-12-29 02:53:00'),
(NULL, 8, 0, NULL, 'enable', 0, 9, '2015-12-29 02:53:00', '2015-12-29 02:53:00'),
(NULL, 100, 0, 'HJ6Q8TRpij71Hvo_TJKZ', 'enable', 0, 10, '2016-04-27 16:14:00', '2016-07-12 12:51:28'),
(NULL, 101, 1, 'TJ5LVzQCk9GfXFzoTJLb', 'enable', 0, 11, '2016-06-30 22:06:00', '2016-07-12 21:06:30'),
(NULL, 102, 0, 'WGF6RVZEbslzgzNzTJKv', 'enable', 0, 12, '2016-04-19 22:23:00', '2016-07-12 13:13:21');

-- --------------------------------------------------------

--
-- Table structure for table `deviceip`
--

CREATE TABLE IF NOT EXISTS `deviceip` (
  `device` int(11) DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `deviceip`
--

INSERT INTO `deviceip` (`device`, `ip`, `type`, `id`, `createdAt`, `updatedAt`) VALUES
(11, '127.0.0.1', 'guest', 4, '2016-01-29 02:53:00', '2016-01-29 02:53:00'),
(10, '192.168.1.18', 'cashier', 5, '2016-01-29 02:53:00', '2016-01-29 02:53:00'),
(2, '192.168.1.11', 'guest', 6, '2016-02-12 02:53:00', '2016-02-12 02:53:00'),
(3, '192.168.1.12', 'guest', 17, '2016-05-23 00:00:00', '2016-05-23 00:00:00'),
(4, '192.168.1.13', 'guest', 19, '2016-04-27 13:46:00', '2016-04-27 13:46:00'),
(5, '192.168.1.14', 'guest', 20, '2016-04-27 13:46:00', '2016-04-27 13:46:00'),
(6, '192.168.1.15', 'guest', 21, '2016-04-27 13:46:00', '2016-04-27 13:46:00'),
(12, '192.168.1.21', 'chief-cook', 22, '2016-01-29 02:53:00', '2016-01-29 02:53:00');

-- --------------------------------------------------------

--
-- Table structure for table `dish`
--

CREATE TABLE IF NOT EXISTS `dish` (
  `category` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nameEn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `price` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `mainImage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `dish`
--

INSERT INTO `dish` (`category`, `name`, `nameEn`, `description`, `price`, `status`, `order`, `mainImage`, `id`, `createdAt`, `updatedAt`) VALUES
(1, 'Con tôm', 'Con tôm', 'Taco bò bbvv', 60000, 'enable', NULL, '/img/template/no-image.jpg', 1, '2016-01-02 02:53:00', '2016-04-17 17:20:45'),
(2, 'Mùi mùi mùi', NULL, 'Taco Heo', 15000, 'disable', NULL, '/img/template/no-image.jpg', 2, '2016-01-02 02:53:00', '2016-04-15 18:09:44'),
(1, 'Taco Gà', NULL, 'Taco Gà', 15000, 'enable', NULL, '/img/template/no-image.jpg', 3, '2016-01-02 02:53:00', '2016-04-16 19:41:35'),
(2, 'Taco M?c55', NULL, 'Taco M?c', 15000, 'enable', NULL, '/img/template/no-image.jpg', 4, '2016-01-02 02:53:00', '2016-04-16 03:37:09'),
(2, 'V? Phô Mai', NULL, 'V? Phô Mai44', 20000, 'enable', NULL, '/img/template/no-image.jpg', 5, '2016-01-02 02:53:00', '2016-04-16 03:38:25'),
(2, 'Testing2', NULL, 'V? T? Nhiên V? T? Nhiên V? T? Nhiên ', 20000, 'enable', NULL, '/img/template/no-image.jpg', 6, '2016-01-02 02:53:00', '2016-04-16 19:53:28'),
(1, '2323', NULL, '', 2323, 'disable', NULL, '/img/template/no-image.jpg', 7, '2016-04-15 17:27:10', '2016-04-15 17:27:10'),
(3, 'Dip1', NULL, '', 22357, 'enable', NULL, '/img/template/no-image.jpg', 8, '2016-04-15 17:28:25', '2016-04-15 21:54:54'),
(3, 'Dip2', NULL, '', 555, 'enable', NULL, '/img/template/no-image.jpg', 10, '2016-04-15 21:57:05', '2016-04-16 03:38:17'),
(4, 'French Fries 1', 'French Fries En', '                        <div class="row-fluid">\n                            <div class="span4">something here something something something something something </div>\n                            <div class="span8">Some other things here\n                                <ul>\n                                    <li>What will stay here</li>\n                                    <li>What will stay here</li>\n                                    <li>What will stay here</li>\n                                </ul>\n                            </div>\n                        </div>\n                        <b>Something ball</b> \n                        Add something something something something something something something something something something something something something something something something something something something something something something something something something something something something something ', 45, 'disable', NULL, '/img/template/sub-category/french-fries.png', 11, '2016-04-15 21:58:58', '2016-04-15 21:58:58'),
(4, 'Shake 2', 'Shake Name En', '', 55, 'disable', NULL, '/img/template/no-image.jpg', 12, '2016-04-15 22:00:37', '2016-04-16 19:53:19'),
(4, 'Shake 3', 'Shake Name En', '', 33, 'disable', NULL, '/img/template/no-image.jpg', 13, '2016-04-16 19:53:34', '2016-04-16 19:53:34'),
(1, '55', NULL, '', 55, 'disable', NULL, '/img/template/no-image.jpg', 14, '2016-04-16 19:54:11', '2016-04-16 19:54:11'),
(2, '444', NULL, '', 444, 'enable', NULL, '/img/template/no-image.jpg', 15, '2016-04-16 20:21:06', '2016-04-16 20:21:06'),
(16, 'Thịt Bò (3 cái)', 'Beef', '', 49000, 'enable', 1, '/img/template/dish/burger.png', 16, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Khoai Cắt Thẳng', 'Shoe String', '', 25000, 'enable', 1, '/img/template/sub-category/french-fries.png', 17, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Curly Fries', 'Curly FriesEn', 'Curly Fries', 25000, 'disable', 1, '/img/template/sub-category/curly-fries.png', 18, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Khoai Răng Cưa', 'Crinkle Fries', '', 25000, 'enable', 1, '/img/template/sub-category/crinkle-fries.png', 19, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Khoai Cắt Múi', 'Potato Wedges', '', 25000, 'enable', 1, '/img/template/sub-category/potato-wedges.png', 20, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Mayonnaise', 'Classic Mayonnaise', '', 5000, 'enable', 1, '/img/template/dish/cheese.png', 21, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Mayo Kiểu Việt', 'Vietnamese Style Mayo', '', 10000, 'enable', 1, '/img/template/dish/cheese.png', 22, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Mayo Parisian', 'Parisian Sauce', '', 10000, 'enable', 1, '/img/template/dish/cheese.png', 23, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt Cay Vị Hành Tây', 'Spicy fry sauce', '', 10000, 'enable', 1, '/img/template/dish/cheese2.png', 24, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Phô Mai Cay', 'Hot & Spicy Cheese', '', 12000, 'enable', 1, '/img/template/dish/cheese.png', 25, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Phô mai', 'Cheese sause', '', 12000, 'enable', 1, '/img/template/dish/cheese.png', 26, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Cari', 'Indian Curry Style', '', 12000, 'enable', 10, '/img/template/dish/cheese4.png', 27, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', '', 50000, 'disable', 1, '/img/template/dish/cheese5.png', 28, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', '', 50000, 'disable', 1, '/img/template/dish/cheese3.png', 29, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Phô mai', 'Cheese', '', 5000, 'enable', 1, '/img/template/dish/cheese2.png', 30, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Phô Mai Cay', 'Hot & Spicy Cheese', '', 5000, 'enable', 1, '/img/template/dish/cheese3.png', 31, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Rong Biển', 'Seaweed', '', 10000, 'enable', 1, '/img/template/dish/cheese2.png', 32, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Rong Biển Cay Kiểu Nhật', 'Seaweed with Wasabi', '', 10000, 'enable', 1, '/img/template/dish/cheese4.png', 33, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Mù Tạt', 'Wasabi', '', 10000, 'enable', 1, '/img/template/dish/cheese5.png', 34, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bò Lúc Lắc Cay', 'Hot & Spicy Beef', '', 10000, 'enable', 1, '/img/template/dish/cheese2.png', 35, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Vị Truyền Thống (Muối)', 'Salty Original French Fries', '', 0, 'enable', 1, '/img/template/dish/cheese.png', 36, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', '', 50000, 'disable', 1, '/img/template/dish/cheese2.png', 37, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', '', 50000, 'disable', 1, '/img/template/dish/cheese5.png', 38, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', '', 50000, 'disable', 1, '/img/template/dish/cheese2.png', 39, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Xúc Xích Bung Xòe', 'Octo Style Sausage', '', 20000, 'enable', 1, '/img/template/dish/onion-ring.png', 40, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Xúc Xích Corn Dog', 'Corn Dog Sausage', '', 25000, 'enable', 1, '/img/template/dish/fish-nugget.png', 41, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Tôm Bọc Khoai Tây', 'Shirmp Potato Balls', '', 25000, 'enable', 1, '/img/template/dish/shrimp-fries.png', 42, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Khoai Tây Viên Nhân Phô Mai', 'Cheese Potato Balls', '', 30000, 'enable', 1, '/img/template/no-image.jpg', 43, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 457', 'Testing Fries 457 En', 'Testing Fries 457 Description', 50000, 'disable', 1, '/img/template/no-image.jpg', 44, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 929', 'Testing Fries 929 En', 'Testing Fries 929 Description', 50000, 'disable', 1, '/img/template/no-image.jpg', 45, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 775', 'Testing Fries 775 En', 'Testing Fries 775 Description', 50000, 'disable', 1, '/img/template/no-image.jpg', 46, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Mayonnaise', 'Classic Mayonnaise', '', 5000, 'enable', 1, '/img/template/dish/cheese2.png', 47, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Không Sốt', 'None', '', 0, 'enable', 1, '/img/template/dish/cheese.png', 48, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 198 Description', 50000, 'disable', 1, '/img/template/dish/cheese3.png', 49, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 530 Description', 50000, 'disable', 1, '/img/template/dish/cheese4.png', 50, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 396 Description', 50000, 'disable', 1, '/img/template/dish/cheese5.png', 51, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(17, 'Taco Bò (Vỏ Giòn)', 'Beef Taco (Crunchy)', '', 17000, 'enable', 1, '/img/template/dish/taco.png', 52, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(18, 'Trứng & Thịt Nguội', 'Egg & Cold Cuts', '', 30000, 'enable', 1, '/img/template/dish/salad.png', 53, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(16, 'Thịt Gà (3 cái)', 'Chicken', '', 45000, 'enable', 1, '/img/template/dish/burger.png', 54, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(17, 'Taco Bò (Vỏ Mềm)', 'Beef Taco (Soft)', '', 17000, 'enable', 1, '/img/template/dish/taco.png', 55, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(17, 'Taco Gà (Vỏ Giòn)', 'Chicken Taco (Crunchy)', '', 15000, 'enable', 1, '/img/template/dish/taco.png', 56, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(17, 'Taco Gà (Vỏ Mềm)', 'Chicken Taco (Soft)', '', 15000, 'enable', 1, '/img/template/dish/taco.png', 57, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(18, 'Cá Ngừ Mayo', 'Tuna & Mayo', '', 30000, 'enable', 1, '/img/template/dish/taco.png', 58, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(19, 'Dâu', 'Strawberry', '', 12000, 'enable', 1, '/img/template/dish/taco.png', 59, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(19, 'Socola', 'Chocolate', '', 12000, 'enable', 1, '/img/template/dish/taco.png', 60, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(22, 'Salad Trái Cây Nga', 'Russian Fruit Salad', '', 25000, 'enable', 1, '/img/template/dish/taco.png', 61, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(22, 'Salad Bắp Cải - Xúc Xích - Sốt Mè Rang', 'Cabbage & Sausage Salad', '', 35000, 'enable', 1, '/img/template/dish/taco.png', 62, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(22, 'Salad Tôm Sốt Mayo', 'Shrimp & Mayo Salad', '', 30000, 'enable', 1, '/img/template/dish/taco.png', 63, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(22, 'Súp Gà Rau Củ', 'Chicken Soup', '', 15000, 'enable', 1, '/img/template/dish/taco.png', 64, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(22, 'Nghêu', 'Clam Soup', '', 30000, 'enable', 1, '/img/template/dish/taco.png', 65, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(23, 'Pepsi Ly', 'Pepsi', '', 10000, 'enable', 1, '/img/template/dish/taco.png', 66, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(23, 'Pepsi Lon', 'Pepsi', '', 20000, 'enable', 1, '/img/template/dish/taco.png', 67, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(23, 'Mirinda Lon', 'Mirinda', '', 20000, 'enable', 1, '/img/template/dish/taco.png', 68, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(23, '7up Lon', '7up', '', 20000, 'enable', 1, '/img/template/dish/taco.png', 69, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(23, 'Nước Suối', 'Water', '', 10000, 'enable', 1, '/img/template/dish/taco.png', 70, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(23, 'Pepsi 1.5L', 'Pepsi', '', 45000, 'enable', 1, '/img/template/dish/taco.png', 71, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(21, 'Khoai Tây Chiên Phủ Sốt Cary Bò', 'French Fries in Beef Curry Sauce', '', 50000, 'enable', 1, '/img/template/dish/taco.png', 72, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(21, 'Khoai Tây Phô Mai Đút Lò', 'Baked Potato with Cheese', '', 45000, 'enable', 1, '/img/template/dish/taco.png', 73, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(20, 'Trẻ Em', 'For Kid', '', 70000, 'enable', 1, '/img/template/dish/taco.png', 74, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(20, '2 Người', 'Couple', '', 110000, 'enable', 1, '/img/template/dish/taco.png', 75, '2016-04-17 17:20:45', '2016-04-17 17:20:45');

-- --------------------------------------------------------

--
-- Table structure for table `dishimage`
--

CREATE TABLE IF NOT EXISTS `dishimage` (
  `dish` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=953 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `dishimage`
--

INSERT INTO `dishimage` (`dish`, `url`, `status`, `id`, `createdAt`, `updatedAt`) VALUES
(1, '/images/Dishes/1/3.jpg', 'enable', 27, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(5, '/images/Dishes/5/1.jpg', 'enable', 146, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(4, '/images/Dishes/4/1.jpg', 'enable', 167, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(7, '/images/Dishes/7/2.jpg', 'enable', 168, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(6, '/images/Dishes/6/1.jpg', 'enable', 247, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(2, '/images/Dishes/2/3.jpg', 'enable', 256, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(2, '/images/Dishes/2/2.jpg', 'enable', 265, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(7, '/images/Dishes/7/3.jpg', 'enable', 293, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(3, '/images/Dishes/3/2.jpg', 'enable', 334, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(4, '/images/Dishes/4/3.jpg', 'enable', 400, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(5, '/images/Dishes/5/3.jpg', 'enable', 413, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(4, '/images/Dishes/4/2.jpg', 'enable', 418, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(3, '/images/Dishes/3/3.jpg', 'enable', 440, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(6, '/images/Dishes/6/2.jpg', 'enable', 456, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(8, '/images/Dishes/8/1.jpg', 'enable', 545, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(5, '/images/Dishes/5/2.jpg', 'enable', 636, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(3, '/images/Dishes/3/1.jpg', 'enable', 675, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(7, '/images/Dishes/7/1.jpg', 'enable', 690, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(6, '/images/Dishes/6/3.jpg', 'enable', 712, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(8, '/images/Dishes/8/2.jpg', 'enable', 752, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(1, '/images/Dishes/1/1.jpg', 'enable', 805, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(8, '/images/Dishes/8/3.jpg', 'enable', 810, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(2, '/images/Dishes/2/1.jpg', 'enable', 923, '2016-04-02 13:11:01', '2016-04-02 13:11:01'),
(1, '/images/Dishes/1/2.jpg', 'enable', 952, '2016-04-02 13:11:01', '2016-04-02 13:11:01');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE IF NOT EXISTS `permission` (
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE IF NOT EXISTS `price` (
  `dish` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`dish`, `name`, `price`, `id`, `createdAt`, `updatedAt`) VALUES
(11, 'Large', 494949, 19, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(12, 'Large', 494949, 20, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(13, 'Large', 494949, 21, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(17, 'Large', 30000, 22, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(18, 'Large', 30000, 23, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(19, 'Large', 30000, 24, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(20, 'Large', 30000, 25, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(40, 'Large', 494949, 26, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(41, 'Large', 494949, 27, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(42, 'Large', 494949, 28, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(43, 'Large', 494949, 29, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(44, 'Large', 494949, 30, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(45, 'Large', 494949, 31, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(46, 'Large', 494949, 32, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(11, 'Jumbo', 6000000, 33, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(12, 'Jumbo', 6000000, 34, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(13, 'Jumbo', 6000000, 35, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(17, 'Jumbo', 40000, 36, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(18, 'Jumbo', 40000, 37, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(19, 'Jumbo', 40000, 38, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(20, 'Jumbo', 40000, 39, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(40, 'Jumbo', 6000000, 40, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(41, 'Jumbo', 6000000, 41, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(42, 'Jumbo', 6000000, 42, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(43, 'Jumbo', 6000000, 43, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(44, 'Jumbo', 6000000, 44, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(45, 'Jumbo', 6000000, 45, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(46, 'Jumbo', 6000000, 46, '2016-04-10 03:32:00', '2016-04-10 03:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `table` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `receive` int(11) DEFAULT NULL,
  `change` int(11) DEFAULT NULL,
  `paymentStatus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deliveryType` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessiondetail`
--

CREATE TABLE IF NOT EXISTS `sessiondetail` (
  `session` int(11) DEFAULT NULL,
  `dish` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessiondevice`
--

CREATE TABLE IF NOT EXISTS `sessiondevice` (
  `device` int(11) DEFAULT NULL,
  `session` int(11) DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `device`
--
ALTER TABLE `device`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deviceip`
--
ALTER TABLE `deviceip`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dish`
--
ALTER TABLE `dish`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dishimage`
--
ALTER TABLE `dishimage`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessiondetail`
--
ALTER TABLE `sessiondetail`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessiondevice`
--
ALTER TABLE `sessiondevice`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `device`
--
ALTER TABLE `device`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `deviceip`
--
ALTER TABLE `deviceip`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `dish`
--
ALTER TABLE `dish`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `dishimage`
--
ALTER TABLE `dishimage`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=953;
--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT for table `sessiondetail`
--
ALTER TABLE `sessiondetail`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=245;
--
-- AUTO_INCREMENT for table `sessiondevice`
--
ALTER TABLE `sessiondevice`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=72;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
