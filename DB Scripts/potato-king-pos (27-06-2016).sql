-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 26, 2016 at 06:01 AM
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
  `name` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf16_unicode_ci,
  `status` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `parentCategory` int(11) DEFAULT NULL,
  `nameEn` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`name`, `description`, `status`, `parentCategory`, `nameEn`, `image`, `id`, `createdAt`, `updatedAt`) VALUES
('Món Chiên', 'Bánh', 'enable', NULL, 'Fries', '/img/template/category/fries.jpg', 1, '2016-04-04 09:46:00', '2016-04-18 00:13:45'),
('Khoai Tây', 'S?t description', 'enable', 1, 'Potato', NULL, 2, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Đồ Chiên', 'L?c Description', 'enable', 1, 'Fries', NULL, 3, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Potato Dishes', 'Potato Dishes', 'enable', 2, 'Potato Dishes', NULL, 4, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Sốt', 'Sause', 'enable', 2, 'Sauce', NULL, 5, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Lắc', 'Shake', 'enable', 2, 'Shake', NULL, 6, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Fries Dishes', 'Fries Dishes', 'enable', 3, 'Fries Dishes', NULL, 7, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Sốt', 'Sauce', 'enable', 3, 'Sauce', NULL, 8, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Mini Burger', '', 'enable', NULL, 'Mini Burger', '/img/template/category/burger.jpg', 16, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Mini Taco', '', 'enable', NULL, 'Mini Taco', '/img/template/category/taco.jpg', 17, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Mini Sandwich', '', 'enable', NULL, 'Mini Sandwich', '/img/template/category/sadwich-tab.jpg', 18, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Mini Pancake', '', 'enable', NULL, 'Mini Pancake', '/img/template/category/pancake-tab.jpg', 19, '2016-04-04 09:46:00', '2016-07-23 09:34:26'),
('Combo', '', 'enable', NULL, 'Combo', '/img/template/category/combo.jpg', 20, '2016-04-04 09:46:00', '2016-07-23 09:34:58'),
('Special', '', 'enable', NULL, 'Special', '/img/template/category/khoai-tay-phu-cary-bo.png', 21, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Salad & Soup', '', 'enable', NULL, 'Món Ăn Kèm', '/img/template/category/soupsalad.jpg', 22, '2016-04-04 09:46:00', '2016-04-04 09:46:00'),
('Drink', '', 'enable', NULL, 'Drink', '/img/template/category/drink.jpg', 23, '2016-04-04 09:46:00', '2016-04-04 09:46:00');

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE IF NOT EXISTS `device` (
  `mac` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `table` int(11) DEFAULT NULL,
  `connecting` tinyint(1) DEFAULT NULL,
  `socketId` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `opening` tinyint(1) DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`mac`, `name`, `table`, `connecting`, `socketId`, `status`, `opening`, `id`, `createdAt`, `updatedAt`) VALUES
(NULL, 'Máy 1', 1, 0, 'euRgX7M32JwFqDrVy9hz', 'enable', 0, 2, '2016-10-07 12:10:00', '2016-07-26 10:50:13'),
(NULL, 'Máy 2', 2, 0, 'RizB0ouhDzOPMmdty9hs', 'enable', 0, 3, '2016-07-18 01:18:00', '2016-07-26 10:50:13'),
(NULL, 'Máy 3', 3, 0, 'dXbsGlDQvsL1zGA4y9gU', 'enable', 0, 4, '2018-02-03 14:52:00', '2016-07-26 10:50:13'),
(NULL, 'Máy 4', 4, 0, '9V_UTNqInK9Qly0jy9hZ', 'enable', 0, 5, '2016-02-11 20:52:00', '2016-07-26 10:50:13'),
(NULL, 'Máy 5', 5, 0, 'Lbb4TbPRdC2neqaHjJ0Q', 'enable', 0, 6, '2016-01-09 14:13:00', '2016-07-24 13:42:19'),
(NULL, 'Máy 6', 6, 0, 'WF2jny4nSKC8zVuxjJ0A', 'enable', 0, 7, '2016-02-11 04:07:00', '2016-07-24 14:44:33'),
(NULL, 'Máy 7', 7, 0, '5CkXlN3detwsjKJrajis', 'enable', 0, 8, '2016-01-14 18:07:00', '2016-07-15 20:25:37'),
(NULL, 'Máy 8', 8, 0, NULL, 'enable', 0, 9, '2015-12-29 09:46:00', '2015-12-29 09:46:00'),
(NULL, 'Cashier', 100, 0, 'g6118u0Hlt1NKFTry9h0', 'enable', 0, 10, '2016-08-22 02:52:00', '2016-07-26 10:50:13'),
(NULL, 'Server', 101, 1, 'molOKUIBVNr_Ri_dy9h3', 'enable', 0, 11, '2016-08-16 09:12:00', '2016-07-26 11:00:15'),
(NULL, 'Chief-cook', 102, 0, 'Ghxc1n9BQ3n34rWHy9hj', 'enable', 0, 12, '2016-07-31 14:37:00', '2016-07-25 20:58:50');

-- --------------------------------------------------------

--
-- Table structure for table `deviceip`
--

CREATE TABLE IF NOT EXISTS `deviceip` (
  `device` int(11) DEFAULT NULL,
  `ip` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `deviceip`
--

INSERT INTO `deviceip` (`device`, `ip`, `type`, `id`, `createdAt`, `updatedAt`) VALUES
(11, '127.0.0.1', 'chief-cook', 4, '2016-01-29 09:46:00', '2016-01-29 09:46:00'),
(10, '192.168.1.17', 'cashier', 5, '2016-01-29 09:46:00', '2016-01-29 09:46:00'),
(2, '192.168.1.11', 'guest', 6, '2016-02-12 09:46:00', '2016-02-12 09:46:00'),
(3, '192.168.1.12', 'guest', 17, '2016-05-23 06:53:00', '2016-05-23 06:53:00'),
(4, '192.168.1.13', 'guest', 19, '2016-04-27 20:39:00', '2016-04-27 20:39:00'),
(5, '192.168.1.14', 'guest', 20, '2016-04-27 20:39:00', '2016-04-27 20:39:00'),
(6, '192.168.1.15', 'guest', 21, '2016-04-27 20:39:00', '2016-04-27 20:39:00'),
(12, '192.168.1.21', 'chief-cook', 22, '2016-01-29 09:46:00', '2016-01-29 09:46:00'),
(7, '192.168.1.16', 'guest', 23, '2016-04-27 20:39:00', '2016-04-27 20:39:00'),
(8, '192.168.1.19', 'guest', 24, '2016-04-27 20:39:00', '2016-04-27 20:39:00');

-- --------------------------------------------------------

--
-- Table structure for table `dish`
--

CREATE TABLE IF NOT EXISTS `dish` (
  `category` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `nameEn` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf16_unicode_ci,
  `price` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `mainImage` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `dish`
--

INSERT INTO `dish` (`category`, `name`, `nameEn`, `description`, `price`, `status`, `order`, `mainImage`, `id`, `createdAt`, `updatedAt`) VALUES
(16, 'Thịt Bò (3 cái)', 'Beef', '', 49000, 'enable', 1, '/img/template/dish/burger/mini-burger.png', 16, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(4, 'Khoai Cắt Thẳng', 'Shoe String', '', 25000, 'enable', 1, '/img/template/sub-category/shoe-string.png', 17, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(4, 'Curly Fries', 'Curly FriesEn', 'Curly Fries', 25000, 'disable', 1, '/img/template/sub-category/curly-fries.png', 18, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(4, 'Khoai Răng Cưa', 'Crinkle Fries', '', 25000, 'enable', 1, '/img/template/sub-category/crinkle-fries.png', 19, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(4, 'Khoai Cắt Múi', 'Potato Wedges', '', 25000, 'enable', 1, '/img/template/sub-category/potato-wedges.png', 20, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Mayonnaise', 'Classic Mayo', '', 5000, 'enable', 1, '/img/template/sauce/mayonnaise.png', 21, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Mayo Kiểu Việt', 'Vietnamese Style Mayo', '', 10000, 'enable', 1, '/img/template/sauce/mayo-kieu-Viet.png', 22, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Mayo Parisian', 'Parisian Sauce', '', 10000, 'enable', 1, '/img/template/sauce/mayo-parisian.png', 23, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Sốt Cay Vị Hành Tây', 'Spicy fry sauce', '', 10000, 'enable', 1, '/img/template/sauce/sot-cay-vi-hanh-tay.png', 24, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Sốt Phô Mai Cay', 'Hot & Spicy Cheese', '', 12000, 'enable', 1, '/img/template/sauce/sot-phomai-cay.png', 25, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Sốt Phô mai', 'Cheese sause', '', 12000, 'enable', 1, '/img/template/sauce/sot-phomai.png', 26, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(5, 'Sốt Cari', 'Indian Curry Style', '', 12000, 'enable', 10, '/img/template/sauce/sot-carri.png', 27, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Bột Phô mai', 'Cheese', '', 5000, 'enable', 1, '/img/template/sauce/phomai.png', 30, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Bột Phô Mai Cay', 'Hot & Spicy Cheese', '', 5000, 'enable', 1, '/img/template/sauce/bot-pho-mai-cay.png', 31, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Bột Rong Biển', 'Seaweed', '', 10000, 'enable', 1, '/img/template/sauce/rong-bien.png', 32, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Bột Rong Biển Cay Kiểu Nhật', 'Seaweed with Wasabi', '', 10000, 'enable', 1, '/img/template/sauce/rong-bien-cay-kieu-nhat.png', 33, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Bột Mù Tạt', 'Wasabi', '', 10000, 'enable', 1, '/img/template/sauce/bot-wasabi.png', 34, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Bột Bò Lúc Lắc Cay', 'Hot & Spicy Beef', '', 10000, 'enable', 1, '/img/template/sauce/bot-bo-cay.png', 35, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(6, 'Vị Truyền Thống (Muối)', 'Salty Original French Fries', '', 0, 'enable', 1, '/img/template/sauce/muoi.png', 36, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(7, 'Xúc Xích Bung Xòe', 'Octo Style Sausage', '', 20000, 'enable', 1, '/img/template/dish/fries/xuc-xich-bung-xoe.png', 40, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(7, 'Xúc Xích Corn Dog', 'Corn Dog Sausage', '', 25000, 'disable', 1, '/img/template/dish/fries/xuc-xich-corndog.png', 41, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(7, 'Tôm Bọc Khoai Tây', 'Shirmp Potato Balls', '', 30000, 'disable', 1, '/img/template/dish/fries/shrimp-potato-balls.png', 42, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(7, 'Khoai Tây Viên Nhân Phô Mai', 'Cheese Potato Balls', '', 30000, 'disable', 1, '/img/template/dish/fries/cheese-potato-balls.png', 43, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(8, 'Mayonnaise', 'Classic Mayonnaise', '', 5000, 'enable', 1, '/img/template/sauce/mayonnaise.png', 47, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(8, 'Vị Truyền Thống', 'Salty Original', '', 0, 'enable', 1, '/img/template/sauce/muoi.png', 48, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(17, 'Taco Bò (Vỏ Giòn)', 'Beef Taco (Crunchy)', '', 17000, 'enable', 1, '/img/template/dish/taco/taco-vo-gion.png', 52, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(18, 'Trứng & Thịt Nguội', 'Egg & Cold Cuts', '', 30000, 'enable', 1, '/img/template/dish/sandwich/sandwich.png', 53, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(16, 'Thịt Gà (3 cái)', 'Chicken', '', 45000, 'enable', 1, '/img/template/dish/burger/mini-burger.png', 54, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(17, 'Taco Bò (Vỏ Mềm)', 'Beef Taco (Soft)', '', 17000, 'enable', 1, '/img/template/dish/taco/taco-vo-mem.png', 55, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(17, 'Taco Gà (Vỏ Giòn)', 'Chicken Taco (Crunchy)', '', 15000, 'enable', 1, '/img/template/dish/taco/taco-vo-gion.png', 56, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(17, 'Taco Gà (Vỏ Mềm)', 'Chicken Taco (Soft)', '', 15000, 'enable', 1, '/img/template/dish/taco/taco-vo-mem.png', 57, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(18, 'Cá Ngừ Mayo', 'Tuna & Mayo', '', 30000, 'enable', 1, '/img/template/dish/sandwich/sandwich.png', 58, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(19, 'Pancake dâu', 'Strawberry', '', 12000, 'enable', 1, '/img/template/dish/pancake/pancakes-dau.png', 59, '2016-04-18 00:13:45', '2016-07-23 09:37:47'),
(19, 'Pancake chocolate', 'Chocolate', '', 12000, 'enable', 1, '/img/template/dish/pancake/pancakes-chocolate.png', 60, '2016-04-18 00:13:45', '2016-07-23 09:37:18'),
(22, 'Salad Trái Cây Nga', 'Russian Fruit Salad', '', 35000, 'enable', 1, '/img/template/dish/salad-soup/salad-trai-cay.png', 61, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(22, 'Salad Bắp Cải - Xúc Xích - Sốt Mè Rang', 'Cabbage & Sausage Salad', '', 35000, 'enable', 1, '/img/template/dish/salad-soup/salad-bap-cai.png', 62, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(22, 'Salad Tôm Sốt Mayo', 'Shrimp & Mayo Salad', '', 30000, 'enable', 1, '/img/template/dish/salad-soup/salad-tom.png', 63, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(22, 'Súp Gà Rau Củ', 'Chicken Soup', '', 15000, 'enable', 1, '/img/template/no-image.jpg', 64, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(22, 'Súp Nghêu', 'Clam Soup', '', 30000, 'disable', 1, '/img/template/no-image.jpg', 65, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(23, 'Pepsi Ly', 'Pepsi', '', 10000, 'enable', 1, '/img/template/drink/pepsi-ly.png', 66, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(23, 'Pepsi Lon', 'Pepsi', '', 20000, 'enable', 1, '/img/template/drink/pepsi-lon.png', 67, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(23, 'Mirinda Lon', 'Mirinda', '', 20000, 'enable', 1, '/img/template/drink/mirinda-cam.png', 68, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(23, '7up Lon', '7up', '', 20000, 'enable', 1, '/img/template/drink/7up.png', 69, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(23, 'Nước Suối', 'Water', '', 10000, 'enable', 1, '/img/template/drink/aquafina-bottle.png', 70, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(23, 'Pepsi 1.5L', 'Pepsi', '', 45000, 'enable', 1, '/img/template/drink/pepsi-chai.png', 71, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(21, 'Khoai Tây Chiên Phủ Sốt Cary Bò', 'French Fries in Beef Curry Sauce', '', 50000, 'enable', 1, '/img/template/dish/fries/khoai-tay-phu-cary-bo.png', 72, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(21, 'Khoai Tây Phô Mai Đút Lò', 'Baked Potato with Cheese', '', 45000, 'disable', 1, '/img/template/dish/fries/khoai-pho-mai-dut-lo.png', 73, '2016-04-18 00:13:45', '2016-04-18 00:13:45'),
(20, 'Trẻ Em', 'For Kid', '', 70000, 'enable', 1, '/img/template/dish/fries/kid-combo.png', 74, '2016-04-18 00:13:45', '2016-07-23 09:34:58'),
(20, '2 Người', 'Couple', '- 1 khoai lớn				 - sốt cari + mayo			 - 1 taco bò giòn			 - 1 taco gà mềm				 - 2 pepsi					 - 1 pancake choco					 - 1 bắp cải trộn', 110000, 'enable', 1, '/img/template/dish/fries/combo-2 ng.png', 75, '2016-04-18 00:13:45', '2016-07-23 09:34:59'),
(21, 'Mỳ Ý', 'Spaghetti Lunch Set', NULL, 35000, 'enable', 1, '/img/template/no-image.jpg', 76, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dishimage`
--

CREATE TABLE IF NOT EXISTS `dishimage` (
  `dish` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=953 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `dishimage`
--

INSERT INTO `dishimage` (`dish`, `url`, `status`, `id`, `createdAt`, `updatedAt`) VALUES
(1, '/images/Dishes/1/3.jpg', 'enable', 27, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(5, '/images/Dishes/5/1.jpg', 'enable', 146, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(4, '/images/Dishes/4/1.jpg', 'enable', 167, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(7, '/images/Dishes/7/2.jpg', 'enable', 168, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(6, '/images/Dishes/6/1.jpg', 'enable', 247, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(2, '/images/Dishes/2/3.jpg', 'enable', 256, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(2, '/images/Dishes/2/2.jpg', 'enable', 265, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(7, '/images/Dishes/7/3.jpg', 'enable', 293, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(3, '/images/Dishes/3/2.jpg', 'enable', 334, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(4, '/images/Dishes/4/3.jpg', 'enable', 400, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(5, '/images/Dishes/5/3.jpg', 'enable', 413, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(4, '/images/Dishes/4/2.jpg', 'enable', 418, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(3, '/images/Dishes/3/3.jpg', 'enable', 440, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(6, '/images/Dishes/6/2.jpg', 'enable', 456, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(8, '/images/Dishes/8/1.jpg', 'enable', 545, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(5, '/images/Dishes/5/2.jpg', 'enable', 636, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(3, '/images/Dishes/3/1.jpg', 'enable', 675, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(7, '/images/Dishes/7/1.jpg', 'enable', 690, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(6, '/images/Dishes/6/3.jpg', 'enable', 712, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(8, '/images/Dishes/8/2.jpg', 'enable', 752, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(1, '/images/Dishes/1/1.jpg', 'enable', 805, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(8, '/images/Dishes/8/3.jpg', 'enable', 810, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(2, '/images/Dishes/2/1.jpg', 'enable', 923, '2016-04-02 20:04:01', '2016-04-02 20:04:01'),
(1, '/images/Dishes/1/2.jpg', 'enable', 952, '2016-04-02 20:04:01', '2016-04-02 20:04:01');

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
  `name` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`dish`, `name`, `price`, `id`, `createdAt`, `updatedAt`) VALUES
(11, 'Large', 494949, 19, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(12, 'Large', 494949, 20, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(13, 'Large', 494949, 21, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(17, 'Large', 30000, 22, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(18, 'Large', 30000, 23, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(19, 'Large', 30000, 24, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(20, 'Large', 30000, 25, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(40, 'Large', 494949, 26, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(41, 'Large', 494949, 27, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(42, 'Large', 494949, 28, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(43, 'Large', 494949, 29, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(44, 'Large', 494949, 30, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(45, 'Large', 494949, 31, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(46, 'Large', 494949, 32, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(11, 'Jumbo', 6000000, 33, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(12, 'Jumbo', 6000000, 34, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(13, 'Jumbo', 6000000, 35, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(17, 'Jumbo', 40000, 36, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(18, 'Jumbo', 40000, 37, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(19, 'Jumbo', 40000, 38, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(20, 'Jumbo', 40000, 39, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(40, 'Jumbo', 6000000, 40, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(41, 'Jumbo', 6000000, 41, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(42, 'Jumbo', 6000000, 42, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(43, 'Jumbo', 6000000, 43, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(44, 'Jumbo', 6000000, 44, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(45, 'Jumbo', 6000000, 45, '2016-04-10 10:25:00', '2016-04-10 10:25:00'),
(46, 'Jumbo', 6000000, 46, '2016-04-10 10:25:00', '2016-04-10 10:25:00');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `table` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `receive` int(11) DEFAULT NULL,
  `change` int(11) DEFAULT NULL,
  `paymentStatus` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `deliveryType` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`table`, `status`, `total`, `receive`, `change`, `paymentStatus`, `deliveryType`, `startTime`, `endTime`, `id`, `createdAt`, `updatedAt`) VALUES
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-13 23:28:46', '2016-07-13 23:28:46', 50, '2016-07-13 23:28:46', '2016-07-13 16:36:19'),
('1', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-13 23:37:54', '2016-07-13 23:37:54', 51, '2016-07-13 23:37:54', '2016-07-13 17:17:00'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 00:11:14', '2016-07-14 00:11:14', 52, '2016-07-14 00:11:14', '2016-07-13 17:18:41'),
('5', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 02:52:16', '2016-07-14 02:52:16', 53, '2016-07-14 02:52:16', '2016-07-13 21:16:31'),
('6', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 03:50:13', '2016-07-14 03:50:13', 54, '2016-07-14 03:50:13', '2016-07-13 21:16:52'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 04:58:47', '2016-07-14 04:58:47', 55, '2016-07-14 04:58:47', '2016-07-13 22:06:37'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:00:21', '2016-07-14 05:00:21', 56, '2016-07-14 05:00:21', '2016-07-13 22:07:59'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:02:12', '2016-07-14 05:02:12', 57, '2016-07-14 05:02:12', '2016-07-13 22:09:23'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:03:58', '2016-07-14 05:03:58', 58, '2016-07-14 05:03:58', '2016-07-13 22:11:09'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:04:58', '2016-07-14 05:04:58', 59, '2016-07-14 05:04:58', '2016-07-13 22:12:27'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:08:23', '2016-07-14 05:08:23', 60, '2016-07-14 05:08:23', '2016-07-13 22:15:31'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:09:49', '2016-07-14 05:09:49', 61, '2016-07-14 05:09:49', '2016-07-13 22:16:57'),
('7', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-14 05:10:41', '2016-07-14 05:10:41', 62, '2016-07-14 05:10:41', '2016-07-13 22:18:20'),
('1', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-15 05:12:24', '2016-07-15 05:12:24', 63, '2016-07-15 05:12:24', '2016-07-14 22:20:11'),
('4', 'close', 228000, 250000, 22000, 'paid', 'dine-in', '2016-07-19 17:19:57', '2016-07-19 17:19:57', 64, '2016-07-19 17:19:57', '2016-07-15 04:42:20'),
('1', 'close', 62000, 100000, 38000, 'paid', 'dine-in', '2016-07-17 12:18:41', '2016-07-17 12:18:41', 65, '2016-07-17 12:18:41', '2016-07-16 02:08:49'),
('2', 'close', 139000, 200000, 61000, 'paid', 'dine-in', '2016-07-17 19:25:16', '2016-07-17 19:25:16', 66, '2016-07-17 19:25:16', '2016-07-16 03:01:52'),
('2', 'close', 147000, 147000, 0, 'paid', 'dine-in', '2016-07-18 04:03:00', '2016-07-18 04:03:00', 67, '2016-07-18 04:03:00', '2016-07-16 17:36:41'),
('2', 'close', 50000, 50000, 0, 'paid', 'dine-in', '2016-07-18 04:01:51', '2016-07-18 04:01:51', 68, '2016-07-18 04:01:51', '2016-07-16 18:01:24'),
('2', 'close', 770000, 1000000, 230000, 'paid', 'dine-in', '2016-07-26 20:31:51', '2016-07-26 20:31:51', 69, '2016-07-26 20:31:51', '2016-07-16 21:29:32'),
('1', 'close', 50000, 50000, 0, 'paid', 'dine-in', '2016-07-18 09:18:38', '2016-07-18 09:18:38', 70, '2016-07-18 09:18:38', '2016-07-17 13:07:02'),
('1', 'close', 111000, 200000, 89000, 'paid', 'dine-in', '2016-07-19 13:28:46', '2016-07-19 13:28:46', 71, '2016-07-19 13:28:46', '2016-07-17 16:11:52'),
('3', 'close', 401000, 505000, 104000, 'paid', 'dine-in', '2016-07-24 05:42:03', '2016-07-24 05:42:03', 72, '2016-07-24 05:42:03', '2016-07-17 16:44:04'),
('1', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-17 23:27:48', '2016-07-17 23:27:48', 73, '2016-07-17 23:27:48', '2016-07-17 16:35:43'),
('1', 'close', 86000, 100000, 14000, 'paid', 'dine-in', '2016-07-19 21:35:48', '2016-07-19 21:35:48', 74, '2016-07-19 21:35:48', '2016-07-18 13:27:34'),
('2', 'close', 72000, 72000, 0, 'paid', 'dine-in', '2016-07-19 22:30:18', '2016-07-19 22:30:18', 75, '2016-07-19 22:30:18', '2016-07-18 13:28:18'),
('100', 'close', 34000, 20000, 3000, 'paid', 'to-go', '2016-07-18 23:53:24', '2016-07-18 23:53:24', 76, '2016-07-18 23:53:24', '2016-07-18 17:08:45'),
('4', 'close', 110000, 200000, 90000, 'paid', 'dine-in', '2016-07-19 15:14:56', '2016-07-19 15:14:56', 77, '2016-07-19 15:14:56', '2016-07-18 19:18:55'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 15:11:54', '2016-07-19 15:11:54', 78, '2016-07-19 15:11:54', '2016-07-19 08:22:23'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 15:15:37', '2016-07-19 08:38:38', 79, '2016-07-19 15:15:37', '2016-07-19 08:38:38'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 15:32:11', '2016-07-19 08:41:03', 80, '2016-07-19 15:32:11', '2016-07-19 08:41:03'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 15:34:12', '2016-07-19 08:45:17', 81, '2016-07-19 15:34:12', '2016-07-19 08:45:17'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 15:38:52', '2016-07-19 10:09:39', 82, '2016-07-19 15:38:52', '2016-07-19 10:09:39'),
('2', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 17:33:16', '2016-07-19 10:40:42', 83, '2016-07-19 17:33:16', '2016-07-19 10:40:42'),
('1', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 17:34:02', '2016-07-19 10:41:24', 84, '2016-07-19 17:34:02', '2016-07-19 10:41:24'),
('6', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-19 17:34:09', '2016-07-19 10:41:47', 85, '2016-07-19 17:34:09', '2016-07-19 10:41:47'),
('6', 'close', 225000, 500000, 275000, 'paid', 'dine-in', '2016-07-22 16:06:10', '2016-07-22 16:06:10', 86, '2016-07-22 16:06:10', '2016-07-19 13:59:31'),
('2', 'close', 49000, 50000, 1000, 'paid', 'dine-in', '2016-07-20 16:24:24', '2016-07-20 16:24:24', 87, '2016-07-20 16:24:24', '2016-07-20 12:27:44'),
('1', 'close', 224000, 524000, 300000, 'paid', 'dine-in', '2016-07-20 12:15:04', '2016-07-20 12:15:04', 88, '2016-07-20 12:15:04', '2016-07-20 13:25:09'),
('100', 'close', 142000, 71000, 0, 'paid', 'to-go', '2016-07-20 12:30:44', '2016-07-20 12:30:44', 89, '2016-07-20 12:30:44', '2016-07-20 12:56:23'),
('100', 'close', 70000, 35000, 0, 'paid', 'to-go', '2016-07-20 13:24:10', '2016-07-20 13:24:10', 90, '2016-07-20 13:24:10', '2016-07-20 13:32:04'),
('4', 'close', 139000, 139000, 0, 'paid', 'dine-in', '2016-07-22 12:56:12', '2016-07-22 12:56:12', 91, '2016-07-22 12:56:12', '2016-07-22 13:45:52'),
('4', 'close', 110000, 200000, 90000, 'paid', 'dine-in', '2016-07-22 17:07:47', '2016-07-22 17:07:47', 92, '2016-07-22 17:07:47', '2016-07-22 17:55:23'),
('2', 'close', 409000, 409000, 0, 'paid', 'dine-in', '2016-07-22 18:49:20', '2016-07-22 18:49:20', 93, '2016-07-22 18:49:20', '2016-07-22 20:29:58'),
('4', 'close', 145000, 150000, 5000, 'paid', 'dine-in', '2016-07-22 20:17:29', '2016-07-22 20:17:29', 94, '2016-07-22 20:17:29', '2016-07-22 21:17:21'),
('100', 'close', 158000, 80000, 1000, 'paid', 'to-go', '2016-07-23 12:04:03', '2016-07-23 12:04:03', 95, '2016-07-23 12:04:03', '2016-07-23 12:20:43'),
('1', 'close', 100000, 100000, 0, 'paid', 'dine-in', '2016-07-23 14:52:26', '2016-07-23 14:52:26', 96, '2016-07-23 14:52:26', '2016-07-23 15:24:48'),
('2', 'close', 0, 0, 0, 'paid', 'dine-in', '2016-07-23 18:01:39', '2016-07-23 18:01:39', 97, '2016-07-23 18:01:39', '2016-07-23 18:09:35'),
('2', 'close', 35000, 35000, 0, 'paid', 'dine-in', '2016-07-23 18:10:10', '2016-07-23 18:10:10', 98, '2016-07-23 18:10:10', '2016-07-23 18:12:50'),
('100', 'close', 70000, 35000, 0, 'paid', 'to-go', '2016-07-23 18:27:02', '2016-07-23 18:27:02', 99, '2016-07-23 18:27:02', '2016-07-23 18:40:40'),
('2', 'close', 107000, 107000, 0, 'paid', 'dine-in', '2016-07-23 20:11:55', '2016-07-23 20:11:55', 100, '2016-07-23 20:11:55', '2016-07-23 21:02:02'),
('3', 'close', 107000, 107000, 0, 'paid', 'dine-in', '2016-07-23 20:20:31', '2016-07-23 20:20:31', 101, '2016-07-23 20:20:31', '2016-07-23 21:02:29'),
('6', 'close', 213000, 213000, 0, 'paid', 'dine-in', '2016-07-23 20:40:02', '2016-07-23 20:40:02', 102, '2016-07-23 20:40:02', '2016-07-24 14:44:33'),
('100', 'close', 70000, 50000, 15000, 'paid', 'to-go', '2016-07-24 12:13:52', '2016-07-24 12:13:52', 103, '2016-07-24 12:13:52', '2016-07-24 12:17:53'),
('100', 'close', 130000, 500000, 435000, 'paid', 'to-go', '2016-07-24 12:37:45', '2016-07-24 12:37:45', 104, '2016-07-24 12:37:45', '2016-07-24 12:46:00'),
('100', 'close', 70000, 35000, 0, 'paid', 'to-go', '2016-07-24 13:58:14', '2016-07-24 13:58:14', 105, '2016-07-24 13:58:14', '2016-07-24 14:07:05'),
('1', 'close', 149000, 200000, 51000, 'paid', 'dine-in', '2016-07-24 14:22:30', '2016-07-24 14:22:30', 106, '2016-07-24 14:22:30', '2016-07-24 15:55:08'),
('100', 'close', 320000, 200000, 40000, 'paid', 'to-go', '2016-07-24 14:56:27', '2016-07-24 14:56:27', 107, '2016-07-24 14:56:27', '2016-07-24 15:21:12'),
('100', 'close', 78000, 100000, 61000, 'paid', 'to-go', '2016-07-24 14:57:40', '2016-07-24 14:57:40', 108, '2016-07-24 14:57:40', '2016-07-24 15:09:45'),
('3', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-24 15:30:16', '2016-07-24 16:11:39', 109, '2016-07-24 15:30:16', '2016-07-24 16:11:39'),
('2', 'close', 70000, 100000, 30000, 'paid', 'dine-in', '2016-07-24 17:17:19', '2016-07-24 17:17:19', 110, '2016-07-24 17:17:19', '2016-07-24 17:53:13'),
('4', 'close', 111000, 151000, 40000, 'paid', 'dine-in', '2016-07-24 17:44:04', '2016-07-24 17:44:04', 111, '2016-07-24 17:44:04', '2016-07-24 18:13:59'),
('100', 'close', 70000, 35000, 0, 'paid', 'to-go', '2016-07-24 18:11:00', '2016-07-24 18:11:00', 112, '2016-07-24 18:11:00', '2016-07-24 18:17:07'),
('4', 'close', 120000, 200000, 80000, 'paid', 'dine-in', '2016-07-24 20:26:56', '2016-07-24 20:26:56', 113, '2016-07-24 20:26:56', '2016-07-24 21:22:00'),
('2', 'close', 142000, 202000, 60000, 'paid', 'dine-in', '2016-07-25 12:55:11', '2016-07-25 12:55:11', 114, '2016-07-25 12:55:11', '2016-07-25 14:10:56'),
('4', 'close', 136000, 200000, 64000, 'paid', 'dine-in', '2016-07-25 13:04:26', '2016-07-25 13:04:26', 115, '2016-07-25 13:04:26', '2016-07-25 13:56:06'),
('2', 'close', 220000, 220000, 0, 'paid', 'dine-in', '2016-07-25 16:50:06', '2016-07-25 16:50:06', 116, '2016-07-25 16:50:06', '2016-07-25 18:24:23'),
('4', 'close', 0, 0, 0, 'cancelled', 'dine-in', '2016-07-25 18:22:37', '2016-07-25 18:22:37', 117, '2016-07-25 18:22:37', '2016-07-25 18:22:37'),
('4', 'close', 671000, 671000, 0, 'paid', 'dine-in', '2016-07-25 18:27:15', '2016-07-25 18:27:15', 118, '2016-07-25 18:27:15', '2016-07-25 20:39:56'),
('2', 'close', 74000, 100000, 26000, 'paid', 'dine-in', '2016-07-25 19:53:53', '2016-07-25 19:53:53', 119, '2016-07-25 19:53:53', '2016-07-25 21:04:38'),
('1', 'close', 238000, 240000, 2000, 'paid', 'dine-in', '2016-07-25 20:05:52', '2016-07-25 20:05:52', 120, '2016-07-25 20:05:52', '2016-07-25 21:14:50');

-- --------------------------------------------------------

--
-- Table structure for table `sessiondetail`
--

CREATE TABLE IF NOT EXISTS `sessiondetail` (
  `session` int(11) DEFAULT NULL,
  `dish` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `size` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf16_unicode_ci DEFAULT NULL,
`id` int(10) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=578 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `sessiondetail`
--

INSERT INTO `sessiondetail` (`session`, `dish`, `parent`, `price`, `size`, `status`, `id`, `createdAt`, `updatedAt`) VALUES
(53, 74, NULL, 70000, '0', 'cancelled', 245, '2016-07-13 20:00:05', '2016-07-13 20:00:06'),
(53, 57, NULL, 15000, '0', 'cancelled', 246, '2016-07-13 20:03:30', '2016-07-13 21:16:31'),
(59, 16, NULL, 49000, '0', 'cancelled', 247, '2016-07-13 22:12:15', '2016-07-13 22:12:27'),
(64, 17, NULL, 25000, '0', 'delivered', 248, '2016-07-15 17:01:24', '2016-07-15 03:36:48'),
(64, 31, 248, 5000, '0', 'delivered', 249, '2016-07-15 17:01:24', '2016-07-15 03:36:48'),
(64, 42, NULL, 25000, '0', 'delivered', 250, '2016-07-15 17:02:08', '2016-07-15 03:36:48'),
(64, 48, 250, 0, '0', 'delivered', 251, '2016-07-15 10:09:08', '2016-07-15 03:36:48'),
(64, 62, NULL, 35000, '0', 'delivered', 252, '2016-07-15 17:03:17', '2016-07-15 03:36:49'),
(64, 62, NULL, 35000, '0', 'cancelled', 253, '2016-07-15 03:17:22', '2016-07-15 03:17:31'),
(64, 62, NULL, 35000, '0', 'cancelled', 254, '2016-07-15 03:17:24', '2016-07-15 03:17:32'),
(64, 53, NULL, 30000, '0', 'delivered', 255, '2016-07-15 17:04:12', '2016-07-15 03:48:18'),
(64, 66, NULL, 10000, '0', 'delivered', 256, '2016-07-15 17:07:34', '2016-07-15 03:36:48'),
(64, 66, NULL, 10000, '0', 'delivered', 257, '2016-07-15 17:07:35', '2016-07-15 03:36:48'),
(64, 66, NULL, 10000, '0', 'delivered', 258, '2016-07-15 17:07:43', '2016-07-15 03:36:48'),
(64, 68, NULL, 20000, '0', 'delivered', 259, '2016-07-15 17:08:04', '2016-07-15 03:36:48'),
(64, 59, NULL, 12000, '0', 'delivered', 260, '2016-07-15 17:08:23', '2016-07-15 04:30:31'),
(64, 60, NULL, 12000, '0', 'delivered', 261, '2016-07-15 17:08:28', '2016-07-15 04:30:31'),
(64, 55, NULL, 17000, '0', 'cancelled', 262, '2016-07-15 03:51:54', '2016-07-15 03:52:04'),
(64, 55, NULL, 17000, '0', 'cancelled', 263, '2016-07-15 03:51:56', '2016-07-15 03:52:05'),
(64, 52, NULL, 17000, '0', 'delivered', 264, '2016-07-15 17:38:07', '2016-07-15 04:30:32'),
(64, 55, NULL, 17000, '0', 'delivered', 265, '2016-07-15 17:38:08', '2016-07-15 04:30:32'),
(65, 17, NULL, 40000, '0', 'delivered', 266, '2016-07-16 15:40:46', '2016-07-16 02:06:04'),
(65, 30, 266, 5000, '0', 'delivered', 267, '2016-07-16 15:40:46', '2016-07-16 02:06:04'),
(65, 55, NULL, 17000, '0', 'delivered', 268, '2016-07-16 15:41:47', '2016-07-16 02:06:04'),
(66, 16, NULL, 49000, '0', 'delivered', 269, '2016-07-16 15:53:55', '2016-07-16 02:35:13'),
(66, 66, NULL, 10000, '0', 'delivered', 270, '2016-07-16 15:54:19', '2016-07-16 02:25:13'),
(66, 66, NULL, 10000, '0', 'delivered', 271, '2016-07-16 15:54:23', '2016-07-16 02:25:13'),
(66, 74, NULL, 70000, '0', 'delivered', 272, '2016-07-16 15:55:30', '2016-07-16 02:25:13'),
(67, 74, NULL, 70000, 'Medium', 'cancelled', 273, '2016-07-16 10:45:21', '2016-07-16 10:46:22'),
(67, 74, NULL, 70000, 'Medium', 'cancelled', 274, '2016-07-16 10:46:46', '2016-07-16 10:47:07'),
(67, 74, NULL, 70000, 'Medium', 'removed', 275, '2016-07-16 17:40:21', '2016-07-16 11:22:09'),
(67, 74, NULL, 70000, 'Medium', 'removed', 276, '2016-07-16 17:41:49', '2016-07-16 11:22:03'),
(67, 74, NULL, 70000, 'Medium', 'removed', 277, '2016-07-16 17:43:18', '2016-07-16 11:22:04'),
(67, 63, NULL, 30000, 'Medium', 'removed', 278, '2016-07-16 17:43:23', '2016-07-16 11:22:06'),
(67, 74, NULL, 70000, 'Medium', 'delivered', 279, '2016-07-17 00:37:30', '2016-07-16 11:26:14'),
(67, 63, NULL, 30000, 'Medium', 'delivered', 280, '2016-07-17 00:37:34', '2016-07-16 11:47:44'),
(67, 52, NULL, 17000, 'Medium', 'delivered', 281, '2016-07-17 00:39:08', '2016-07-16 11:47:45'),
(67, 53, NULL, 30000, 'Medium', 'delivered', 282, '2016-07-17 00:39:16', '2016-07-16 11:47:45'),
(68, 61, NULL, 25000, 'Medium', 'delivered', 283, '2016-07-17 07:23:06', '2016-07-16 17:42:53'),
(68, 42, NULL, 25000, 'Medium', 'cancelled', 284, '2016-07-16 17:37:26', '2016-07-16 17:37:34'),
(68, 48, 284, 0, 'Medium', 'cancelled', 285, '2016-07-16 17:37:26', '2016-07-16 17:37:34'),
(68, 42, NULL, 25000, 'Medium', 'delivered', 286, '2016-07-17 07:23:48', '2016-07-16 17:42:53'),
(68, 48, 286, 0, 'Medium', 'delivered', 287, '2016-07-17 00:30:48', '2016-07-16 17:42:53'),
(69, 54, NULL, 45000, 'Medium', 'delivered', 288, '2016-07-17 09:24:40', '2016-07-16 20:03:04'),
(69, 70, NULL, 10000, 'Medium', 'delivered', 289, '2016-07-17 09:24:54', '2016-07-16 20:03:04'),
(69, 72, NULL, 50000, 'Medium', 'delivered', 290, '2016-07-17 09:25:46', '2016-07-16 20:03:04'),
(69, 52, NULL, 17000, 'Medium', 'delivered', 291, '2016-07-17 09:26:30', '2016-07-16 20:21:45'),
(69, 52, NULL, 17000, 'Medium', 'cancelled', 292, '2016-07-16 19:40:32', '2016-07-16 19:41:14'),
(69, 52, NULL, 17000, 'Medium', 'cancelled', 293, '2016-07-16 19:40:33', '2016-07-16 19:41:13'),
(69, 61, NULL, 35000, 'Medium', 'delivered', 294, '2016-07-17 09:27:56', '2016-07-16 20:03:04'),
(69, 61, NULL, 35000, 'Medium', 'cancelled', 295, '2016-07-16 19:42:00', '2016-07-16 19:42:05'),
(69, 67, NULL, 20000, 'Medium', 'cancelled', 296, '2016-07-16 19:42:21', '2016-07-16 19:42:31'),
(69, 66, NULL, 10000, 'Medium', 'delivered', 297, '2016-07-17 09:28:32', '2016-07-16 20:03:04'),
(69, 70, NULL, 10000, 'Medium', 'delivered', 298, '2016-07-17 09:41:39', '2016-07-16 20:09:28'),
(69, 61, NULL, 35000, 'Medium', 'delivered', 299, '2016-07-17 09:41:50', '2016-07-16 20:09:28'),
(69, 56, NULL, 15000, 'Medium', 'delivered', 300, '2016-07-17 09:42:05', '2016-07-16 20:23:49'),
(69, 52, NULL, 17000, 'Medium', 'delivered', 301, '2016-07-17 09:43:12', '2016-07-16 20:21:45'),
(69, 70, NULL, 10000, 'Medium', 'delivered', 302, '2016-07-17 09:43:41', '2016-07-16 20:09:28'),
(69, 72, NULL, 50000, 'Medium', 'delivered', 303, '2016-07-17 09:44:31', '2016-07-16 20:17:03'),
(69, 42, NULL, 25000, 'Medium', 'delivered', 304, '2016-07-17 09:45:58', '2016-07-16 20:31:44'),
(69, 48, 304, 0, 'Medium', 'delivered', 305, '2016-07-17 02:52:58', '2016-07-16 20:31:44'),
(69, 40, NULL, 20000, 'Medium', 'delivered', 306, '2016-07-17 09:46:05', '2016-07-16 20:17:03'),
(69, 48, 306, 0, 'Medium', 'delivered', 307, '2016-07-17 02:53:05', '2016-07-16 20:17:03'),
(69, 59, NULL, 12000, 'Medium', 'delivered', 308, '2016-07-17 09:46:49', '2016-07-16 20:34:50'),
(69, 63, NULL, 30000, 'Medium', 'delivered', 309, '2016-07-17 10:16:30', '2016-07-16 20:37:05'),
(69, 58, NULL, 30000, 'Medium', 'delivered', 310, '2016-07-17 10:16:44', '2016-07-16 20:42:34'),
(69, 41, NULL, 25000, 'Medium', 'removed', 311, '2016-07-17 03:24:28', '2016-07-16 20:37:21'),
(69, 47, 311, 5000, 'Medium', 'delivered', 312, '2016-07-17 10:17:28', '2016-07-16 20:42:34'),
(69, 59, NULL, 12000, 'Medium', 'delivered', 313, '2016-07-17 10:18:22', '2016-07-16 20:37:05'),
(69, 16, NULL, 49000, 'Medium', 'delivered', 314, '2016-07-17 10:24:30', '2016-07-16 20:46:12'),
(69, 16, NULL, 49000, 'Medium', 'delivered', 315, '2016-07-17 10:33:31', '2016-07-16 20:54:30'),
(69, 70, NULL, 10000, 'Medium', 'delivered', 316, '2016-07-17 10:34:36', '2016-07-16 20:54:31'),
(69, 20, NULL, 30000, 'Large', 'delivered', 317, '2016-07-17 10:39:08', '2016-07-16 20:59:01'),
(69, 23, 317, 10000, 'Medium', 'delivered', 318, '2016-07-17 10:39:08', '2016-07-16 20:59:01'),
(69, 56, NULL, 15000, 'Medium', 'delivered', 319, '2016-07-17 10:39:24', '2016-07-16 21:05:02'),
(69, 16, NULL, 49000, 'Medium', 'delivered', 320, '2016-07-17 10:39:41', '2016-07-16 21:05:02'),
(69, 56, NULL, 15000, 'Medium', 'cancelled', 321, '2016-07-16 20:55:08', '2016-07-16 20:55:16'),
(69, 57, NULL, 15000, 'Medium', 'delivered', 322, '2016-07-17 10:41:17', '2016-07-16 21:15:59'),
(69, 72, NULL, 50000, 'Medium', 'delivered', 323, '2016-07-17 10:41:24', '2016-07-16 21:15:59'),
(69, 61, NULL, 35000, 'Medium', 'delivered', 324, '2016-07-17 10:42:09', '2016-07-16 21:20:02'),
(69, 70, NULL, 10000, 'Medium', 'delivered', 325, '2016-07-17 10:42:25', '2016-07-16 21:05:02'),
(69, 66, NULL, 10000, 'Medium', 'delivered', 326, '2016-07-17 10:42:28', '2016-07-16 21:05:02'),
(70, 72, NULL, 50000, 'Medium', 'delivered', 327, '2016-07-18 02:27:08', '2016-07-17 12:51:42'),
(71, 17, NULL, 30000, 'Large', 'delivered', 328, '2016-07-18 03:10:44', '2016-07-17 13:34:12'),
(71, 27, 328, 12000, 'Medium', 'delivered', 329, '2016-07-18 03:10:44', '2016-07-17 13:34:12'),
(71, 66, NULL, 10000, 'Medium', 'delivered', 330, '2016-07-18 03:11:28', '2016-07-17 13:34:12'),
(71, 66, NULL, 10000, 'Medium', 'delivered', 331, '2016-07-18 03:11:30', '2016-07-17 13:34:12'),
(71, 16, NULL, 49000, 'Medium', 'delivered', 332, '2016-07-18 04:02:09', '2016-07-17 14:26:57'),
(72, 17, NULL, 25000, 'Medium', 'delivered', 333, '2016-07-18 05:10:38', '2016-07-17 15:35:40'),
(72, 25, 333, 12000, 'Medium', 'delivered', 334, '2016-07-18 05:10:38', '2016-07-17 15:35:40'),
(72, 52, NULL, 17000, 'Medium', 'delivered', 335, '2016-07-18 05:11:14', '2016-07-17 15:39:03'),
(72, 52, NULL, 17000, 'Medium', 'cancelled', 336, '2016-07-17 15:25:16', '2016-07-17 15:25:29'),
(72, 73, NULL, 45000, 'Medium', 'cancelled', 337, '2016-07-17 15:26:25', '2016-07-17 15:26:29'),
(72, 17, NULL, 25000, 'Medium', 'delivered', 338, '2016-07-18 05:12:54', '2016-07-17 15:35:40'),
(72, 30, 338, 5000, 'Medium', 'delivered', 339, '2016-07-18 05:12:54', '2016-07-17 15:35:40'),
(72, 66, NULL, 10000, 'Medium', 'delivered', 340, '2016-07-18 05:13:27', '2016-07-17 15:35:40'),
(72, 70, NULL, 10000, 'Medium', 'delivered', 341, '2016-07-18 05:13:30', '2016-07-17 15:35:40'),
(72, 70, NULL, 10000, 'Medium', 'delivered', 342, '2016-07-18 05:13:34', '2016-07-17 15:35:40'),
(72, 66, NULL, 10000, 'Medium', 'cancelled', 343, '2016-07-17 15:27:56', '2016-07-17 15:31:40'),
(72, 66, NULL, 10000, 'Medium', 'cancelled', 344, '2016-07-17 15:28:00', '2016-07-17 15:31:39'),
(72, 66, NULL, 10000, 'Medium', 'cancelled', 345, '2016-07-17 15:28:02', '2016-07-17 15:31:37'),
(72, 16, NULL, 49000, 'Medium', 'delivered', 346, '2016-07-18 05:17:55', '2016-07-17 15:45:30'),
(72, 73, NULL, 45000, 'Medium', 'cancelled', 347, '2016-07-17 15:32:31', '2016-07-17 15:32:36'),
(72, 72, NULL, 50000, 'Medium', 'delivered', 348, '2016-07-18 05:18:35', '2016-07-17 15:45:30'),
(72, 63, NULL, 30000, 'Medium', 'delivered', 349, '2016-07-18 05:18:47', '2016-07-17 16:03:35'),
(72, 17, NULL, 25000, 'Medium', 'delivered', 350, '2016-07-18 05:26:46', '2016-07-17 15:54:50'),
(72, 33, 350, 10000, 'Medium', 'delivered', 351, '2016-07-18 05:26:46', '2016-07-17 15:54:50'),
(72, 52, NULL, 17000, 'Medium', 'delivered', 352, '2016-07-18 05:26:54', '2016-07-17 15:50:57'),
(72, 52, NULL, 17000, 'Medium', 'delivered', 353, '2016-07-18 05:27:13', '2016-07-17 16:10:41'),
(72, 52, NULL, 17000, 'Medium', 'delivered', 354, '2016-07-18 05:29:21', '2016-07-17 16:10:42'),
(72, 52, NULL, 17000, 'Medium', 'delivered', 355, '2016-07-18 05:29:24', '2016-07-17 16:10:42'),
(72, 66, NULL, 10000, 'Medium', 'delivered', 356, '2016-07-18 05:30:21', '2016-07-17 15:54:50'),
(72, 16, NULL, 49000, 'Medium', 'removed', 357, '2016-07-17 22:42:25', '2016-07-17 15:56:30'),
(72, 56, NULL, 15000, 'Medium', 'removed', 358, '2016-07-17 22:49:36', '2016-07-17 15:57:18'),
(72, 54, NULL, 45000, 'Medium', 'delivered', 359, '2016-07-18 05:43:18', '2016-07-17 16:10:42'),
(74, 16, NULL, 49000, 'Medium', 'delivered', 360, '2016-07-19 01:01:52', '2016-07-18 11:26:25'),
(74, 19, NULL, 25000, 'Medium', 'delivered', 361, '2016-07-19 01:36:25', '2016-07-18 12:01:47'),
(74, 27, 361, 12000, 'Medium', 'delivered', 362, '2016-07-19 01:36:25', '2016-07-18 12:01:47'),
(74, 19, NULL, 25000, 'Medium', 'cancelled', 363, '2016-07-18 11:51:30', '2016-07-18 11:51:32'),
(74, 27, 363, 12000, 'Medium', 'cancelled', 364, '2016-07-18 11:51:30', '2016-07-18 11:51:33'),
(75, 61, NULL, 35000, 'Medium', 'delivered', 365, '2016-07-19 01:51:42', '2016-07-18 12:22:27'),
(75, 17, NULL, 25000, 'Medium', 'delivered', 366, '2016-07-19 02:25:09', '2016-07-18 12:47:35'),
(75, 27, 366, 12000, 'Medium', 'delivered', 367, '2016-07-19 02:25:09', '2016-07-18 12:47:35'),
(76, 52, NULL, 17000, NULL, 'delivered', 368, '2016-07-19 06:46:24', '2016-07-18 17:08:45'),
(77, 75, NULL, 110000, 'Medium', 'delivered', 369, '2016-07-19 08:24:07', '2016-07-18 18:48:59'),
(86, 72, NULL, 50000, 'Medium', 'cancelled', 370, '2016-07-19 12:23:52', '2016-07-19 12:24:51'),
(86, 72, NULL, 50000, 'Medium', 'delivered', 371, '2016-07-20 02:10:52', '2016-07-19 12:38:54'),
(86, 72, NULL, 50000, 'Medium', 'cancelled', 372, '2016-07-19 12:24:54', '2016-07-19 12:24:55'),
(86, 17, NULL, 30000, 'Large', 'delivered', 373, '2016-07-20 02:11:38', '2016-07-19 12:43:54'),
(86, 30, 373, 5000, 'Medium', 'delivered', 374, '2016-07-20 02:11:38', '2016-07-19 12:43:54'),
(86, 62, NULL, 35000, 'Medium', 'delivered', 375, '2016-07-20 02:13:49', '2016-07-19 12:47:39'),
(86, 67, NULL, 20000, 'Medium', 'delivered', 376, '2016-07-20 02:15:09', '2016-07-19 12:47:39'),
(86, 66, NULL, 10000, 'Medium', 'delivered', 377, '2016-07-20 02:15:22', '2016-07-19 12:47:39'),
(86, 72, NULL, 50000, 'Medium', 'delivered', 378, '2016-07-20 03:13:13', '2016-07-19 13:37:22'),
(86, 41, NULL, 25000, 'Medium', 'delivered', 379, '2016-07-20 03:14:34', '2016-07-19 13:49:55'),
(86, 48, 379, 0, 'Medium', 'delivered', 380, '2016-07-19 20:21:34', '2016-07-19 13:49:55'),
(87, 67, NULL, 20000, 'Medium', 'delivered', 381, '2016-07-20 23:17:38', '2016-07-20 09:33:12'),
(87, 52, NULL, 17000, 'Medium', 'delivered', 382, '2016-07-20 11:00:54', '2016-07-20 11:19:38'),
(87, 52, NULL, 17000, 'Medium', 'cancelled', 383, '2016-07-20 11:00:56', '2016-07-20 11:00:59'),
(87, 59, NULL, 12000, 'Medium', 'delivered', 384, '2016-07-20 11:01:21', '2016-07-20 11:19:38'),
(88, 16, NULL, 49000, 'Medium', 'delivered', 385, '2016-07-20 12:19:15', '2016-07-20 12:28:01'),
(88, 62, NULL, 35000, 'Medium', 'delivered', 386, '2016-07-20 12:19:43', '2016-07-20 12:35:24'),
(88, 64, NULL, 15000, 'Medium', 'delivered', 387, '2016-07-20 12:19:48', '2016-07-20 12:46:40'),
(88, 72, NULL, 50000, 'Medium', 'delivered', 388, '2016-07-20 12:21:12', '2016-07-20 12:35:24'),
(88, 64, NULL, 15000, 'Medium', 'delivered', 389, '2016-07-20 12:21:50', '2016-07-20 12:46:40'),
(88, 64, NULL, 15000, 'Medium', 'delivered', 390, '2016-07-20 12:21:51', '2016-07-20 12:46:40'),
(88, 71, NULL, 45000, 'Medium', 'delivered', 391, '2016-07-20 12:22:04', '2016-07-20 12:28:01'),
(89, 19, NULL, 30000, 'Large', 'delivered', 392, '2016-07-20 12:30:44', '2016-07-20 12:56:23'),
(89, 27, NULL, 12000, 'Medium', 'delivered', 393, '2016-07-20 12:30:44', '2016-07-20 12:56:23'),
(89, 59, NULL, 12000, 'Medium', 'delivered', 394, '2016-07-20 12:30:44', '2016-07-20 12:56:23'),
(89, 52, NULL, 17000, 'Medium', 'delivered', 395, '2016-07-20 12:30:44', '2016-07-20 12:56:23'),
(90, 17, NULL, 25000, 'Medium', 'delivered', 396, '2016-07-20 13:24:10', '2016-07-20 13:32:03'),
(90, 24, NULL, 10000, 'Medium', 'delivered', 397, '2016-07-20 13:24:10', '2016-07-20 13:32:04'),
(91, 55, NULL, 17000, 'Medium', 'delivered', 398, '2016-07-22 12:56:53', '2016-07-22 13:07:24'),
(91, 40, NULL, 20000, 'Medium', 'delivered', 399, '2016-07-22 12:57:36', '2016-07-22 13:11:55'),
(91, 48, 399, 0, 'Medium', 'delivered', 400, '2016-07-22 12:57:36', '2016-07-22 13:11:55'),
(91, 42, NULL, 25000, 'Medium', 'delivered', 401, '2016-07-22 12:58:25', '2016-07-22 13:20:02'),
(91, 48, 401, 0, 'Medium', 'delivered', 402, '2016-07-22 12:58:25', '2016-07-22 13:20:02'),
(91, 76, NULL, 35000, 'Medium', 'delivered', 403, '2016-07-22 13:14:18', '2016-07-22 13:20:03'),
(91, 55, NULL, 17000, 'Medium', 'cancelled', 404, '2016-07-22 13:17:52', '2016-07-22 13:24:00'),
(91, 55, NULL, 17000, 'Medium', 'cancelled', 405, '2016-07-22 13:17:54', '2016-07-22 13:24:00'),
(91, 55, NULL, 17000, 'Medium', 'cancelled', 406, '2016-07-22 13:17:56', '2016-07-22 13:24:01'),
(91, 42, NULL, 25000, 'Medium', 'delivered', 407, '2016-07-22 13:24:15', '2016-07-22 13:40:21'),
(91, 48, 407, 0, 'Medium', 'delivered', 408, '2016-07-22 13:24:15', '2016-07-22 13:40:21'),
(91, 55, NULL, 17000, 'Medium', 'delivered', 409, '2016-07-22 13:24:28', '2016-07-22 13:33:22'),
(92, 75, NULL, 110000, 'Medium', 'delivered', 410, '2016-07-22 17:09:57', '2016-07-22 17:26:17'),
(93, 75, NULL, 110000, 'Medium', 'removed', 411, '2016-07-22 18:59:28', '2016-07-22 19:01:37'),
(93, 75, NULL, 110000, 'Medium', 'removed', 412, '2016-07-22 19:00:48', '2016-07-22 19:01:38'),
(93, 75, NULL, 110000, 'Medium', 'delivered', 413, '2016-07-22 19:01:12', '2016-07-22 19:14:00'),
(93, 75, NULL, 110000, 'Medium', 'delivered', 414, '2016-07-22 19:01:13', '2016-07-22 19:21:40'),
(93, 16, NULL, 49000, 'Medium', 'delivered', 415, '2016-07-22 19:30:49', '2016-07-22 19:41:49'),
(93, 76, NULL, 35000, 'Medium', 'delivered', 416, '2016-07-22 20:19:04', '2016-07-22 20:19:58'),
(93, 76, NULL, 35000, 'Medium', 'delivered', 417, '2016-07-22 20:19:06', '2016-07-22 20:19:58'),
(93, 76, NULL, 35000, 'Medium', 'delivered', 418, '2016-07-22 20:19:06', '2016-07-22 20:19:58'),
(93, 76, NULL, 35000, 'Medium', 'delivered', 419, '2016-07-22 20:19:17', '2016-07-22 20:19:58'),
(94, 40, NULL, 20000, 'Medium', 'cancelled', 420, '2016-07-22 20:20:15', '2016-07-22 20:20:18'),
(94, 47, 420, 5000, 'Medium', 'cancelled', 421, '2016-07-22 20:20:15', '2016-07-22 20:20:18'),
(94, 40, NULL, 20000, 'Medium', 'cancelled', 422, '2016-07-22 20:20:33', '2016-07-22 20:23:43'),
(94, 47, 422, 5000, 'Medium', 'cancelled', 423, '2016-07-22 20:20:33', '2016-07-22 20:23:43'),
(94, 72, NULL, 50000, 'Medium', 'delivered', 424, '2016-07-22 20:21:27', '2016-07-22 20:36:47'),
(94, 75, NULL, 110000, 'Medium', 'cancelled', 425, '2016-07-22 20:21:35', '2016-07-22 20:21:36'),
(94, 63, NULL, 30000, 'Medium', 'delivered', 426, '2016-07-22 20:22:08', '2016-07-22 20:36:47'),
(94, 17, NULL, 25000, 'Medium', 'delivered', 427, '2016-07-22 20:24:42', '2016-07-22 20:36:47'),
(94, 30, 427, 5000, 'Medium', 'delivered', 428, '2016-07-22 20:24:42', '2016-07-22 20:36:48'),
(94, 66, NULL, 10000, 'Medium', 'delivered', 429, '2016-07-22 20:25:22', '2016-07-22 20:36:47'),
(94, 66, NULL, 10000, 'Medium', 'delivered', 430, '2016-07-22 20:25:27', '2016-07-22 20:36:47'),
(94, 56, NULL, 15000, 'Medium', 'delivered', 431, '2016-07-22 20:26:25', '2016-07-22 20:44:00'),
(95, 16, NULL, 49000, 'Medium', 'delivered', 432, '2016-07-23 12:04:03', '2016-07-23 12:18:24'),
(95, 17, NULL, 25000, 'Medium', 'delivered', 433, '2016-07-23 12:04:03', '2016-07-23 12:20:43'),
(95, 30, NULL, 5000, 'Medium', 'delivered', 434, '2016-07-23 12:04:03', '2016-07-23 12:20:43'),
(96, 76, NULL, 35000, 'Medium', 'delivered', 435, '2016-07-23 14:52:44', '2016-07-23 15:05:32'),
(96, 76, NULL, 35000, 'Medium', 'delivered', 436, '2016-07-23 14:59:54', '2016-07-23 15:05:32'),
(96, 56, NULL, 15000, 'Medium', 'delivered', 437, '2016-07-23 15:07:53', '2016-07-23 15:21:06'),
(96, 56, NULL, 15000, 'Medium', 'delivered', 438, '2016-07-23 15:07:54', '2016-07-23 15:21:06'),
(97, 76, NULL, 35000, 'Medium', 'removed', 439, '2016-07-23 18:02:07', '2016-07-23 18:10:56'),
(97, 16, NULL, 49000, 'Medium', 'cancelled', 440, '2016-07-23 18:04:55', '2016-07-23 18:05:19'),
(98, 76, NULL, 35000, 'Medium', 'delivered', 441, '2016-07-23 18:10:19', '2016-07-23 18:11:59'),
(99, 19, NULL, 30000, 'Large', 'delivered', 442, '2016-07-23 18:27:02', '2016-07-23 18:40:40'),
(99, 31, NULL, 5000, 'Medium', 'delivered', 443, '2016-07-23 18:27:02', '2016-07-23 18:40:40'),
(100, 40, NULL, 20000, 'Medium', 'delivered', 444, '2016-07-23 20:13:22', '2016-07-23 20:20:41'),
(100, 48, 444, 0, 'Medium', 'delivered', 445, '2016-07-23 20:13:22', '2016-07-23 20:20:41'),
(100, 19, NULL, 30000, 'Large', 'delivered', 446, '2016-07-23 20:15:55', '2016-07-23 20:28:01'),
(100, 34, 446, 10000, 'Medium', 'delivered', 447, '2016-07-23 20:15:55', '2016-07-23 20:28:01'),
(100, 52, NULL, 17000, 'Medium', 'delivered', 448, '2016-07-23 20:20:36', '2016-07-23 20:46:08'),
(100, 52, NULL, 17000, 'Medium', 'cancelled', 449, '2016-07-23 20:20:38', '2016-07-23 20:24:59'),
(100, 52, NULL, 17000, 'Medium', 'cancelled', 450, '2016-07-23 20:20:40', '2016-07-23 20:24:58'),
(101, 76, NULL, 35000, 'Medium', 'delivered', 451, '2016-07-23 20:21:58', '2016-07-23 20:35:25'),
(101, 76, NULL, 35000, 'Medium', 'delivered', 452, '2016-07-23 20:22:36', '2016-07-23 20:35:25'),
(101, 20, NULL, 25000, 'Medium', 'delivered', 453, '2016-07-23 20:25:49', '2016-07-23 20:35:25'),
(101, 25, 453, 12000, 'Medium', 'delivered', 454, '2016-07-23 20:25:49', '2016-07-23 20:35:25'),
(101, 66, NULL, 10000, 'Medium', 'removed', 455, '2016-07-23 20:27:53', '2016-07-23 20:32:13'),
(100, 66, NULL, 10000, 'Medium', 'delivered', 456, '2016-07-23 20:30:16', '2016-07-23 20:46:08'),
(100, 40, NULL, 20000, 'Medium', 'delivered', 457, '2016-07-23 20:32:48', '2016-07-23 20:46:08'),
(100, 48, 457, 0, 'Medium', 'delivered', 458, '2016-07-23 20:32:48', '2016-07-23 20:46:08'),
(102, 57, NULL, 15000, 'Medium', 'cancelled', 459, '2016-07-23 20:42:13', '2016-07-23 20:42:15'),
(102, 56, NULL, 15000, 'Medium', 'cancelled', 460, '2016-07-23 20:43:25', '2016-07-23 20:43:39'),
(102, 56, NULL, 15000, 'Medium', 'cancelled', 461, '2016-07-23 20:43:33', '2016-07-23 20:43:40'),
(102, 56, NULL, 15000, 'Medium', 'delivered', 462, '2016-07-23 20:43:33', '2016-07-23 20:52:12'),
(102, 69, NULL, 20000, 'Medium', 'delivered', 463, '2016-07-23 20:44:15', '2016-07-23 20:52:13'),
(102, 66, NULL, 10000, 'Medium', 'delivered', 464, '2016-07-23 20:47:06', '2016-07-23 20:52:13'),
(102, 69, NULL, 20000, 'Medium', 'delivered', 465, '2016-07-23 20:47:12', '2016-07-23 20:52:13'),
(102, 16, NULL, 49000, 'Medium', 'delivered', 466, '2016-07-23 20:49:33', '2016-07-23 20:59:52'),
(102, 66, NULL, 10000, 'Medium', 'delivered', 467, '2016-07-23 20:50:10', '2016-07-23 20:52:13'),
(102, 53, NULL, 30000, 'Medium', 'cancelled', 468, '2016-07-23 20:54:05', '2016-07-23 20:54:20'),
(102, 58, NULL, 30000, 'Medium', 'delivered', 469, '2016-07-23 20:54:22', '2016-07-23 21:07:17'),
(102, 60, NULL, 12000, 'Medium', 'delivered', 470, '2016-07-23 20:55:12', '2016-07-23 21:12:47'),
(102, 60, NULL, 12000, 'Medium', 'delivered', 471, '2016-07-23 20:55:16', '2016-07-23 21:12:47'),
(102, 20, NULL, 25000, 'Medium', 'delivered', 472, '2016-07-23 20:57:33', '2016-07-23 21:07:17'),
(102, 33, 472, 10000, 'Medium', 'delivered', 473, '2016-07-23 20:57:33', '2016-07-23 21:07:17'),
(103, 76, NULL, 35000, 'Medium', 'delivered', 474, '2016-07-24 12:13:52', '2016-07-24 12:17:53'),
(104, 76, NULL, 35000, 'Medium', 'delivered', 475, '2016-07-24 12:37:45', '2016-07-24 12:46:00'),
(104, 17, NULL, 25000, 'Medium', 'delivered', 476, '2016-07-24 12:37:45', '2016-07-24 12:46:00'),
(104, 30, NULL, 5000, 'Medium', 'delivered', 477, '2016-07-24 12:37:45', '2016-07-24 12:46:00'),
(105, 19, NULL, 30000, 'Large', 'delivered', 478, '2016-07-24 13:58:14', '2016-07-24 14:07:05'),
(105, 31, NULL, 5000, 'Medium', 'delivered', 479, '2016-07-24 13:58:14', '2016-07-24 14:07:05'),
(106, 59, NULL, 12000, 'Medium', 'delivered', 480, '2016-07-24 14:24:32', '2016-07-24 14:36:40'),
(106, 43, NULL, 30000, 'Medium', 'delivered', 481, '2016-07-24 14:26:37', '2016-07-24 14:41:02'),
(106, 47, 481, 5000, 'Medium', 'delivered', 482, '2016-07-24 14:26:37', '2016-07-24 14:41:02'),
(106, 66, NULL, 10000, 'Medium', 'delivered', 483, '2016-07-24 14:27:45', '2016-07-24 14:36:40'),
(106, 68, NULL, 20000, 'Medium', 'delivered', 484, '2016-07-24 14:28:09', '2016-07-24 14:36:40'),
(106, 52, NULL, 17000, 'Medium', 'delivered', 485, '2016-07-24 14:29:13', '2016-07-24 14:41:03'),
(107, 75, NULL, 110000, 'Medium', 'delivered', 486, '2016-07-24 14:56:27', '2016-07-24 15:19:29'),
(107, 72, NULL, 50000, 'Medium', 'delivered', 487, '2016-07-24 14:56:27', '2016-07-24 15:21:12'),
(108, 60, NULL, 12000, 'Medium', 'delivered', 488, '2016-07-24 14:57:40', '2016-07-24 15:09:45'),
(108, 55, NULL, 17000, 'Medium', 'delivered', 489, '2016-07-24 14:57:40', '2016-07-24 15:09:45'),
(108, 66, NULL, 10000, 'Medium', 'delivered', 490, '2016-07-24 14:57:40', '2016-07-24 15:09:45'),
(106, 19, NULL, 25000, 'Medium', 'delivered', 491, '2016-07-24 14:58:52', '2016-07-24 15:13:34'),
(106, 31, 491, 5000, 'Medium', 'delivered', 492, '2016-07-24 14:58:52', '2016-07-24 15:13:34'),
(106, 40, NULL, 20000, 'Medium', 'delivered', 493, '2016-07-24 14:59:23', '2016-07-24 15:16:22'),
(106, 47, 493, 5000, 'Medium', 'delivered', 494, '2016-07-24 14:59:23', '2016-07-24 15:16:22'),
(109, 17, NULL, 25000, 'Medium', 'cancelled', 495, '2016-07-24 15:30:39', '2016-07-24 15:31:52'),
(109, 21, 495, 5000, 'Medium', 'cancelled', 496, '2016-07-24 15:30:39', '2016-07-24 15:31:52'),
(109, 55, NULL, 17000, 'Medium', 'cancelled', 497, '2016-07-24 15:31:03', '2016-07-24 15:31:53'),
(110, 74, NULL, 70000, 'Medium', 'cancelled', 498, '2016-07-24 17:19:01', '2016-07-24 17:19:02'),
(110, 74, NULL, 70000, 'Medium', 'cancelled', 499, '2016-07-24 17:19:03', '2016-07-24 17:19:04'),
(110, 74, NULL, 70000, 'Medium', 'delivered', 500, '2016-07-24 17:19:05', '2016-07-24 17:29:33'),
(111, 16, NULL, 49000, 'Medium', 'delivered', 501, '2016-07-24 17:44:22', '2016-07-24 17:52:53'),
(111, 75, NULL, 110000, 'Medium', 'cancelled', 502, '2016-07-24 17:45:04', '2016-07-24 17:45:08'),
(111, 75, NULL, 110000, 'Medium', 'cancelled', 503, '2016-07-24 17:45:05', '2016-07-24 17:45:07'),
(111, 74, NULL, 70000, 'Medium', 'cancelled', 504, '2016-07-24 17:45:13', '2016-07-24 17:45:15'),
(111, 63, NULL, 30000, 'Medium', 'delivered', 505, '2016-07-24 17:56:39', '2016-07-24 18:09:54'),
(111, 55, NULL, 17000, 'Medium', 'delivered', 506, '2016-07-24 18:00:42', '2016-07-24 18:09:54'),
(111, 57, NULL, 15000, 'Medium', 'delivered', 507, '2016-07-24 18:00:44', '2016-07-24 18:09:54'),
(112, 76, NULL, 35000, 'Medium', 'delivered', 508, '2016-07-24 18:11:00', '2016-07-24 18:17:07'),
(113, 75, NULL, 110000, 'Medium', 'delivered', 509, '2016-07-24 20:27:41', '2016-07-24 20:35:24'),
(113, 70, NULL, 10000, 'Medium', 'delivered', 510, '2016-07-24 20:27:55', '2016-07-24 20:40:15'),
(114, 16, NULL, 49000, 'Medium', 'cancelled', 511, '2016-07-25 12:56:04', '2016-07-25 12:56:09'),
(114, 16, NULL, 49000, 'Medium', 'cancelled', 512, '2016-07-25 12:56:11', '2016-07-25 12:56:14'),
(114, 72, NULL, 50000, 'Medium', 'delivered', 513, '2016-07-25 12:57:01', '2016-07-25 13:09:42'),
(114, 59, NULL, 12000, 'Medium', 'delivered', 514, '2016-07-25 12:57:18', '2016-07-25 13:30:36'),
(114, 61, NULL, 35000, 'Medium', 'delivered', 515, '2016-07-25 12:58:31', '2016-07-25 13:09:42'),
(114, 66, NULL, 10000, 'Medium', 'delivered', 516, '2016-07-25 13:02:58', '2016-07-25 13:18:03'),
(114, 66, NULL, 10000, 'Medium', 'delivered', 517, '2016-07-25 13:02:59', '2016-07-25 13:18:03'),
(115, 16, NULL, 49000, 'Medium', 'delivered', 518, '2016-07-25 13:04:37', '2016-07-25 13:21:15'),
(115, 57, NULL, 15000, 'Medium', 'delivered', 519, '2016-07-25 13:05:09', '2016-07-25 13:28:32'),
(114, 40, NULL, 20000, 'Medium', 'delivered', 520, '2016-07-25 13:05:22', '2016-07-25 13:18:03'),
(114, 47, 520, 5000, 'Medium', 'delivered', 521, '2016-07-25 13:05:22', '2016-07-25 13:18:03'),
(115, 58, NULL, 30000, 'Medium', 'delivered', 522, '2016-07-25 13:05:26', '2016-07-25 13:23:14'),
(115, 17, NULL, 30000, 'Large', 'delivered', 523, '2016-07-25 13:34:45', '2016-07-25 13:43:53'),
(115, 25, 523, 12000, 'Medium', 'delivered', 524, '2016-07-25 13:34:45', '2016-07-25 13:43:53'),
(116, 75, NULL, 110000, 'Medium', 'delivered', 525, '2016-07-25 16:50:55', '2016-07-25 17:03:37'),
(116, 75, NULL, 110000, 'Medium', 'delivered', 526, '2016-07-25 16:50:55', '2016-07-25 17:06:19'),
(118, 17, NULL, 25000, 'Medium', 'delivered', 527, '2016-07-25 18:27:47', '2016-07-25 18:29:23'),
(118, 31, 527, 5000, 'Medium', 'delivered', 528, '2016-07-25 18:27:47', '2016-07-25 18:29:23'),
(118, 63, NULL, 30000, 'Medium', 'delivered', 529, '2016-07-25 18:37:08', '2016-07-25 18:54:27'),
(118, 76, NULL, 35000, 'Medium', 'delivered', 530, '2016-07-25 18:38:38', '2016-07-25 19:08:40'),
(118, 76, NULL, 35000, 'Medium', 'cancelled', 531, '2016-07-25 18:38:41', '2016-07-25 18:38:47'),
(118, 72, NULL, 50000, 'Medium', 'cancelled', 532, '2016-07-25 18:39:20', '2016-07-25 18:39:23'),
(118, 52, NULL, 17000, 'Medium', 'delivered', 533, '2016-07-25 18:39:46', '2016-07-25 18:49:06'),
(118, 55, NULL, 17000, 'Medium', 'delivered', 534, '2016-07-25 18:39:51', '2016-07-25 18:49:06'),
(118, 56, NULL, 15000, 'Medium', 'delivered', 535, '2016-07-25 18:39:52', '2016-07-25 18:49:06'),
(118, 40, NULL, 20000, 'Medium', 'delivered', 536, '2016-07-25 18:42:41', '2016-07-25 19:08:40'),
(118, 48, 536, 0, 'Medium', 'delivered', 537, '2016-07-25 18:42:41', '2016-07-25 19:08:40'),
(118, 16, NULL, 49000, 'Medium', 'delivered', 538, '2016-07-25 18:42:50', '2016-07-25 19:01:41'),
(118, 54, NULL, 45000, 'Medium', 'delivered', 539, '2016-07-25 18:42:51', '2016-07-25 19:01:41'),
(118, 40, NULL, 20000, 'Medium', 'delivered', 540, '2016-07-25 18:43:50', '2016-07-25 19:04:41'),
(118, 48, 540, 0, 'Medium', 'delivered', 541, '2016-07-25 18:43:50', '2016-07-25 19:04:41'),
(118, 62, NULL, 35000, 'Medium', 'delivered', 542, '2016-07-25 18:46:16', '2016-07-25 19:08:40'),
(118, 40, NULL, 20000, 'Medium', 'delivered', 543, '2016-07-25 19:06:09', '2016-07-25 19:11:39'),
(118, 47, 543, 5000, 'Medium', 'delivered', 544, '2016-07-25 19:06:09', '2016-07-25 19:11:39'),
(118, 40, NULL, 20000, 'Medium', 'delivered', 545, '2016-07-25 19:06:19', '2016-07-25 19:11:39'),
(118, 48, 545, 0, 'Medium', 'delivered', 546, '2016-07-25 19:06:19', '2016-07-25 19:11:39'),
(118, 76, NULL, 35000, 'Medium', 'delivered', 547, '2016-07-25 19:07:28', '2016-07-25 19:17:01'),
(118, 76, NULL, 35000, 'Medium', 'delivered', 548, '2016-07-25 19:07:29', '2016-07-25 19:17:01'),
(118, 52, NULL, 17000, 'Medium', 'delivered', 549, '2016-07-25 19:11:53', '2016-07-25 19:17:01'),
(118, 56, NULL, 15000, 'Medium', 'delivered', 550, '2016-07-25 19:12:04', '2016-07-25 19:17:01'),
(118, 16, NULL, 49000, 'Medium', 'delivered', 551, '2016-07-25 19:21:24', '2016-07-25 19:30:03'),
(118, 53, NULL, 30000, 'Medium', 'delivered', 552, '2016-07-25 19:21:38', '2016-07-25 19:39:41'),
(118, 20, NULL, 25000, 'Medium', 'delivered', 553, '2016-07-25 19:22:11', '2016-07-25 19:35:47'),
(118, 25, 553, 12000, 'Medium', 'delivered', 554, '2016-07-25 19:22:11', '2016-07-25 19:35:47'),
(118, 40, NULL, 20000, 'Medium', 'delivered', 555, '2016-07-25 19:29:43', '2016-07-25 19:35:47'),
(118, 47, 555, 5000, 'Medium', 'delivered', 556, '2016-07-25 19:29:43', '2016-07-25 19:35:48'),
(118, 62, NULL, 35000, 'Medium', 'delivered', 557, '2016-07-25 19:29:53', '2016-07-25 19:42:01'),
(118, 76, NULL, 35000, 'Medium', 'delivered', 558, '2016-07-25 19:30:30', '2016-07-25 19:42:01'),
(119, 60, NULL, 12000, 'Medium', 'delivered', 559, '2016-07-25 19:55:19', '2016-07-25 20:00:25'),
(119, 60, NULL, 12000, 'Medium', 'delivered', 560, '2016-07-25 19:55:20', '2016-07-25 20:00:25'),
(119, 58, NULL, 30000, 'Medium', 'delivered', 561, '2016-07-25 19:55:57', '2016-07-25 20:04:07'),
(119, 66, NULL, 10000, 'Medium', 'delivered', 562, '2016-07-25 19:56:34', '2016-07-25 20:07:03'),
(119, 70, NULL, 10000, 'Medium', 'delivered', 563, '2016-07-25 19:56:45', '2016-07-25 20:07:03'),
(120, 72, NULL, 50000, 'Medium', 'delivered', 564, '2016-07-25 20:07:54', '2016-07-25 20:18:01'),
(120, 60, NULL, 12000, 'Medium', 'delivered', 565, '2016-07-25 20:08:09', '2016-07-25 20:15:05'),
(120, 55, NULL, 17000, 'Medium', 'delivered', 566, '2016-07-25 20:08:33', '2016-07-25 20:15:05'),
(120, 19, NULL, 30000, 'Large', 'delivered', 567, '2016-07-25 20:10:25', '2016-07-25 20:20:54'),
(120, 25, 567, 12000, 'Medium', 'delivered', 568, '2016-07-25 20:10:25', '2016-07-25 20:20:54'),
(120, 76, NULL, 35000, 'Medium', 'delivered', 569, '2016-07-25 20:11:00', '2016-07-25 20:20:54'),
(120, 66, NULL, 10000, 'Medium', 'delivered', 570, '2016-07-25 20:11:15', '2016-07-25 20:20:54'),
(120, 66, NULL, 10000, 'Medium', 'delivered', 571, '2016-07-25 20:11:29', '2016-07-25 20:20:53'),
(120, 66, NULL, 10000, 'Medium', 'delivered', 572, '2016-07-25 20:11:35', '2016-07-25 20:20:53'),
(120, 55, NULL, 17000, 'Medium', 'delivered', 573, '2016-07-25 20:24:16', '2016-07-25 20:30:10'),
(120, 56, NULL, 15000, 'Medium', 'cancelled', 574, '2016-07-25 20:24:21', '2016-07-25 20:24:25'),
(120, 57, NULL, 15000, 'Medium', 'delivered', 575, '2016-07-25 20:24:27', '2016-07-25 20:30:10'),
(120, 67, NULL, 20000, 'Medium', 'delivered', 576, '2016-07-25 20:33:20', '2016-07-25 20:35:02'),
(120, 67, NULL, 20000, 'Medium', 'cancelled', 577, '2016-07-25 20:33:29', '2016-07-25 20:33:33');

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
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

--
-- Dumping data for table `sessiondevice`
--

INSERT INTO `sessiondevice` (`device`, `session`, `id`, `createdAt`, `updatedAt`) VALUES
(3, 50, 72, '2016-07-13 16:35:46', '2016-07-13 16:35:46'),
(2, 51, 73, '2016-07-13 16:44:54', '2016-07-13 16:44:54'),
(3, 52, 74, '2016-07-13 17:18:14', '2016-07-13 17:18:14'),
(6, 53, 75, '2016-07-13 19:59:16', '2016-07-13 19:59:16'),
(7, 54, 76, '2016-07-13 20:57:13', '2016-07-13 20:57:13'),
(8, 55, 77, '2016-07-13 22:05:47', '2016-07-13 22:05:47'),
(8, 56, 78, '2016-07-13 22:07:21', '2016-07-13 22:07:21'),
(8, 57, 79, '2016-07-13 22:09:12', '2016-07-13 22:09:12'),
(8, 58, 80, '2016-07-13 22:10:58', '2016-07-13 22:10:58'),
(8, 59, 81, '2016-07-13 22:11:58', '2016-07-13 22:11:58'),
(8, 60, 82, '2016-07-13 22:15:23', '2016-07-13 22:15:23'),
(8, 61, 83, '2016-07-13 22:16:49', '2016-07-13 22:16:49'),
(4, 62, 84, '2016-07-13 22:17:41', '2016-07-13 22:17:41'),
(8, 62, 85, '2016-07-13 22:17:41', '2016-07-13 22:17:41'),
(2, 63, 86, '2016-07-14 22:19:24', '2016-07-14 22:19:24'),
(5, 64, 87, '2016-07-15 03:11:57', '2016-07-15 03:11:57'),
(2, 65, 88, '2016-07-16 01:53:41', '2016-07-16 01:53:41'),
(3, 66, 89, '2016-07-16 02:07:16', '2016-07-16 02:07:16'),
(3, 67, 90, '2016-07-16 10:45:00', '2016-07-16 10:45:00'),
(3, 68, 91, '2016-07-16 17:36:51', '2016-07-16 17:36:51'),
(2, 69, 92, '2016-07-16 19:36:51', '2016-07-16 19:36:51'),
(3, 69, 93, '2016-07-16 19:36:51', '2016-07-16 19:36:51'),
(2, 70, 94, '2016-07-17 12:39:38', '2016-07-17 12:39:38'),
(2, 71, 95, '2016-07-17 13:17:46', '2016-07-17 13:17:46'),
(4, 72, 96, '2016-07-17 15:23:03', '2016-07-17 15:23:03'),
(5, 72, 97, '2016-07-17 15:23:03', '2016-07-17 15:23:03'),
(2, 73, 98, '2016-07-17 16:34:48', '2016-07-17 16:34:48'),
(2, 74, 99, '2016-07-18 11:10:48', '2016-07-18 11:10:48'),
(3, 75, 100, '2016-07-18 12:05:18', '2016-07-18 12:05:18'),
(5, 77, 101, '2016-07-18 18:35:56', '2016-07-18 18:35:56'),
(3, 78, 102, '2016-07-19 08:18:54', '2016-07-19 08:18:54'),
(3, 79, 103, '2016-07-19 08:22:37', '2016-07-19 08:22:37'),
(3, 80, 104, '2016-07-19 08:39:11', '2016-07-19 08:39:11'),
(3, 81, 105, '2016-07-19 08:41:12', '2016-07-19 08:41:12'),
(3, 82, 106, '2016-07-19 08:45:52', '2016-07-19 08:45:52'),
(3, 83, 107, '2016-07-19 10:40:16', '2016-07-19 10:40:16'),
(2, 84, 108, '2016-07-19 10:41:02', '2016-07-19 10:41:02'),
(7, 85, 109, '2016-07-19 10:41:09', '2016-07-19 10:41:09'),
(7, 86, 110, '2016-07-19 12:23:10', '2016-07-19 12:23:10'),
(3, 87, 111, '2016-07-20 09:31:24', '2016-07-20 09:31:24'),
(2, 88, 112, '2016-07-20 12:15:04', '2016-07-20 12:15:04'),
(5, 91, 113, '2016-07-22 12:56:12', '2016-07-22 12:56:12'),
(5, 92, 114, '2016-07-22 17:07:47', '2016-07-22 17:07:47'),
(3, 93, 115, '2016-07-22 18:49:20', '2016-07-22 18:49:20'),
(5, 94, 116, '2016-07-22 20:17:29', '2016-07-22 20:17:29'),
(2, 96, 117, '2016-07-23 14:52:26', '2016-07-23 14:52:26'),
(3, 97, 118, '2016-07-23 18:01:39', '2016-07-23 18:01:39'),
(3, 98, 119, '2016-07-23 18:10:10', '2016-07-23 18:10:10'),
(3, 100, 120, '2016-07-23 20:11:55', '2016-07-23 20:11:55'),
(4, 101, 121, '2016-07-23 20:20:31', '2016-07-23 20:20:31'),
(7, 102, 122, '2016-07-23 20:40:02', '2016-07-23 20:40:02'),
(2, 106, 123, '2016-07-24 14:22:30', '2016-07-24 14:22:30'),
(4, 109, 124, '2016-07-24 15:30:16', '2016-07-24 15:30:16'),
(3, 110, 125, '2016-07-24 17:17:19', '2016-07-24 17:17:19'),
(5, 111, 126, '2016-07-24 17:44:04', '2016-07-24 17:44:04'),
(5, 113, 127, '2016-07-24 20:26:56', '2016-07-24 20:26:56'),
(3, 114, 128, '2016-07-25 12:55:11', '2016-07-25 12:55:11'),
(5, 115, 129, '2016-07-25 13:04:26', '2016-07-25 13:04:26'),
(3, 116, 130, '2016-07-25 16:50:06', '2016-07-25 16:50:06'),
(4, 118, 131, '2016-07-25 18:27:15', '2016-07-25 18:27:15'),
(5, 118, 132, '2016-07-25 18:27:15', '2016-07-25 18:27:15'),
(3, 119, 133, '2016-07-25 19:53:53', '2016-07-25 19:53:53'),
(2, 120, 134, '2016-07-25 20:05:52', '2016-07-25 20:05:52');

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
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `dish`
--
ALTER TABLE `dish`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=77;
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
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=121;
--
-- AUTO_INCREMENT for table `sessiondetail`
--
ALTER TABLE `sessiondetail`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=578;
--
-- AUTO_INCREMENT for table `sessiondevice`
--
ALTER TABLE `sessiondevice`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=135;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
