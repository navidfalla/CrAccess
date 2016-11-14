-- phpMyAdmin SQL Dump
-- version 4.0.10.17
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 31, 2016 at 10:17 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `issue`
--

INSERT INTO `issue` (`id`, `address`, `description`, `summary`, `date_added`, `added_by`, `img`, `solved`) VALUES
(2, '400 Washington Street', 'This ramp is very steep. Actually it has a more than 25 percent slope on a metal. that means if you go on it on wheels you will be on a roller coaster.?', 'not a ramp', '2016-10-31 22:13:40', 2, 'not_accessible2.jpg, stairs1.jpg, stairs2.jpg, stairs3.jpg, stairs4.jpg', 2),
(24, '700 Washington St', 'This street has very bad asphalt. I running here with my infant who is in a stroller and it is really hard to move the stroller on the street pavement.', 'bad asphalt', '2016-10-31 22:13:45', 1, 'asphalt1.jpg, asphalt2.jpg, asphalt3.jpg, asphalt4.jpg', 1),
(28, '240 Kent St', 'There is a tree in the middle of stairs, someone with my size will have a hard time passing in between the stairs', 'tree in the stairs', '2016-10-31 22:11:59', 2, 'not_accessible.jpg, not_accessible2.jpg, not_accessible3.jpg, not_accessible4.jpg', 0),
(29, '320 Drillfield Dr', 'There is a tree in the middle of stairways. someone with a big size will have a very hard time passing the narrow space.', 'tree in the stairs', '2016-10-31 22:13:31', 1, 'not_accessible.jpg, not_accessible2.jpg, not_accessible3.jpg, not accessible4.jpg, ', 1),
(30, '2875 Oak Lane', 'Please make a ramp here, there is no other ramp in between the parking and the building so if a disabled person park in this parking cannot get to the building.', 'No ramp', '2016-10-31 22:13:43', 2, 'noramp.jpg, noramp2.jpg, noramp3.jpg, noramp4.jpg,   ', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `privilege`) VALUES
(1, 'Navid', 'Falla', 'navidb@vt.edu', 'nav1212', '1234', 0),
(2, 'Nikola', 'Tesla', 'n.tesla@tesla.net', 'tesla', '1234', 1);

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
