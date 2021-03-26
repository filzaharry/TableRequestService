-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Mar 2021 pada 11.12
-- Versi server: 10.4.6-MariaDB
-- Versi PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ujian3batch8`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get5OrangGajiTertinggi` (IN `nilai` INT(100))  NO SQL
SELECT worker.first_name as workers, worker.salary 
FROM worker where worker.salary >= nilai
ORDER BY worker.salary DESC
LIMIT 5$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDepartmentPlusWorker` (IN `nilai` INT(100))  NO SQL
select * from worker
left join title on worker.worker_id = title.worker_ref_id where worker.salary >= nilai$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getGajiSama` (IN `nilai` INT(100))  NO SQL
SELECT worker.salary, COUNT(*) duplikat FROM worker GROUP BY salary HAVING COUNT(duplikat) > nilai$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bonus`
--

CREATE TABLE `bonus` (
  `worker_ref_id` int(3) NOT NULL,
  `bonus_date` date NOT NULL,
  `bonus_amount` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `bonus`
--

INSERT INTO `bonus` (`worker_ref_id`, `bonus_date`, `bonus_amount`) VALUES
(1, '2016-02-20', 5000),
(2, '2016-06-11', 3000),
(3, '2016-02-20', 4000),
(4, '2016-02-20', 4500),
(5, '2016-06-11', 3500);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `log` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `log`
--

INSERT INTO `log` (`id`, `log`) VALUES
(1, '9');

-- --------------------------------------------------------

--
-- Struktur dari tabel `title`
--

CREATE TABLE `title` (
  `worker_ref_id` int(3) NOT NULL,
  `worker_title` varchar(20) NOT NULL,
  `affected_data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `title`
--

INSERT INTO `title` (`worker_ref_id`, `worker_title`, `affected_data`) VALUES
(1, 'Manager', '2016-02-20'),
(2, 'Executive', '2016-06-11'),
(3, 'Lead', '2016-06-11'),
(4, 'Asst. Manager', '2016-06-11'),
(5, 'Manager', '2016-06-11'),
(6, 'Lead', '2016-06-11'),
(7, 'Executive', '2016-06-11'),
(8, 'Executive', '2016-06-11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `worker`
--

CREATE TABLE `worker` (
  `worker_id` int(3) NOT NULL,
  `first_name` varchar(10) NOT NULL,
  `last_name` varchar(10) NOT NULL,
  `salary` int(10) NOT NULL,
  `joining_date` datetime NOT NULL,
  `department` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `worker`
--

INSERT INTO `worker` (`worker_id`, `first_name`, `last_name`, `salary`, `joining_date`, `department`) VALUES
(1, 'Monika', 'Arora', 100000, '2014-02-20 00:00:00', 'HR'),
(2, 'Niharika', 'Verma', 80000, '2014-06-11 00:00:00', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2014-02-20 00:00:00', 'HR'),
(4, 'Amitabh', 'Singh', 50000, '2014-02-20 00:00:00', 'Admin'),
(5, 'Vivek', 'Bhati', 50000, '2014-06-11 00:00:00', 'Admin'),
(6, 'Vipul', 'Diwan', 200000, '2014-06-11 00:00:00', 'Account'),
(7, 'Satish', 'Kumar', 75000, '2014-01-20 00:00:00', 'Account'),
(8, 'Geetika', 'Chauhan', 90000, '2014-04-11 00:00:00', 'Admin'),
(9, 'brave', 'dragon', 100000, '2021-03-24 00:00:00', 'HR');

--
-- Trigger `worker`
--
DELIMITER $$
CREATE TRIGGER `postWorker_log` AFTER INSERT ON `worker` FOR EACH ROW insert into log(log) values (new.worker_id)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bonus`
--
ALTER TABLE `bonus`
  ADD PRIMARY KEY (`worker_ref_id`);

--
-- Indeks untuk tabel `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `title`
--
ALTER TABLE `title`
  ADD PRIMARY KEY (`worker_ref_id`);

--
-- Indeks untuk tabel `worker`
--
ALTER TABLE `worker`
  ADD PRIMARY KEY (`worker_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `title`
--
ALTER TABLE `title`
  MODIFY `worker_ref_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `worker`
--
ALTER TABLE `worker`
  MODIFY `worker_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
