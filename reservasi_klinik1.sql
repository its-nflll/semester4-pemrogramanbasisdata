-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Jul 2024 pada 11.41
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reservasi_klinik1`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateStock` (IN `obat_id` INT, IN `jumlah` INT)   BEGIN
    UPDATE obat
    SET stok = stok + jumlah
    WHERE id_obat = obat_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `basicpasienview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `basicpasienview` (
`id_pasien` int(11)
,`nama` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `spesialis` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama`, `spesialis`, `no_telp`, `email`) VALUES
(1, 'Dr. Imam', 'Umum', '08123456789', 'Imam@gmail.com'),
(2, 'Dr. Naufal', 'Gigi', '08234567890', 'Naufal@yahoo.com'),
(3, 'Dr. Irenius', 'THT', '08345678901', 'Irenius@hospital.com'),
(4, 'Dr. Ardi', 'Kulit', '08456789012', 'Ardi@derma.com'),
(5, 'Dr. Rizal', 'Mata', '08567890123', 'Rizal@eyes.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter_jadwal`
--

CREATE TABLE `dokter_jadwal` (
  `id_dokter` int(11) NOT NULL,
  `hari` varchar(10) NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `extendedpasienview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `extendedpasienview` (
`id_pasien` int(11)
,`nama` varchar(100)
,`alamat` varchar(255)
,`no_telp` varchar(15)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `horizontalview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `horizontalview` (
`id_pasien` int(11)
,`nama` varchar(100)
,`alamat` varchar(255)
,`no_telp` varchar(15)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id_log` int(11) NOT NULL,
  `tabel` varchar(50) DEFAULT NULL,
  `operasi` varchar(50) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `waktu` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_aktivitas`
--

INSERT INTO `log_aktivitas` (`id_log`, `tabel`, `operasi`, `deskripsi`, `waktu`) VALUES
(1, 'obat', 'UPDATE', 'Stok obat dengan id 1 berubah dari 140 menjadi 150', '2024-07-21 10:45:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(11) NOT NULL,
  `nama_obat` varchar(100) NOT NULL,
  `jenis_obat` varchar(100) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id_obat`, `nama_obat`, `jenis_obat`, `stok`, `harga`) VALUES
(1, 'Paracetamol', 'Tablet', 150, 5000.00),
(2, 'Amoxicillin', 'Kapsul', 200, 10000.00),
(3, 'Vitamin C', 'Tablet', 150, 3000.00),
(4, 'Antasida', 'Syrup', 50, 15000.00),
(5, 'Ibuprofen', 'Tablet', 120, 7000.00),
(6, 'Aspirin', 'Tablet', 50, 8000.00);

--
-- Trigger `obat`
--
DELIMITER $$
CREATE TRIGGER `before_update_obat_stok` BEFORE UPDATE ON `obat` FOR EACH ROW BEGIN
    DECLARE msg VARCHAR(255);
    SET msg = CONCAT('Stok obat dengan id ', OLD.id_obat, ' berubah dari ', OLD.stok, ' menjadi ', NEW.stok);

    INSERT INTO log_aktivitas (tabel, operasi, deskripsi)
    VALUES ('obat', 'UPDATE', msg);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama`, `alamat`, `no_telp`, `email`) VALUES
(1, 'John Doe', 'Jl. Bunga No. 1', '08123456789', 'johndoe@gmail.com'),
(2, 'Jane Smith', 'Jl. Anggrek No. 2', '08234567890', 'janesmith@yahoo.com'),
(3, 'Alice Brown', 'Jl. Melati No. 3', '08345678901', 'alicebrown@hotmail.com'),
(4, 'Bob White', 'Jl. Mawar No. 4', '08456789012', 'bobwhite@gmail.com'),
(5, 'Carol Black', 'Jl. Tulip No. 5', '08567890123', 'carolblack@yahoo.com');

--
-- Trigger `pasien`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pasien` AFTER DELETE ON `pasien` FOR EACH ROW BEGIN
    INSERT INTO log_aktivitas (tabel, operasi, deskripsi, waktu) 
    VALUES ('pasien', 'DELETE', CONCAT('Pasien dihapus: ', OLD.nama), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_pasien` AFTER INSERT ON `pasien` FOR EACH ROW BEGIN
    INSERT INTO log_aktivitas (tabel, operasi, deskripsi, waktu) 
    VALUES ('pasien', 'INSERT', CONCAT('Pasien baru ditambahkan: ', NEW.nama), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_pasien` AFTER UPDATE ON `pasien` FOR EACH ROW BEGIN
    INSERT INTO log_aktivitas (tabel, operasi, deskripsi, waktu) 
    VALUES ('pasien', 'UPDATE', CONCAT('Data pasien diupdate: ', OLD.nama, ' menjadi ', NEW.nama), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_pasien` BEFORE DELETE ON `pasien` FOR EACH ROW BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT 1 FROM reservasi WHERE id_pasien = OLD.id_pasien AND status = 'Dijadwalkan') THEN
        SET msg = 'Pasien memiliki reservasi aktif dan tidak dapat dihapus.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_pasien` BEFORE INSERT ON `pasien` FOR EACH ROW BEGIN
    DECLARE msg VARCHAR(255);
    -- Periksa apakah email sudah ada
    IF EXISTS (SELECT 1 FROM pasien WHERE email = NEW.email) THEN
        SET msg = CONCAT('Email ', NEW.email, ' sudah ada.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_pasien` BEFORE UPDATE ON `pasien` FOR EACH ROW BEGIN
    DECLARE msg VARCHAR(255);
    IF CHAR_LENGTH(NEW.no_telp) < 10 THEN
        SET msg = 'Nomor telepon harus minimal 10 digit.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rekammedis`
--

CREATE TABLE `rekammedis` (
  `id_rekam_medis` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `tanggal_kunjungan` date NOT NULL,
  `keluhan` text NOT NULL,
  `diagnosa` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `rekammedis`
--

INSERT INTO `rekammedis` (`id_rekam_medis`, `id_pasien`, `id_dokter`, `tanggal_kunjungan`, `keluhan`, `diagnosa`) VALUES
(1, 1, 1, '2024-07-01', 'Demam dan sakit kepala', 'Influenza'),
(2, 2, 2, '2024-07-02', 'Sakit gigi', 'Karies gigi'),
(3, 3, 3, '2024-07-03', 'Hidung tersumbat', 'Sinusitis'),
(4, 4, 4, '2024-07-04', 'Ruam kulit', 'Dermatitis'),
(5, 5, 5, '2024-07-05', 'Mata merah', 'Konjungtivitis');

-- --------------------------------------------------------

--
-- Struktur dari tabel `resep`
--

CREATE TABLE `resep` (
  `id_resep` int(11) NOT NULL,
  `id_rekam_medis` int(11) NOT NULL,
  `id_obat` int(11) NOT NULL,
  `dosis` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `resep`
--

INSERT INTO `resep` (`id_resep`, `id_rekam_medis`, `id_obat`, `dosis`) VALUES
(1, 1, 1, '3 kali sehari'),
(2, 2, 2, '2 kali sehari'),
(3, 3, 3, '1 kali sehari'),
(4, 4, 4, '4 kali sehari'),
(5, 5, 5, '3 kali sehari');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reservasi`
--

CREATE TABLE `reservasi` (
  `id_reservasi` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `tanggal_reservasi` date NOT NULL,
  `waktu_reservasi` time NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reservasi`
--

INSERT INTO `reservasi` (`id_reservasi`, `id_pasien`, `id_dokter`, `tanggal_reservasi`, `waktu_reservasi`, `status`) VALUES
(1, 1, 1, '2024-07-20', '10:00:00', 'Dijadwalkan'),
(2, 2, 2, '2024-07-21', '11:00:00', 'Dijadwalkan'),
(3, 3, 3, '2024-07-22', '09:00:00', 'Dijadwalkan'),
(4, 4, 4, '2024-07-23', '08:00:00', 'Dijadwalkan'),
(5, 5, 5, '2024-07-24', '07:00:00', 'Dijadwalkan');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_dokter_pasien`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_dokter_pasien` (
`nama_dokter` varchar(100)
,`nama_pasien` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_dokter_spesialis`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_dokter_spesialis` (
`nama` varchar(100)
,`spesialis` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_reservasi_aktif`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_reservasi_aktif` (
`id_reservasi` int(11)
,`id_pasien` int(11)
,`id_dokter` int(11)
,`tanggal_reservasi` date
,`waktu_reservasi` time
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `basicpasienview`
--
DROP TABLE IF EXISTS `basicpasienview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `basicpasienview`  AS SELECT `pasien`.`id_pasien` AS `id_pasien`, `pasien`.`nama` AS `nama` FROM `pasien` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `extendedpasienview`
--
DROP TABLE IF EXISTS `extendedpasienview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `extendedpasienview`  AS SELECT `bp`.`id_pasien` AS `id_pasien`, `bp`.`nama` AS `nama`, `p`.`alamat` AS `alamat`, `p`.`no_telp` AS `no_telp`, `p`.`email` AS `email` FROM (`basicpasienview` `bp` join `pasien` `p` on(`bp`.`id_pasien` = `p`.`id_pasien`))WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `horizontalview`
--
DROP TABLE IF EXISTS `horizontalview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontalview`  AS SELECT `pasien`.`id_pasien` AS `id_pasien`, `pasien`.`nama` AS `nama`, `pasien`.`alamat` AS `alamat`, `pasien`.`no_telp` AS `no_telp`, `pasien`.`email` AS `email` FROM `pasien` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_dokter_pasien`
--
DROP TABLE IF EXISTS `view_dokter_pasien`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_dokter_pasien`  AS SELECT `dokter`.`nama` AS `nama_dokter`, `pasien`.`nama` AS `nama_pasien` FROM ((`rekammedis` join `dokter` on(`rekammedis`.`id_dokter` = `dokter`.`id_dokter`)) join `pasien` on(`rekammedis`.`id_pasien` = `pasien`.`id_pasien`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_dokter_spesialis`
--
DROP TABLE IF EXISTS `view_dokter_spesialis`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_dokter_spesialis`  AS SELECT `dokter`.`nama` AS `nama`, `dokter`.`spesialis` AS `spesialis` FROM `dokter` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_reservasi_aktif`
--
DROP TABLE IF EXISTS `view_reservasi_aktif`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reservasi_aktif`  AS SELECT `reservasi`.`id_reservasi` AS `id_reservasi`, `reservasi`.`id_pasien` AS `id_pasien`, `reservasi`.`id_dokter` AS `id_dokter`, `reservasi`.`tanggal_reservasi` AS `tanggal_reservasi`, `reservasi`.`waktu_reservasi` AS `waktu_reservasi`, `reservasi`.`status` AS `status` FROM `reservasi` WHERE `reservasi`.`status` = 'Dijadwalkan' ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeks untuk tabel `dokter_jadwal`
--
ALTER TABLE `dokter_jadwal`
  ADD PRIMARY KEY (`id_dokter`,`hari`);

--
-- Indeks untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id_log`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_pasien_alamat_no_telp` (`alamat`,`no_telp`);

--
-- Indeks untuk tabel `rekammedis`
--
ALTER TABLE `rekammedis`
  ADD PRIMARY KEY (`id_rekam_medis`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indeks untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`id_resep`),
  ADD KEY `id_rekam_medis` (`id_rekam_medis`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Indeks untuk tabel `reservasi`
--
ALTER TABLE `reservasi`
  ADD PRIMARY KEY (`id_reservasi`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`),
  ADD KEY `idx_reservasi_tanggal_waktu` (`tanggal_reservasi`,`waktu_reservasi`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
