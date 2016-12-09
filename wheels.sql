-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 08, 2016 at 11:23 PM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wheels`
--

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `user_1_id` int(11) NOT NULL,
  `user_2_id` int(11) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `data_1` text,
  `data_2` text,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(75, 1, 2, 1, NULL, NULL, NULL, '2016-11-15 02:38:11');

-- --------------------------------------------------------

--
-- Table structure for table `event_type`
--

CREATE TABLE `event_type` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `follow` (
  `id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `followee_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `issue`
--

CREATE TABLE `issue` (
  `id` int(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  `description` varchar(400) NOT NULL,
  `summary` varchar(200) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added_by` int(11) NOT NULL,
  `img` varchar(500) NOT NULL,
  `solved` int(11) DEFAULT '0',
  `lat` float NOT NULL DEFAULT '0',
  `lng` float NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `issue`
--

INSERT INTO `issue` (`id`, `address`, `description`, `summary`, `date_added`, `added_by`, `img`, `solved`, `lat`, `lng`, `group_id`) VALUES
(2, '800 Washington Street, Blacksburg', 'This ramp is very steep. Actually it has a more than 25 percent slope on a metal. that means if you go on it on wheels you will be on a roller coaster.', 'not a ramp', '2016-12-08 03:38:26', 1, 'not_accessible2.jpg, stairs1.jpg, stairs2.jpg, stairs3.jpg, stairs4.jpg', 0, 37.2209, -80.4226, 4),
(28, '240 Kent St, Blacksburg', 'There is a tree in the middle of stairs, someone with my size will have a hard time passing in between the stairs', 'tree in the stairs', '2016-12-08 03:39:41', 1, 'not_accessible.jpg, not_accessible2.jpg, not_accessible3.jpg, not_accessible4.jpg', 0, 37.2183, -80.4191, 6),
(29, '320 Drillfield Dr., Blacksburg', 'There is a tree in the middle of stairways. someone with a big size will have a very hard time passing the narrow space.', 'tree in the stairs', '2016-12-08 03:41:14', 1, 'not_accessible.jpg, not_accessible2.jpg, not_accessible3.jpg, not accessible4.jpg, ', 0, 37.2289, -80.4202, 1),
(30, '2875 Oak Lane, Blacksburg', 'Please make a ramp here, there is no other ramp in between the parking and the building so if a disabled person park in this parking cannot get to the building.', 'No ramp', '2016-12-08 03:42:22', 1, 'noramp.jpg, noramp2.jpg, noramp3.jpg, noramp4.jpg,   ', 0, 37.2254, -80.4387, 3),
(52, 'CRC, Blacksburg', 'Write a description of the issue in detail...', 'Write a summary less than 20 words...', '2016-11-15 01:30:10', 2, '', 0, 0, 0, 0),
(53, 'CRC, Blacksburg', 'Write a description of the issue in detail...', 'Write a summary less than 20 words...', '2016-11-15 01:58:31', 2, '', 0, 0, 0, 0),
(54, '190 Alumni Mall, Blacksburg, VA ', 'This building is not wheelchair accessible', 'not accessible', '2016-12-07 22:13:06', 1, 'img_1', 0, 37.2317, -80.4184, 2),
(59, '191 Turner St NW, Blacksburg, VA', 'the building is not accessible', 'not accessible', '2016-12-07 23:06:53', 2, 'img_1', 0, 37.2322, -80.4199, 2),
(60, '260 Alumni Mall, Blacksburg, VA', 'There is ramp on the entrance that is blcoked by water when it rains', 'blocked ramp.', '2016-12-07 23:06:53', 2, 'img_2', 0, 37.2307, -80.419, 2),
(61, '290 College Ave, Blacksburg', 'The sidewalk tiles are broken and in a bad situation so it''s hard to use a wheelchair or a stroller on them', 'broken sidewalk tiles', '2016-12-07 23:06:53', 3, 'img_3', 0, 37.2298, -80.4178, 2),
(62, '300 Turner St NW, Blacksburg', 'The eastern elevator is not working so I have to either take the west elevator or take the stairs, I have a broken foot', 'no elevator', '2016-12-07 23:06:53', 4, 'img_4', 0, 37.2329, -80.4209, 2),
(63, ' 200 Patton Hall, Blacksburg', 'sidewalk is blocked have to take the stairs', 'blocked sidewalk', '2016-12-07 23:16:12', 1, 'img_5', 0, 37.2293, -80.422, 2),
(64, '225 Stanger Street, Blacksburg', 'Hi, please fix this place, when it rains it is not accessible', 'stormwater issue', '2016-12-07 23:19:03', 4, 'img_7', 0, 37.2304, -80.4218, 2),
(65, '410 Old Turner St, Blacksburg', 'the automatic door is broken', 'no automatic door', '2016-12-07 23:21:49', 3, 'img_8', 0, 37.2302, -80.4221, 2),
(66, '601 Drillfield Dr, Blacksburg', 'the sidewalk is fractured', 'broken sidewalk', '2016-12-07 23:23:56', 2, 'img_9', 0, 37.2289, -80.4232, 2),
(67, '601 Drillfield Dr, Blacksburg', 'There is no elevator for the memorial', 'no elevator', '2016-12-07 23:28:35', 5, 'img_10', 0, 37.2288, -80.4205, 2),
(68, '115 Kent St, Blacksburg', 'ramp is broken', 'no ramp', '2016-12-07 23:47:44', 2, 'img_12', 0, 37.2279, -80.4187, 2),
(69, '155 Otey St, Blacksburg', 'the exit door on east does not have an automatic button', 'no automatic doos', '2016-12-07 23:54:10', 2, 'img_13', 0, 37.2281, -80.4174, 2),
(70, '1030 Pamplin Hall, Blacksburg', 'ramp is broken', 'broken ramp', '2016-12-07 23:56:55', 2, 'img_14', 0, 37.2285, -80.4246, 1),
(71, '2062 Perry St, Blacksburg', 'the automatic door is broken', 'no automatic door', '2016-12-08 00:04:01', 5, 'img_15', 0, 37.229, -80.4255, 1),
(72, '800 W Campus Dr, Blacksburg', 'the sidewalk is fractured', 'broken sidewalk', '2016-12-08 00:04:01', 6, 'img_15', 0, 37.2277, -80.4256, 1),
(73, '1455 Perry St, Blacksburg', 'There is no elevator for the memorial', 'no elevator', '2016-12-08 00:10:26', 2, 'img_16', 0, 37.229, -80.4267, 1),
(74, '901 Prices Fork Rd, Blacksburg', 'the exit door on east does not have an automatic button', 'no automatic door', '2016-12-08 00:10:26', 6, 'img_17', 0, 37.2296, -80.4293, 1),
(75, '1 Duck Pond Dr, Blacksburg, VA', 'ramp is broken', 'broken ramp', '2016-12-08 00:16:32', 2, 'img_18', 0, 37.2259, -80.4337, 1),
(76, '295 West Campus Drive, Blacksburg', 'The sidewalk tiles are broken and in a bad situation so it''s hard to use a wheelchair or a stroller on them', 'broken sidewalk tiles', '2016-12-08 00:16:32', 7, 'img_19', 0, 37.2232, -80.4242, 1),
(77, '720 Washington St SW, Blacksburg', 'Hi, please fix this place, when it rains it is not accessible', 'stormwater issue', '2016-12-08 00:24:46', 2, 'img_20', 0, 37.2231, -80.422, 4),
(78, '190 W Campus Dr. Blacksburg', 'This ramp is very steep. Actually it has a more than 25 percent slope on a metal. that means if you go on it on wheels you will be on a roller coaster.', 'not a ramp', '2016-12-08 00:24:46', 3, 'img_21', 0, 37.2222, -80.4225, 4),
(79, '310 W Campus Dr, Blacksburg', 'Please make a ramp here, there is no other ramp in between the parking and the building so if a disabled person park in this parking cannot get to the building.', 'no ramp', '2016-12-08 00:27:43', 3, 'img_18', 0, 37.2239, -80.4223, 4),
(80, '150 Kent St, Blacksburg', 'the ramp to the basement get filled with water when in rains', 'water block', '2016-12-08 00:52:23', 5, 'img_22', 0, 37.2265, -80.419, 4),
(81, '250 Drillfield Drive, Blacksburg', 'The sidewalk tiles are broken and in a bad situation so it''s hard to use a wheelchair or a stroller on them', 'broken sidewalk tiles', '2016-12-08 01:10:09', 3, 'img_23', 0, 37.2258, -80.4227, 4),
(82, '1015 Life Science Circle', 'The entrance elevator is not working', 'elevator is broken', '2016-12-08 01:11:57', 2, 'img_24', 0, 37.221, -80.4264, 3),
(83, '1230 Washington St SW, Blacksburg', 'Please make a ramp here, there is no other ramp in between the parking and the building so if a disabled person park in this parking cannot get to the building.', 'No ramp', '2016-12-08 01:11:57', 7, 'img_25', 0, 37.2203, -80.4273, 3),
(84, '370 Beamer Way, Blacksburg', 'There are no wheelchair accessible seats. I couldn''t find any', 'no accessible seats', '2016-12-08 01:56:46', 3, 'img_26', 0, 37.2188, -80.4198, 6),
(85, '200 Garden Lane, Blacksburg', 'no accesible parking', 'no accessible parking', '2016-12-08 01:56:46', 5, 'img_27', 0, 37.2192, -80.4241, 5),
(86, '260 Duck Pond Dr, Blacksburg', 'there are no accessible chairs', 'no accessible chairs', '2016-12-08 02:04:09', 5, 'img_28', 0, 37.218, -80.4233, 5),
(87, '711 Southgate Dr, Blacksburg', 'The entrance elevator is not working', 'no elevator', '2016-12-08 02:04:09', 5, 'img_29', 0, 37.2158, -80.4133, 6),
(88, '670 Tech Center Dr, Blacksburg', 'the ramp to the basement get filled with water when in rains', 'water block', '2016-12-08 02:07:49', 3, 'img_30', 0, 37.2146, -80.4189, 6),
(89, '185 Beamer Way, Blacksburg', 'Please make a ramp here, there is no other ramp in between the parking and the building so if a disabled person park in this parking cannot get to the building.', 'no ramp', '2016-12-08 02:07:49', 4, 'img_31', 0, 37.2198, -80.4181, 5),
(90, '101 Garden Lane, Washington St SW, Blacksburg', 'Hi, please fix this place, when it rains it is not accessible', 'rain blocks it', '2016-12-08 02:10:59', 4, 'img_32', 0, 37.2203, -80.4235, 6),
(91, '205 Duck Pond Dr, Blacksburg', 'The entrance elevator is not working', 'elevator stops', '2016-12-08 02:10:59', 3, 'img_33', 0, 37.2177, -80.4283, 5),
(92, '1000 Smithfield Plantation Road, Blacksburg', 'there are no accessible parking spots', 'no accessible parking', '2016-12-08 02:16:35', 6, 'img_34', 0, 37.2178, -80.4319, 5),
(93, 'Pritchard Hall, Washington St SW, Blacksburg', 'The sidewalk tiles are broken and in a bad situation so it''s hard to use a wheelchair or a stroller on them', 'sidewalk is broken', '2016-12-08 02:16:35', 6, 'img_35', 0, 37.2239, -80.4193, 4),
(94, '240 Kent St, Blacksburg', 'the ramp to the basement get filled with water when in rains', 'ramp gets filled with water', '2016-12-08 03:24:33', 4, 'img_36', 0, 37.2263, -80.417, 4),
(95, '203 Gilbert St, Blacksburg', 'The eastern elevator is not working so I have to either take the west elevator or take the stairs, I have a broken foot', 'no elevator', '2016-12-08 03:24:33', 6, 'img_37', 0, 37.2337, -80.4211, 2),
(96, '720 Washington St SW, Blacksburg', 'The sidewalk tiles are broken and in a bad situation so it''s hard to use a wheelchair or a stroller on them', 'broken sidewalk', '2016-12-08 03:37:02', 3, 'img_38', 0, 37.2232, -80.422, 4),
(97, 'O''Shaughnessy Hall, Blacksburg', 'The entrance elevator is not working', 'no elevator', '2016-12-08 03:37:02', 3, 'img_39', 0, 37.2252, -80.4182, 4),
(98, 'Derring Lot, Blacksburg', 'Hi, please fix this place, when it rains it is not accessible', 'rain blocks the parking lot', '2016-12-08 03:37:02', 2, 'img_40', 0, 37.2293, -80.4265, 1),
(99, '1325 Perry St, Blacksburg,', 'The rooftop is not wheelchair accessible', 'not accessible', '2016-12-08 03:37:02', 3, 'img_41', 0, 37.23, -80.4246, 1),
(100, '485 Turner St NW, Blacksburg', 'The surge space is not wheelchair accessible', 'not wheelchair accessible', '2016-12-08 03:37:02', 2, 'img_42', 0, 37.2331, -80.4233, 2);

-- --------------------------------------------------------

--
-- Table structure for table `location_seed`
--

CREATE TABLE `location_seed` (
  `group_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `lat` float DEFAULT NULL,
  `lng` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location_seed`
--

INSERT INTO `location_seed` (`group_id`, `name`, `lat`, `lng`) VALUES
(0, 'unspecified', 0, 0),
(0, 'unspecified', NULL, NULL),
(1, 'skelton_center', 37.2336, -80.4303),
(2, 'squires', 37.2308, -80.4187),
(3, 'duck_pond', 37.2244, -80.4287),
(4, 'cassel_coliseum', 37.2245, -80.4185),
(5, 'veterinary_medicine', 37.2178, -80.4289),
(6, 'lane_stadium', 37.2174, -80.4183);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `privilege` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `privilege`) VALUES
(1, 'Navid', 'Falla', 'navidb@vt.edu', 'nav1212', '1234', 0),
(2, 'Sneha', 'Mehta', 'snehamehta@vt.edu', 'sumehta', '1345', 0),
(3, 'Tianyi', 'Li', 'tli@vt.edu', 'tianyi', '1567', 0),
(4, 'John', 'Oliver', 'johnoliver.vt.edu', 'johnoliver', '1453', 0),
(5, 'TestUserF1', 'TestUserL1', 'test_user1@craccess.com', 'user_craccess', 'cs5774f16', 1),
(6, 'TestUserF2', 'TestUserL2', 'test_user2@craccess.com', 'moderator_craccess', 'cs5774f16', 0),
(7, 'TestUserF3', 'TestUserL3', 'test_user3@craccess.com', 'admin_craccess', 'cs5774f16', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_type_id` (`event_type_id`),
  ADD KEY `user_1_id` (`user_1_id`),
  ADD KEY `user_2_id` (`user_2_id`),
  ADD KEY `product_2_id` (`issue_id`);

--
-- Indexes for table `event_type`
--
ALTER TABLE `event_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follower` (`follower_id`),
  ADD KEY `follower_2` (`follower_id`),
  ADD KEY `followee` (`followee_id`);

--
-- Indexes for table `issue`
--
ALTER TABLE `issue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `added_by` (`added_by`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `event_type`
--
ALTER TABLE `event_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `follow`
--
ALTER TABLE `follow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `issue`
--
ALTER TABLE `issue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
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
