-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 02, 2025 at 05:48 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vulnerable_bank`
--

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('deposit','withdraw','transfer') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `type`, `amount`, `recipient_id`, `description`, `created_at`) VALUES
(1, 1, 'deposit', 10000.00, NULL, 'Initial deposit', '2025-10-24 05:04:23'),
(2, 2, 'deposit', 2000.00, NULL, 'Salary deposit', '2025-10-24 05:04:23'),
(3, 3, 'transfer', 500.00, 2, 'Payment for services', '2025-10-24 05:04:23'),
(4, 2, 'withdraw', 200.00, NULL, 'ATM withdrawal', '2025-10-24 05:04:23'),
(5, 4, 'transfer', 100.00, 1, 'Monthly fee payment', '2025-10-24 05:04:23'),
(6, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:29:28'),
(7, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:30:31'),
(8, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:32:40'),
(9, 3, 'transfer', 50.00, 1, 'Auto CSRF - Page Load Attack', '2025-10-26 15:32:57'),
(10, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:33:57'),
(11, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:34:04'),
(12, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:38:32'),
(13, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:39:23'),
(14, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 15:56:54'),
(15, 2, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 16:02:32'),
(16, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 16:02:45'),
(17, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 16:02:57'),
(18, 5, 'transfer', 50.00, 1, 'Auto CSRF - Page Load Attack', '2025-10-26 16:03:06'),
(19, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-26 16:05:54'),
(20, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-27 10:16:56'),
(21, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-27 10:17:02'),
(22, 2, 'transfer', 1000.00, 5, '', '2025-10-27 10:54:07'),
(23, 1, 'transfer', 10000.00, 5, '', '2025-10-27 13:17:28'),
(24, 1, 'transfer', 500.00, 5, '', '2025-10-27 13:22:59'),
(25, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-29 12:59:17'),
(26, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-29 12:59:27'),
(27, 5, 'transfer', 100.00, 1, 'CSRF Attack - Educational Demo', '2025-10-29 13:00:20'),
(28, 5, 'transfer', 100.00, 2, '', '2025-10-29 13:06:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `recipient_id` (`recipient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
