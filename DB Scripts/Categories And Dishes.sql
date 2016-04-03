INSERT INTO `category` (`name`, `description`, `status`, `parentCategory`, `nameEn`, `id`, `createdAt`, `updatedAt`) VALUES
('Fries', 'Bánh', 'enable', NULL, NULL, 1, '2016-04-02 16:28:00', '2016-04-16 06:55:45'),
('Potato', 'S?t description', 'enable', 1, 'Potato', 2, '2016-04-02 16:28:00', '2016-04-02 16:28:00'),
('Fries', 'L?c Description', 'enable', 1, 'Fries', 3, '2016-04-02 16:28:00', '2016-04-02 16:28:00'),
('Potato Dishes', 'Potato Dishes', 'enable', 2, 'Potato Dishes', 4, '2016-04-02 16:28:00', '2016-04-02 16:28:00'),
('Dip', 'Dip', 'enable', 2, 'Dip', 5, '2016-04-02 16:28:00', '2016-04-02 16:28:00'),
('Shake', 'Shake', 'enable', 2, 'Shake', 6, '2016-04-02 16:28:00', '2016-04-02 16:28:00'),
('Fries Dishes', 'Fries Dishes', 'enable', 3, 'Fries Dishes', 7, '2016-04-02 16:28:00', '2016-04-02 16:28:00'),
('Dip', 'Dip', 'enable', 3, 'Dip', 8, '2016-04-02 16:28:00', '2016-04-02 16:28:00')

INSERT INTO `potato-king-pos`.`dish` 
(`category` , `name`       , `nameEn`       , `description` , `price` , `status` , `order` , `mainImage`                  ,`createdAt`           , `updatedAt`) VALUES
('4'       , 'French Fries' , 'French FriesEn' , 'French Fries'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('4'       , 'Curly Fries' , 'Curly FriesEn' , 'Curly Fries'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('4'       , 'Crinkle Fries' , 'Crinkle FriesEn' , 'Crinkle Fries'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('4'       , 'Potato Wedges' , 'Potato WedgesEn' , 'Potato Wedges'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),

('5'       , 'Testing Dip 529' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 706' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 850' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 399' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 416' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 752' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 529' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 662' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('5'       , 'Testing Dip 153' , 'Testing Dip En' , 'Testing Dip Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),

('6'       , 'Tesing Shake 75' , 'Tesing Shake 75 En' , 'Tesing Shake 75 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 734' , 'Tesing Shake 734 En' , 'Tesing Shake 734 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 951' , 'Tesing Shake 951 En' , 'Tesing Shake 951 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 785' , 'Tesing Shake 785 En' , 'Tesing Shake 785 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 610' , 'Tesing Shake 610 En' , 'Tesing Shake 610 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 379' , 'Tesing Shake 379 En' , 'Tesing Shake 379 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 626' , 'Tesing Shake 626 En' , 'Tesing Shake 626 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 495' , 'Tesing Shake 495 En' , 'Tesing Shake 495 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 669' , 'Tesing Shake 669 En' , 'Tesing Shake 669 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('6'       , 'Tesing Shake 402' , 'Tesing Shake 402 En' , 'Tesing Shake 402 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),


('7'       , 'Testing Fries 795' , 'Testing Fries 795 En' , 'Testing Fries 795 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('7'       , 'Testing Fries 487' , 'Testing Fries 487 En' , 'Testing Fries 487 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('7'       , 'Testing Fries 628' , 'Testing Fries 628 En' , 'Testing Fries 628 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('7'       , 'Testing Fries 172' , 'Testing Fries 172 En' , 'Testing Fries 172 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('7'       , 'Testing Fries 457' , 'Testing Fries 457 En' , 'Testing Fries 457 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('7'       , 'Testing Fries 929' , 'Testing Fries 929 En' , 'Testing Fries 929 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('7'       , 'Testing Fries 775' , 'Testing Fries 775 En' , 'Testing Fries 775 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),

('8'       , 'Testing Dip For Fries 163' , 'Testing Dip For Fries 163 En' , 'Testing Dip For Fries 163 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('8'       , 'Testing Dip For Fries 33' , 'Testing Dip For Fries 33 En' , 'Testing Dip For Fries 33 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('8'       , 'Testing Dip For Fries 198' , 'Testing Dip For Fries 198 En' , 'Testing Dip For Fries 198 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('8'       , 'Testing Dip For Fries 530' , 'Testing Dip For Fries 530 En' , 'Testing Dip For Fries 530 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45'),
('8'       , 'Testing Dip For Fries 396' , 'Testing Dip For Fries 396 En' , 'Testing Dip For Fries 396 Description'  , '50000' , 'enable' , '1'     , '/img/template/no-image.jpg' ,'2016-04-16 06:55:45' , '2016-04-16 06:55:45')