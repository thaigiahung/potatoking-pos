-- phpMyAdmin SQL Dump
-- version 4.2.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 20, 2016 at 04:01 PM
-- Server version: 5.5.43-0ubuntu0.14.10.1
-- PHP Version: 5.5.12-2ubuntu4.4

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=22 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`name`, `description`, `status`, `parentCategory`, `nameEn`, `image`, `id`, `createdAt`, `updatedAt`) VALUES
('Fries', 'Bánh', 'enable', NULL, 'Fries', '/img/template/category/fries.jpg', 1, '2016-04-04 02:53:00', '2016-04-17 17:20:45'),
('Khoai Tây', 'S?t description', 'enable', 1, 'Potato', NULL, 2, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Đồ Chiên', 'L?c Description', 'enable', 1, 'Fries', NULL, 3, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Potato Dishes', 'Potato Dishes', 'enable', 2, 'Potato Dishes', NULL, 4, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Sốt', 'Dip', 'enable', 2, 'Dip', NULL, 5, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Lắc', 'Shake', 'enable', 2, 'Shake', NULL, 6, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Fries Dishes', 'Fries Dishes', 'enable', 3, 'Fries Dishes', NULL, 7, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Sốt', 'Dip', 'enable', 3, 'Dip', NULL, 8, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Burger', 'TestingDishes385', 'enable', NULL, 'Burger', '/img/template/category/burger.jpg', 16, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Taco', 'TestingDishes81', 'enable', NULL, 'Taco', '/img/template/category/taco.jpg', 17, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Salad & Soup', 'TestingDishes53', 'enable', NULL, 'Salad & Soup', '/img/template/category/soupsalad.jpg', 18, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Drink', 'TestingDishes419', 'enable', NULL, 'Drink', '/img/template/category/drink.jpg', 19, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('Combo', 'TestingDishes502', 'enable', NULL, 'Combo', '/img/template/category/combo.jpg', 20, '2016-04-04 02:53:00', '2016-04-04 02:53:00'),
('TestingDishes21', 'TestingDishes661', 'disable', NULL, 'TestingDishes166', NULL, 21, '2016-04-04 02:53:00', '2016-04-04 02:53:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`mac`, `table`, `connecting`, `socketId`, `status`, `opening`, `id`, `createdAt`, `updatedAt`) VALUES
(NULL, 1, 1, 'O9q-n_5LPEayaBprR3ep', 'enable', 1, 2, '2016-03-29 15:13:00', '2016-05-20 16:00:18'),
(NULL, 2, 0, 'BeHCl8SYTMV6as6fvHKw', 'enable', 0, 3, '2016-02-19 08:12:00', '2016-04-19 15:44:00'),
(NULL, 3, 0, '6K9QptGT0tEzNRraHHX6', 'enable', 0, 4, '2018-01-11 02:26:00', '2016-04-19 08:19:13'),
(NULL, 4, 1, 'BeG8wmJxtBm12Mcqt_2D', 'enable', 1, 5, '2016-01-03 20:44:00', '2016-04-19 15:39:07'),
(NULL, 5, 0, '1nXZzlzautMMDgEmIRY2', 'enable', 0, 6, '2015-12-29 02:53:00', '2016-04-17 21:54:35'),
(NULL, 6, 0, 'NaG5tEMhfFkH9BtaYW8J', 'enable', 0, 7, '2015-12-22 02:53:00', '2016-04-02 15:35:33'),
(NULL, 7, 0, NULL, 'enable', 0, 8, '2015-12-29 02:53:00', '2015-12-29 02:53:00'),
(NULL, 8, 0, NULL, 'enable', 0, 9, '2015-12-29 02:53:00', '2015-12-29 02:53:00'),
(NULL, 100, 0, 'e5D615UwUSvYClKNuTAh', 'enable', 0, 10, '2016-04-20 12:09:00', '2016-06-09 06:01:56'),
(NULL, 101, 0, 'JSMZEdoF8w4BrZJqYW7_', 'enable', 0, 11, '2016-03-25 02:53:00', '2016-03-25 13:01:58'),
(NULL, 102, NULL, NULL, 'enable', 0, 12, '2016-03-25 02:53:00', '2016-03-25 02:53:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `deviceip`
--

INSERT INTO `deviceip` (`device`, `ip`, `type`, `id`, `createdAt`, `updatedAt`) VALUES
(2, '1', 'guest', 1, '2016-01-23 02:53:00', '2016-01-23 02:53:00'),
(3, '127.0.2', 'chief-cook', 2, '2016-01-23 02:53:00', '2016-01-23 02:53:00'),
(10, '2', 'chief-cook', 3, '2016-01-29 02:53:00', '2016-01-29 02:53:00'),
(3, '127.0.0.1', 'cashier', 4, '2016-01-29 02:53:00', '2016-01-29 02:53:00'),
(4, '192.168.1.18', 'cashier', 5, '2016-01-29 02:53:00', '2016-01-29 02:53:00'),
(5, '192.168.1.15', 'guest', 6, '2016-02-12 02:53:00', '2016-02-12 02:53:00'),
(5, '192.168.2.104', 'guest', 7, '2016-03-20 02:53:00', '2016-03-20 02:53:00'),
(10, '192.168.11.21', 'cashier', 8, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(7, '192.168.11.13', 'guest', 9, '2016-03-18 02:53:00', '2016-03-24 02:53:00'),
(2, '192.168.11.14', 'guest', 10, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(3, '192.168.11.15', 'guest', 11, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(4, '192.168.11.16', 'guest', 12, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(5, '192.168.11.17', 'guest', 13, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(6, '192.168.1.99', 'guest', 14, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(11, '192.168.11.4', 'chief-cook', 15, '2016-03-25 02:53:00', '2016-03-25 02:53:00'),
(2, '192.168.0.83', 'guest', 16, '2016-04-27 13:46:00', '2016-04-27 13:46:00');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=52 ;

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
(4, 'French Fries', 'French Fries En', '                        <div class="row-fluid">\n                            <div class="span4">something here something something something something something </div>\n                            <div class="span8">Some other things here\n                                <ul>\n                                    <li>What will stay here</li>\n                                    <li>What will stay here</li>\n                                    <li>What will stay here</li>\n                                </ul>\n                            </div>\n                        </div>\n                        <b>Something ball</b> \n                        Add something something something something something something something something something something something something something something something something something something something something something something something something something something something something something ', 45, 'disable', NULL, '/img/template/sub-category/french-fries.png', 11, '2016-04-15 21:58:58', '2016-04-15 21:58:58'),
(4, 'Shake 2', 'Shake Name En', '', 55, 'disable', NULL, '/img/template/no-image.jpg', 12, '2016-04-15 22:00:37', '2016-04-16 19:53:19'),
(4, 'Shake 3', 'Shake Name En', '', 33, 'disable', NULL, '/img/template/no-image.jpg', 13, '2016-04-16 19:53:34', '2016-04-16 19:53:34'),
(1, '55', NULL, '', 55, 'disable', NULL, '/img/template/no-image.jpg', 14, '2016-04-16 19:54:11', '2016-04-16 19:54:11'),
(2, '444', NULL, '', 444, 'enable', NULL, '/img/template/no-image.jpg', 15, '2016-04-16 20:21:06', '2016-04-16 20:21:06'),
(16, 'Burger', 'Burger', 'ThisIsName', 50000, 'enable', 1, '/img/template/dish/burger.png', 16, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'French Fries', 'French FriesEn', 'French Fries', 50000, 'enable', 1, '/img/template/sub-category/french-fries.png', 17, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Curly Fries', 'Curly FriesEn', 'Curly Fries', 50000, 'enable', 1, '/img/template/sub-category/curly-fries.png', 18, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Crinkle Fries', 'Crinkle FriesEn', 'Crinkle Fries', 50000, 'enable', 1, '/img/template/sub-category/crinkle-fries.png', 19, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(4, 'Potato Wedges', 'Potato WedgesEn', 'Potato Wedges', 50000, 'enable', 1, '/img/template/sub-category/potato-wedges.png', 20, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 21, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 22, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 23, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 24, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 25, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 26, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese4.png', 27, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese5.png', 28, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(5, 'Sốt phô mai', 'Cheese sause', 'Testing Dip Description', 50000, 'enable', 1, '/img/template/dish/cheese3.png', 29, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 75 Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 30, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 734 Description', 50000, 'enable', 1, '/img/template/dish/cheese3.png', 31, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 951 Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 32, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 785 Description', 50000, 'enable', 1, '/img/template/dish/cheese4.png', 33, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 610 Description', 50000, 'enable', 1, '/img/template/dish/cheese5.png', 34, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 379 Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 35, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 626 Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 36, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 495 Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 37, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 669 Description', 50000, 'enable', 1, '/img/template/dish/cheese5.png', 38, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(6, 'Bột phô mai', 'Cheese sause', 'Tesing Shake 402 Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 39, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Hành vòng', 'Onion ring', 'Testing Fries 795 Description', 50000, 'enable', 1, '/img/template/dish/onion-ring.png', 40, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Cá chiên bột', 'Fish nugget', 'Testing Fries 487 Description', 50000, 'enable', 1, '/img/template/dish/fish-nugget.png', 41, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Tôm chiên bột', 'Shirmp fries', 'Testing Fries 628 Description', 50000, 'enable', 1, '/img/template/dish/shrimp-fries.png', 42, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 172', 'Testing Fries 172 En', 'Testing Fries 172 Description', 50000, 'enable', 1, '/img/template/no-image.jpg', 43, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 457', 'Testing Fries 457 En', 'Testing Fries 457 Description', 50000, 'enable', 1, '/img/template/no-image.jpg', 44, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 929', 'Testing Fries 929 En', 'Testing Fries 929 Description', 50000, 'enable', 1, '/img/template/no-image.jpg', 45, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(7, 'Testing Fries 775', 'Testing Fries 775 En', 'Testing Fries 775 Description', 50000, 'enable', 1, '/img/template/no-image.jpg', 46, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 163 Description', 50000, 'enable', 1, '/img/template/dish/cheese2.png', 47, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 33 Description', 50000, 'enable', 1, '/img/template/dish/cheese.png', 48, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 198 Description', 50000, 'enable', 1, '/img/template/dish/cheese3.png', 49, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 530 Description', 50000, 'enable', 1, '/img/template/dish/cheese4.png', 50, '2016-04-17 17:20:45', '2016-04-17 17:20:45'),
(8, 'Sốt phô mai', 'Cheese sause', 'Testing Dip For Fries 396 Description', 50000, 'enable', 1, '/img/template/dish/cheese5.png', 51, '2016-04-17 17:20:45', '2016-04-17 17:20:45');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=953 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=47 ;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`dish`, `name`, `price`, `id`, `createdAt`, `updatedAt`) VALUES
(11, 'Large', 494949, 19, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(12, 'Large', 494949, 20, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(13, 'Large', 494949, 21, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(17, 'Large', 494949, 22, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(18, 'Large', 494949, 23, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(19, 'Large', 494949, 24, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(20, 'Large', 494949, 25, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
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
(17, 'Jumbo', 6000000, 36, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(18, 'Jumbo', 6000000, 37, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(19, 'Jumbo', 6000000, 38, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
(20, 'Jumbo', 6000000, 39, '2016-04-10 03:32:00', '2016-04-10 03:32:00'),
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`table`, `status`, `total`, `receive`, `change`, `paymentStatus`, `deliveryType`, `startTime`, `endTime`, `id`, `createdAt`, `updatedAt`) VALUES
('4', 'close', 0, 5, 5, 'paid', 'dine-in', '2016-04-19 14:53:12', '2016-04-19 14:53:12', 7, '2016-04-19 14:53:12', '2016-04-19 08:10:47'),
('1', 'close', 0, 5, 5, 'paid', 'dine-in', '2016-04-19 14:59:15', '2016-04-19 14:59:15', 8, '2016-04-19 14:59:15', '2016-04-19 08:11:35'),
('1', 'open', 0, 0, 0, NULL, 'dine-in', '2016-04-19 08:11:46', '2016-04-19 08:11:46', 9, '2016-04-19 08:11:46', '2016-04-19 08:11:46');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=73 ;

--
-- Dumping data for table `sessiondetail`
--

INSERT INTO `sessiondetail` (`session`, `dish`, `parent`, `price`, `size`, `status`, `id`, `createdAt`, `updatedAt`) VALUES
(9, 11, NULL, 494949, 19, 'cancelled', 41, '2016-04-19 15:44:17', '2016-05-20 11:40:32'),
(9, 11, NULL, 45, 0, 'cancelled', 42, '2016-04-19 15:49:20', '2016-05-20 11:40:31'),
(9, 5, NULL, 20000, 0, 'cancelled', 43, '2016-04-19 15:49:25', '2016-05-20 11:40:31'),
(9, 11, NULL, 45, 0, 'cancelled', 44, '2016-04-25 05:00:24', '2016-05-20 13:13:51'),
(9, 5, NULL, 20000, 0, 'cancelled', 45, '2016-04-25 05:00:24', '2016-05-20 13:13:55'),
(9, 11, NULL, 45, 0, 'cancelled', 46, '2016-04-25 05:03:15', '2016-05-20 13:13:52'),
(9, 5, NULL, 20000, 0, 'cancelled', 47, '2016-04-25 05:47:59', '2016-05-20 13:13:56'),
(9, 11, NULL, 45, 0, 'cancelled', 48, '2016-04-26 10:19:20', '2016-05-20 13:13:53'),
(9, 11, NULL, 45, 0, 'cancelled', 49, '2016-04-27 21:59:56', '2016-05-20 13:13:54'),
(9, 5, NULL, 20000, 0, 'cancelled', 50, '2016-04-27 21:59:57', '2016-05-20 13:13:57'),
(9, 11, NULL, 45, 0, 'cancelled', 51, '2016-04-27 22:02:32', '2016-05-20 13:13:57'),
(9, 5, NULL, 20000, 0, 'cancelled', 52, '2016-04-27 22:02:32', '2016-05-20 13:13:58'),
(9, 11, NULL, 45, 0, 'cancelled', 53, '2016-04-27 22:05:09', '2016-05-20 13:13:58'),
(9, 5, NULL, 20000, 0, 'cancelled', 54, '2016-04-27 22:05:09', '2016-05-20 13:13:58'),
(9, 11, NULL, 45, 0, 'cancelled', 55, '2016-04-27 22:05:29', '2016-05-20 13:13:58'),
(9, 5, NULL, 20000, 0, 'cancelled', 56, '2016-04-27 22:05:29', '2016-05-20 13:13:58'),
(9, 11, NULL, 45, 0, 'cancelled', 57, '2016-04-27 22:05:42', '2016-05-20 13:13:59'),
(9, 5, NULL, 20000, 0, 'cancelled', 58, '2016-04-27 22:05:42', '2016-05-20 13:13:59'),
(9, 17, NULL, 50000, 0, 'cancelled', 59, '2016-05-20 15:28:46', '2016-05-20 15:37:02'),
(9, 5, 59, 20000, 0, 'cancelled', 60, '2016-05-20 15:28:46', '2016-05-20 15:37:02'),
(9, 17, NULL, 50000, 0, 'cancelled', 61, '2016-05-20 15:29:14', '2016-05-20 15:29:18'),
(9, 5, 61, 20000, 0, 'cancelled', 62, '2016-05-20 15:29:14', '2016-05-20 15:29:18'),
(9, 19, NULL, 50000, 0, 'cancelled', 63, '2016-05-20 15:34:39', '2016-05-20 15:37:01'),
(9, 6, 63, 20000, 0, 'cancelled', 64, '2016-05-20 15:34:39', '2016-05-20 15:37:01'),
(9, 19, NULL, 50000, 0, 'cancelled', 65, '2016-05-20 15:37:14', '2016-05-20 16:00:23'),
(9, 5, 65, 20000, 0, 'cancelled', 66, '2016-05-20 15:37:14', '2016-05-20 16:00:23'),
(9, 40, NULL, 50000, 0, 'cancelled', 67, '2016-05-20 15:48:39', '2016-05-20 16:00:22'),
(9, 48, 67, 50000, 0, 'cancelled', 68, '2016-05-20 15:48:39', '2016-05-20 16:00:22'),
(9, 40, NULL, 50000, 0, 'cancelled', 69, '2016-05-20 15:49:57', '2016-05-20 15:54:23'),
(9, 49, 69, 50000, 0, 'cancelled', 70, '2016-05-20 15:49:58', '2016-05-20 15:54:23'),
(9, 19, NULL, 50000, 0, 'added', 71, '2016-05-20 16:00:27', '2016-05-20 16:00:27'),
(9, 5, 71, 20000, 0, 'added', 72, '2016-05-20 16:00:27', '2016-05-20 16:00:27');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=19 ;

--
-- Dumping data for table `sessiondevice`
--

INSERT INTO `sessiondevice` (`device`, `session`, `id`, `createdAt`, `updatedAt`) VALUES
(4, 1, 1, '2016-03-26 15:00:08', '2016-03-26 15:00:08'),
(4, 2, 2, '2016-03-26 15:00:08', '2016-03-26 15:00:08'),
(4, 3, 3, '2016-03-26 15:06:18', '2016-03-26 15:06:18'),
(4, 4, 4, '2016-03-26 20:39:54', '2016-03-26 20:39:54'),
(4, 6, 5, '2016-03-27 00:25:59', '2016-03-27 00:25:59'),
(4, 7, 6, '2016-03-27 00:33:41', '2016-03-27 00:33:41'),
(4, 4, 7, '2016-03-27 23:37:39', '2016-03-27 23:37:39'),
(4, 6, 8, '2016-03-27 23:49:42', '2016-03-27 23:49:42'),
(4, 7, 9, '2016-03-28 00:27:53', '2016-03-28 00:27:53'),
(4, 8, 10, '2016-04-02 15:35:14', '2016-04-02 15:35:14'),
(4, 9, 11, '2016-04-02 15:35:33', '2016-04-02 15:35:33'),
(3, 4, 12, '2016-04-19 04:46:17', '2016-04-19 04:46:17'),
(4, 5, 13, '2016-04-19 05:53:09', '2016-04-19 05:53:09'),
(5, 6, 14, '2016-04-19 07:45:36', '2016-04-19 07:45:36'),
(5, 7, 15, '2016-04-19 08:00:12', '2016-04-19 08:00:12'),
(2, 8, 16, '2016-04-19 08:06:15', '2016-04-19 08:06:15'),
(2, 9, 17, '2016-04-19 08:11:46', '2016-04-19 08:11:46'),
(5, 9, 18, '2016-04-19 08:11:46', '2016-04-19 08:11:46');

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
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `device`
--
ALTER TABLE `device`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `deviceip`
--
ALTER TABLE `deviceip`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `dish`
--
ALTER TABLE `dish`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=52;
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
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `sessiondetail`
--
ALTER TABLE `sessiondetail`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=73;
--
-- AUTO_INCREMENT for table `sessiondevice`
--
ALTER TABLE `sessiondevice`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
