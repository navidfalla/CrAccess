-- phpMyAdmin SQL Dump
-- version 4.0.10.17
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 01, 2016 at 03:53 AM
-- Server version: 5.5.52
-- PHP Version: 5.6.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wheels`
--

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type_id` int(11) NOT NULL,
  `user_1_id` int(11) NOT NULL,
  `user_2_id` int(11) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `data_1` text,
  `data_2` text,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `event_type_id` (`event_type_id`),
  KEY `user_1_id` (`user_1_id`),
  KEY `user_2_id` (`user_2_id`),
  KEY `product_2_id` (`issue_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=116 ;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`id`, `event_type_id`, `user_1_id`, `user_2_id`, `issue_id`, `data_1`, `data_2`, `date_created`) VALUES
(61, 1, 2, 3, NULL, NULL, NULL, '2016-11-15 01:41:46'),
(62, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 01:41:56'),
(63, 1, 2, 3, NULL, NULL, NULL, '2016-11-15 01:45:20'),
(64, 2, 2, NULL, 53, NULL, NULL, '2016-11-15 01:58:31'),
(65, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:03:19'),
(66, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:03:45'),
(67, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:03:49'),
(68, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:03:52'),
(69, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:03:57'),
(70, 1, 2, 4, NULL, NULL, NULL, '2016-11-15 02:04:36'),
(71, 1, 2, 3, NULL, NULL, NULL, '2016-11-15 02:25:05'),
(72, 1, 2, 4, NULL, NULL, NULL, '2016-11-15 02:25:06'),
(73, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:25:08'),
(74, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:25:08'),
(75, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:38:11'),
(76, 1, 7, 5, NULL, NULL, NULL, '2016-11-15 04:07:33'),
(77, 1, 5, 7, NULL, NULL, NULL, '2016-11-15 04:08:40'),
(79, 1, 5, 7, NULL, NULL, NULL, '2016-11-15 04:18:09'),
(80, 1, 5, 2, NULL, NULL, NULL, '2016-11-15 04:46:24'),
(81, 1, 5, 7, NULL, NULL, NULL, '2016-11-15 04:46:31'),
(82, 1, 5, 6, NULL, NULL, NULL, '2016-11-16 15:49:24'),
(84, 2, 6, NULL, 56, NULL, NULL, '2016-11-16 16:00:22'),
(85, 1, 5, 6, NULL, NULL, NULL, '2016-11-16 17:27:15'),
(86, 2, 6, NULL, 57, NULL, NULL, '2016-11-16 17:28:32'),
(87, 1, 5, 6, NULL, NULL, NULL, '2016-11-17 04:33:31'),
(88, 2, 6, NULL, 59, NULL, NULL, '2016-11-17 04:36:43'),
(89, 1, 7, 4, NULL, NULL, NULL, '2016-11-17 04:39:28'),
(90, 1, 5, 7, NULL, NULL, NULL, '2016-11-17 14:49:02'),
(91, 1, 5, 7, NULL, NULL, NULL, '2016-11-17 14:49:04'),
(92, 1, 5, 7, NULL, NULL, NULL, '2016-11-17 14:49:51'),
(93, 2, 6, NULL, 60, NULL, NULL, '2016-11-17 14:52:12'),
(94, 2, 6, NULL, 61, NULL, NULL, '2016-11-17 15:40:55'),
(95, 1, 5, 6, NULL, NULL, NULL, '2016-11-17 15:56:08'),
(96, 2, 6, NULL, 62, NULL, NULL, '2016-11-17 15:57:34'),
(97, 1, 7, 4, NULL, NULL, NULL, '2016-11-17 15:59:18'),
(98, 1, 7, 5, NULL, NULL, NULL, '2016-11-19 14:07:35'),
(99, 1, 7, 5, NULL, NULL, NULL, '2016-11-19 14:09:08'),
(100, 1, 5, 6, NULL, NULL, NULL, '2016-11-19 21:04:46'),
(101, 2, 6, NULL, 63, NULL, NULL, '2016-11-19 21:10:15'),
(102, 1, 5, 7, NULL, NULL, NULL, '2016-11-20 17:19:04'),
(103, 2, 6, NULL, 64, NULL, NULL, '2016-11-20 17:20:49'),
(104, 1, 8, 3, NULL, NULL, NULL, '2016-11-20 20:36:29'),
(105, 2, 7, NULL, 65, NULL, NULL, '2016-11-20 20:37:33'),
(106, 1, 7, 1, NULL, NULL, NULL, '2016-11-20 20:45:48'),
(107, 1, 5, 6, NULL, NULL, NULL, '2016-11-21 22:05:15'),
(108, 2, 6, NULL, 66, NULL, NULL, '2016-11-21 22:07:08'),
(109, 1, 1, 6, NULL, NULL, NULL, '2016-12-01 01:34:59'),
(110, 1, 7, 8, NULL, NULL, NULL, '2016-12-01 01:35:31'),
(111, 1, 1, 4, NULL, NULL, NULL, '2016-12-01 01:36:25'),
(112, 1, 1, 7, NULL, NULL, NULL, '2016-12-01 02:41:10'),
(113, 1, 1, 7, NULL, NULL, NULL, '2016-12-01 02:41:11'),
(114, 1, 1, 8, NULL, NULL, NULL, '2016-12-01 02:41:23'),
(115, 1, 7, 5, NULL, NULL, NULL, '2016-12-01 03:13:49');

-- --------------------------------------------------------

--
-- Table structure for table `event_type`
--

CREATE TABLE IF NOT EXISTS `event_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `event_type`
--

INSERT INTO `event_type` (`id`, `name`) VALUES
(1, 'follow_user'),
(2, 'report_issue');

-- --------------------------------------------------------

--
-- Table structure for table `follow`
--

CREATE TABLE IF NOT EXISTS `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower_id` int(11) NOT NULL,
  `followee_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `follower` (`follower_id`),
  KEY `follower_2` (`follower_id`),
  KEY `followee` (`followee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=129 ;

--
-- Dumping data for table `follow`
--

INSERT INTO `follow` (`id`, `follower_id`, `followee_id`, `date_created`) VALUES
(118, 5, 7, '0000-00-00 00:00:00'),
(119, 8, 3, '0000-00-00 00:00:00'),
(120, 7, 1, '0000-00-00 00:00:00'),
(121, 5, 6, '0000-00-00 00:00:00'),
(122, 1, 6, '0000-00-00 00:00:00'),
(123, 7, 8, '0000-00-00 00:00:00'),
(124, 1, 4, '0000-00-00 00:00:00'),
(128, 7, 5, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `issue`
--

CREATE TABLE IF NOT EXISTS `issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `description` varchar(400) NOT NULL,
  `summary` varchar(200) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added_by` int(11) NOT NULL,
  `img` varchar(500) NOT NULL,
  `solved` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `added_by` (`added_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=67 ;

--
-- Dumping data for table `issue`
--

INSERT INTO `issue` (`id`, `address`, `description`, `summary`, `date_added`, `added_by`, `img`, `solved`) VALUES
(2, '800 Washington Street, Blacksburg', 'This ramp is very steep. Actually it has a more than 25 percent slope on a metal. that means if you go on it on wheels you will be on a roller coaster...', 'not a ramp!!!', '2016-12-01 03:23:18', 1, 'not_accessible2.jpg, stairs1.jpg, stairs2.jpg, stairs3.jpg, stairs4.jpg', 1),
(28, '240 Kent St', 'There is a tree in the middle of stairs, someone with my size will have a hard time passing in between the stairs.', 'tree in the stairs', '2016-12-01 03:23:36', 1, 'not_accessible.jpg, not_accessible2.jpg, not_accessible3.jpg, not_accessible4.jpg', 1),
(29, '320 Drillfield Dr', 'There is a tree in the middle of stairways. someone with a big size will have a very hard time passing the narrow space.', 'tree in the stairs', '2016-12-01 02:40:50', 1, 'not_accessible.jpg, not_accessible2.jpg, not_accessible3.jpg, not accessible4.jpg, ', 2),
(30, '2875 Oak Lane', 'Please make a ramp here, there is no other ramp in between the parking and the building so if a disabled person park in this parking cannot get to the building.', 'No ramp', '2016-12-01 02:41:01', 1, 'noramp.jpg, noramp2.jpg, noramp3.jpg, noramp4.jpg,   ', 0),
(47, '', 'Write a description of the issue in detail...', 'Write a summary less than 20 words...', '2016-11-14 16:50:41', 1, '', 0),
(48, '', 'Write a description of the issue in detail...', 'Write a summary less than 20 words...', '2016-11-14 16:54:25', 4, '', 0),
(52, 'CRC, Blacksburg', 'Write a description of the issue in detail...', 'Write a summary less than 20 words...', '2016-11-15 01:30:10', 2, '', 0),
(53, 'CRC, Blacksburg', 'Write a description of the issue in detail...', 'Write a summary less than 20 words...', '2016-11-15 01:58:31', 2, '', 0),
(56, '155 Otey st.', 'test desc', 'test summary', '2016-11-16 16:00:22', 6, '', 0),
(57, 'empty 2', '2', '2', '2016-11-16 17:29:14', 6, '', 0),
(59, '11234, Virginia tech', 'Test Issue edited', 'Test Issue one', '2016-11-17 04:37:28', 6, '', 0),
(60, '', 'Write a description of the issue in detail...adf', 'Write a summary less than 20 words...adsf', '2016-11-17 14:52:12', 6, '', 0),
(61, 'test', '1', 'Write a summary less than 20 words...', '2016-11-17 15:41:48', 6, '', 0),
(62, 'Pumpkin Express', 'I cannot find any pumpkins.', 'I wish there were pumpkins.', '2016-11-17 15:57:34', 6, '', 0),
(63, '190 Alumni Mall, Blacksburg, VA 24060', 'toilet clogged residential hall!', 'Toilet clogged, will not flush, needs bathroom really bad!', '2016-11-19 21:17:57', 6, '', 0),
(64, 'New Class Room Building', 'This is a test issue', 'This is a test issue', '2016-11-20 17:20:49', 6, '', 0),
(65, 'Here''s an issue', 'Some issue details', 'Some issue summaries', '2016-11-20 20:37:33', 7, '', 0),
(66, 'Blacksburg', 'street lamp not working.', 'Street Lamp not working in Turner''s street.', '2016-11-21 22:08:30', 6, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `privilege` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `privilege`) VALUES
(1, 'Navid', 'Falla', 'navidb@vt.edu', 'nav1212', '1234', 0),
(2, 'Sneha', 'Mehta', 'snehamehta@vt.edu', 'sumehta', '1345', 0),
(3, 'Tianyi', 'Li', 'tli@vt.edu', 'tianyi', '1567', 0),
(4, 'John', 'Oliver', 'johnoliver.vt.edu', 'johnoliver', '1453', 1),
(5, 'TestUserF1', 'TestUserL1', 'test_user1@craccess.com', 'user_craccess', 'cs5774f16', 1),
(6, 'TestUserF2', 'TestUserL2', 'test_user2@craccess.com', 'moderator_craccess', 'cs5774f16', 0),
(7, 'TestUserF3', 'TestUserL3', 'test_user3@craccess.com', 'admin_craccess', 'cs5774f16', 2),
(8, 'Kurt', 'Luther', 'kluther@vt.edu', 'kurtluther', 'test', 1),
(9, 'Tianyi', 'LI', 'abc@abc.com', 'aaa', 'aaa', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `issue`
--
ALTER TABLE `issue`
  ADD CONSTRAINT `issue_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
