-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 25 Bulan Mei 2025 pada 16.51
-- Versi server: 10.5.28-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gaya_belajar`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add input data', 7, 'add_inputdata'),
(26, 'Can change input data', 7, 'change_inputdata'),
(27, 'Can delete input data', 7, 'delete_inputdata'),
(28, 'Can view input data', 7, 'view_inputdata'),
(29, 'Can add data pelatihan', 8, 'add_datapelatihan'),
(30, 'Can change data pelatihan', 8, 'change_datapelatihan'),
(31, 'Can delete data pelatihan', 8, 'delete_datapelatihan'),
(32, 'Can view data pelatihan', 8, 'view_datapelatihan'),
(33, 'Can add prediksi gaya belajar', 9, 'add_prediksigayabelajar'),
(34, 'Can change prediksi gaya belajar', 9, 'change_prediksigayabelajar'),
(35, 'Can delete prediksi gaya belajar', 9, 'delete_prediksigayabelajar'),
(36, 'Can view prediksi gaya belajar', 9, 'view_prediksigayabelajar'),
(37, 'Can add input data', 10, 'add_inputdata'),
(38, 'Can change input data', 10, 'change_inputdata'),
(39, 'Can delete input data', 10, 'delete_inputdata'),
(40, 'Can view input data', 10, 'view_inputdata'),
(41, 'Can add gaya belajar', 11, 'add_gayabelajar'),
(42, 'Can change gaya belajar', 11, 'change_gayabelajar'),
(43, 'Can delete gaya belajar', 11, 'delete_gayabelajar'),
(44, 'Can view gaya belajar', 11, 'view_gayabelajar');

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$870000$zKPqHFEAJF91wpQWXWWqUk$ojpWde90uUw7q03TmQTKoHz7a0/AlmFtvLkz7tMqskQ=', '2025-05-23 08:35:23.419522', 1, 'admin', '', '', 'admin@admin.id', 1, 1, '2025-05-06 18:22:40.967553');

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_pelatihan`
--

CREATE TABLE `data_pelatihan` (
  `id_pelatihan` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jenis_kelamin` varchar(50) DEFAULT NULL,
  `jurusan` varchar(50) DEFAULT NULL,
  `P1` int(1) DEFAULT NULL,
  `P2` int(1) DEFAULT NULL,
  `P3` int(1) DEFAULT NULL,
  `P4` int(1) DEFAULT NULL,
  `P5` int(1) DEFAULT NULL,
  `P6` int(1) DEFAULT NULL,
  `P7` int(1) DEFAULT NULL,
  `P8` int(1) DEFAULT NULL,
  `P9` int(1) DEFAULT NULL,
  `P10` int(1) DEFAULT NULL,
  `P11` int(1) DEFAULT NULL,
  `P12` int(1) DEFAULT NULL,
  `P13` int(1) DEFAULT NULL,
  `P14` int(1) DEFAULT NULL,
  `P15` int(1) DEFAULT NULL,
  `real_target` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data untuk tabel `data_pelatihan`
--

INSERT INTO `data_pelatihan` (`id_pelatihan`, `nama`, `jenis_kelamin`, `jurusan`, `P1`, `P2`, `P3`, `P4`, `P5`, `P6`, `P7`, `P8`, `P9`, `P10`, `P11`, `P12`, `P13`, `P14`, `P15`, `real_target`) VALUES
(1, 'ABRAHAM JEANLY', 'Laki-laki', 'Teknik Mesin', 4, 3, 5, 3, 4, 5, 4, 3, 5, 4, 3, 4, 4, 4, 4, 'Kinestetik'),
(2, 'Achmad Maoza Rifai', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 4, 5, 4, 5, 3, 4, 4, 3, 4, 4, 2, 2, 3, 'Kinestetik'),
(3, 'Addina Khairinisa', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 3, 'Visual'),
(4, 'Adellia Dias Ayu Agustina', 'Perempuan', 'Siswa Menengah Pertama', 3, 5, 4, 5, 3, 4, 4, 5, 3, 5, 5, 4, 4, 5, 3, 'Auditori'),
(5, 'Adi Triana', 'Laki-laki', 'Siswa Menengah Pertama', 4, 5, 4, 4, 5, 4, 4, 5, 4, 3, 5, 2, 3, 5, 4, 'Auditori'),
(6, 'Adly Razan Priyatama', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 4, 5, 4, 5, 5, 3, 4, 5, 5, 4, 5, 3, 5, 'Visual'),
(7, 'adriel.muhammad.faisal', 'Laki-laki', 'Siswa Menengah Pertama', 5, 4, 3, 5, 5, 3, 5, 4, 4, 4, 3, 3, 3, 4, 3, 'Visual'),
(8, 'aerin putri s', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 5, 5, 5, 5, 3, 5, 4, 5, 4, 5, 3, 5, 5, 'Auditori'),
(9, 'Ahmad', 'Laki-laki', 'Bahasa', 3, 4, 4, 4, 4, 5, 5, 1, 3, 4, 1, 1, 1, 5, 5, 'Kinestetik'),
(10, 'Ahmad Sugiri', 'Laki-laki', 'IPA', 2, 3, 3, 5, 3, 5, 2, 3, 3, 3, 3, 2, 4, 1, 2, 'Visual'),
(11, 'Ai nuriyah', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 3, 5, 'Visual'),
(12, 'Akbar Octaciano Al-ridho', 'Laki-laki', 'Teknik Mesin', 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 'Visual'),
(13, 'Aldi', 'Laki-laki', 'Lainnya', 5, 2, 5, 4, 2, 1, 2, 5, 5, 4, 4, 4, 3, 2, 2, 'Visual'),
(14, 'Aldo Ivanda', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 2, 2, 3, 3, 2, 3, 3, 3, 3, 2, 1, 2, 1, 1, 'Visual'),
(15, 'Alfian Febriansyah', 'Laki-laki', 'Teknik Pengelasan', 3, 5, 5, 3, 5, 4, 4, 4, 4, 2, 3, 3, 3, 4, 4, 'Auditori'),
(16, 'Alfiansyah', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 3, 4, 5, 3, 4, 4, 4, 4, 5, 3, 5, 3, 4, 'Auditori'),
(17, 'aliyah rahma wati', 'Perempuan', 'Desain dan Produksi Kriya', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 'Visual'),
(18, 'ALMA NAIRUL RAJA', 'Laki-laki', 'Teknik Otomotif', 4, 4, 2, 4, 2, 4, 4, 2, 5, 4, 2, 1, 5, 3, 4, 'Visual'),
(19, 'amira', 'Perempuan', 'Siswa Menengah Pertama', 2, 3, 4, 3, 3, 4, 3, 3, 5, 3, 3, 3, 3, 3, 5, 'Kinestetik'),
(20, 'Andhika Fardha Julian', 'Laki-laki', 'Administrasi Perkantoran', 2, 3, 3, 2, 4, 3, 1, 2, 3, 3, 3, 1, 1, 2, 1, 'Auditori'),
(21, 'Andi', 'Perempuan', 'Desain Komunikasi Visual', 3, 3, 1, 1, 3, 1, 4, 1, 3, 1, 2, 3, 1, 1, 4, 'Kinestetik'),
(22, 'Andika', 'Laki-laki', 'Kurikulum Merdeka', 3, 4, 5, 4, 2, 5, 3, 3, 5, 3, 5, 3, 4, 3, 3, 'Kinestetik'),
(23, 'Andika Deswantara', 'Laki-laki', 'Desain Komunikasi Visual', 3, 4, 5, 3, 5, 4, 4, 2, 4, 2, 4, 3, 2, 4, 4, 'Kinestetik'),
(24, 'andika maulana rizqi', 'Laki-laki', 'Siswa Menengah Pertama', 5, 5, 5, 5, 4, 5, 4, 3, 5, 3, 2, 5, 3, 2, 5, 'Kinestetik'),
(25, 'Andri Aprilyean', 'Laki-laki', 'IPA', 5, 5, 4, 3, 1, 4, 4, 4, 4, 5, 2, 4, 4, 3, 2, 'Visual'),
(26, 'anisa', 'Perempuan', 'Akuntansi', 4, 4, 4, 5, 3, 5, 5, 5, 5, 5, 5, 5, 2, 5, 5, 'Kinestetik'),
(27, 'Anjas Sari Imanur', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 2, 5, 5, 4, 4, 4, 3, 5, 3, 3, 4, 3, 3, 5, 'Kinestetik'),
(28, 'Annisa nur amalina', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 2, 5, 3, 5, 4, 5, 4, 3, 2, 3, 4, 2, 5, 'Visual'),
(29, 'Ayy lilis masturroh', 'Perempuan', 'Kurikulum Merdeka', 5, 5, 4, 4, 3, 5, 4, 4, 5, 5, 3, 5, 4, 3, 5, 'Kinestetik'),
(30, 'Azfa Fauzan', 'Laki-laki', 'Akuntansi', 2, 2, 3, 1, 2, 3, 2, 1, 3, 1, 1, 4, 1, 2, 5, 'Kinestetik'),
(31, 'Bagas', 'Laki-laki', 'Bahasa', 3, 5, 2, 1, 3, 4, 2, 5, 3, 3, 5, 2, 4, 2, 2, 'Auditori'),
(32, 'Bagas Adi', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 4, 4, 4, 3, 2, 2, 4, 4, 2, 3, 2, 2, 2, 4, 'Auditori'),
(33, 'Bahri', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 2, 5, 5, 4, 2, 1, 4, 4, 2, 2, 3, 4, 2, 1, 4, 'Kinestetik'),
(34, 'Baim', 'Laki-laki', 'Multimedia', 3, 2, 2, 1, 2, 3, 2, 4, 5, 3, 1, 4, 2, 3, 5, 'Kinestetik'),
(35, 'Bara', 'Laki-laki', 'Rekayasa Perangkat Lunak', 4, 2, 2, 5, 2, 1, 3, 5, 2, 4, 1, 5, 5, 2, 3, 'Visual'),
(36, 'Baron', 'Laki-laki', 'Rekayasa Perangkat Lunak', 5, 2, 2, 5, 3, 4, 4, 3, 3, 2, 2, 1, 4, 5, 5, 'Visual'),
(37, 'Bayu Nur A Syafi\'i', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 'Visual'),
(38, 'Bayu Setyo Nugroho', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 4, 4, 4, 3, 3, 4, 4, 4, 5, 4, 3, 5, 4, 'Auditori'),
(39, 'Bayu Vio Anggara', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 2, 1, 3, 2, 1, 3, 2, 1, 3, 2, 1, 3, 2, 1, 'Visual'),
(40, 'Berlian Putra Ramadhan', 'Laki-laki', 'Kurikulum Merdeka', 3, 5, 4, 2, 5, 4, 4, 3, 4, 3, 5, 3, 2, 5, 4, 'Auditori'),
(41, 'Bima', 'Laki-laki', 'Desain Komunikasi Visual', 3, 4, 5, 1, 5, 5, 1, 5, 5, 1, 1, 1, 1, 1, 5, 'Kinestetik'),
(42, 'Bisma', 'Laki-laki', 'IPA', 2, 4, 2, 2, 2, 2, 1, 4, 3, 3, 4, 5, 1, 2, 1, 'Auditori'),
(43, 'Bowo', 'Laki-laki', 'Akuntansi', 2, 4, 2, 4, 1, 4, 3, 3, 3, 2, 3, 1, 2, 2, 1, 'Visual'),
(44, 'Brasco Seipio Sutoyo', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 4, 4, 4, 5, 4, 4, 4, 4, 4, 5, 4, 4, 4, 4, 'Auditori'),
(45, 'Cantika dinda puspita', 'Perempuan', 'Farmasi', 5, 5, 4, 4, 4, 5, 3, 4, 5, 5, 3, 3, 3, 5, 4, 'Auditori'),
(46, 'chyelia balqis', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 5, 4, 3, 5, 4, 3, 4, 2, 3, 4, 2, 1, 4, 'Kinestetik'),
(47, 'Cinta', 'Perempuan', 'Administrasi Perkantoran', 5, 3, 4, 4, 2, 1, 3, 4, 5, 2, 3, 3, 4, 4, 5, 'Visual'),
(48, 'Danang Dwi Laksana', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 4, 3, 5, 4, 4, 4, 5, 3, 4, 4, 4, 5, 5, 'Auditori'),
(49, 'Dani', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 4, 5, 1, 1, 5, 3, 3, 2, 5, 5, 5, 3, 3, 3, 'Kinestetik'),
(50, 'Daris Arya Guna', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 4, 5, 5, 3, 5, 4, 5, 5, 3, 4, 3, 3, 3, 5, 'Kinestetik'),
(51, 'decha aulia', 'Perempuan', 'Siswa Menengah Pertama', 3, 3, 5, 5, 5, 5, 4, 3, 4, 3, 3, 4, 3, 3, 5, 'Kinestetik'),
(52, 'Dede Riyan', 'Perempuan', 'IPS', 5, 5, 4, 5, 3, 3, 1, 1, 3, 1, 1, 3, 5, 5, 5, 'Kinestetik'),
(53, 'DEFA Aditia pamungkas', 'Laki-laki', 'Siswa Menengah Pertama', 4, 5, 3, 4, 5, 4, 5, 2, 5, 3, 2, 4, 3, 1, 5, 'Kinestetik'),
(54, 'DELLA PERMATA BALI', 'Perempuan', 'KEPERAWATAN', 3, 2, 5, 4, 3, 4, 4, 3, 5, 3, 3, 4, 3, 2, 5, 'Kinestetik'),
(55, 'DESI YULIANTI', 'Perempuan', 'Siswa Menengah Pertama', 4, 3, 4, 5, 4, 4, 5, 3, 4, 4, 3, 3, 4, 2, 3, 'Visual'),
(56, 'Dhimas Tri', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 5, 5, 2, 5, 5, 3, 3, 5, 2, 2, 4, 2, 2, 5, 'Kinestetik'),
(57, 'Didan Defano R', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 5, 5, 5, 5, 4, 5, 4, 5, 5, 5, 5, 5, 'Kinestetik'),
(58, 'Dika', 'Laki-laki', 'Administrasi Perkantoran', 2, 4, 1, 2, 2, 4, 3, 2, 4, 1, 2, 4, 3, 3, 2, 'Kinestetik'),
(59, 'Dini Isnava Tratasukma', 'Perempuan', 'IPS', 4, 4, 4, 4, 3, 4, 5, 3, 4, 5, 3, 3, 4, 4, 4, 'Visual'),
(60, 'Diva Antares', 'Perempuan', 'Kurikulum Merdeka', 4, 4, 4, 4, 4, 5, 5, 4, 5, 5, 5, 4, 4, 5, 5, 'Kinestetik'),
(61, 'Dwi Adi Pangestu', 'Laki-laki', 'IPS', 5, 4, 3, 4, 4, 5, 4, 2, 3, 2, 3, 1, 2, 2, 5, 'Visual'),
(62, 'Dwi Rangga F', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 3, 3, 2, 4, 2, 3, 4, 3, 3, 4, 3, 2, 4, 'Kinestetik'),
(63, 'Dwi Rohmah', 'Perempuan', 'Kurikulum Merdeka', 4, 2, 1, 2, 5, 4, 5, 1, 2, 1, 3, 5, 1, 3, 3, 'Kinestetik'),
(64, 'Dwi Triana', 'Laki-laki', 'Akuntansi', 5, 2, 2, 4, 4, 5, 5, 4, 2, 3, 3, 5, 2, 5, 3, 'Visual'),
(65, 'dzakwan', 'Laki-laki', 'Siswa Menengah Pertama', 5, 4, 5, 3, 4, 5, 5, 3, 5, 2, 3, 4, 4, 4, 3, 'Kinestetik'),
(66, 'Eka', 'Perempuan', 'Akuntansi', 3, 5, 2, 1, 5, 2, 5, 2, 2, 4, 1, 1, 2, 1, 5, 'Visual'),
(67, 'Eka Permana', 'Laki-laki', 'IPA', 3, 2, 4, 5, 3, 5, 4, 4, 5, 5, 4, 1, 3, 4, 4, 'Visual'),
(68, 'Eka Rahma', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 2, 2, 4, 1, 4, 2, 5, 2, 1, 2, 2, 3, 1, 4, 'Visual'),
(69, 'Erlangga Anugrah Purnama', 'Laki-laki', 'Siswa Menengah Pertama', 4, 4, 3, 5, 3, 3, 4, 2, 3, 4, 3, 3, 4, 1, 3, 'Visual'),
(70, 'Estriadi Aditias', 'Laki-laki', 'Kurikulum Merdeka', 3, 2, 2, 2, 1, 1, 2, 1, 2, 3, 2, 2, 3, 2, 2, 'Visual'),
(71, 'Ezki noris zian', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 4, 4, 5, 4, 3, 5, 5, 3, 5, 4, 4, 4, 4, 'Auditori'),
(72, 'fachri maulana', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 4, 3, 4, 4, 4, 4, 3, 4, 3, 4, 3, 3, 4, 'Auditori'),
(73, 'Fadhli Ghifari', 'Laki-laki', 'Kurikulum Merdeka', 3, 4, 3, 3, 4, 3, 3, 5, 4, 3, 4, 3, 3, 4, 3, 'Auditori'),
(74, 'Fahmi Putra Pangestu', 'Laki-laki', 'Siswa Menengah Pertama', 5, 4, 3, 4, 5, 5, 5, 3, 4, 4, 1, 4, 5, 4, 5, 'Visual'),
(75, 'FAHRI AZHAR MAULANA', 'Laki-laki', 'Teknik Instalasi Tenaga Listrik', 2, 3, 5, 4, 3, 3, 2, 4, 5, 5, 3, 4, 2, 3, 4, 'Kinestetik'),
(76, 'Fa\'i', 'Laki-laki', 'Siswa Menengah Pertama', 2, 2, 5, 4, 3, 4, 3, 2, 4, 4, 4, 3, 3, 2, 4, 'Kinestetik'),
(77, 'Faiz', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 2, 5, 5, 3, 5, 4, 5, 5, 4, 3, 5, 3, 2, 5, 'Kinestetik'),
(78, 'Fajar', 'Laki-laki', 'Administrasi Perkantoran', 3, 2, 1, 5, 4, 3, 4, 5, 2, 2, 4, 1, 2, 4, 3, 'Auditori'),
(79, 'Fariz putra arditia', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 3, 5, 1, 2, 5, 5, 4, 5, 1, 4, 5, 3, 'Auditori'),
(80, 'Fauzian yudistira', 'Laki-laki', 'Kurikulum Merdeka', 5, 4, 5, 5, 3, 4, 4, 3, 5, 3, 3, 4, 3, 3, 5, 'Kinestetik'),
(81, 'Febriansyah', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 4, 3, 4, 5, 3, 5, 4, 3, 5, 4, 3, 5, 'Kinestetik'),
(82, 'Fera yurianita', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 3, 5, 4, 3, 3, 2, 4, 5, 5, 3, 2, 2, 5, 'Visual'),
(83, 'Ferdian Bayutama', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 3, 5, 5, 3, 1, 3, 2, 3, 3, 3, 5, 5, 'Kinestetik'),
(84, 'Fito Diaz Pratama', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 2, 4, 3, 1, 3, 2, 2, 5, 3, 2, 2, 1, 3, 4, 2, 'Auditori'),
(85, 'Fuji Hanafi', 'Laki-laki', 'Siswa Menengah Pertama', 2, 4, 3, 3, 2, 3, 3, 2, 3, 3, 2, 4, 4, 2, 3, 'Kinestetik'),
(86, 'Fuziah Syahadatul Kharomah', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 1, 5, 5, 2, 5, 5, 2, 5, 5, 5, 5, 2, 2, 5, 'Kinestetik'),
(87, 'Galang', 'Laki-laki', 'Nautika Kapal Penangkap?Ikan', 5, 2, 2, 3, 3, 1, 4, 2, 1, 5, 5, 5, 2, 2, 5, 'Visual'),
(88, 'gilang rizky rahmadan', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 1, 1, 1, 5, 5, 1, 5, 5, 5, 5, 1, 1, 1, 'Visual'),
(89, 'gina', 'Perempuan', 'Siswa Menengah Pertama', 3, 4, 4, 4, 5, 4, 4, 4, 3, 2, 5, 3, 2, 5, 4, 'Auditori'),
(90, 'gisya', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 3, 5, 4, 3, 5, 4, 1, 2, 4, 3, 3, 'Visual'),
(91, 'Glaih', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 4, 3, 4, 2, 2, 4, 3, 3, 4, 3, 3, 3, 4, 2, 'Visual'),
(92, 'Haikal Yazid Zidane', 'Laki-laki', 'IPS', 4, 5, 4, 3, 5, 4, 4, 2, 4, 3, 5, 3, 3, 5, 4, 'Auditori'),
(93, 'Hardiansyah', 'Laki-laki', 'Teknik Kendaraan Ringan', 4, 5, 1, 5, 5, 5, 3, 5, 4, 5, 3, 3, 5, 3, 4, 'Visual'),
(94, 'Hilmy Sabana', 'Laki-laki', 'IPS', 1, 4, 4, 1, 5, 5, 5, 4, 5, 5, 4, 4, 1, 4, 5, 'Kinestetik'),
(95, 'Ika Siti Fadilah', 'Perempuan', 'Teknik Otomotif', 4, 5, 4, 3, 4, 3, 4, 2, 4, 4, 3, 4, 4, 2, 3, 'Visual'),
(96, 'Imas fitriani', 'Perempuan', 'Multimedia', 4, 4, 1, 5, 1, 4, 2, 4, 2, 3, 5, 3, 4, 5, 1, 'Auditori'),
(97, 'Intan Apriliani', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'Visual'),
(98, 'Ipah', 'Perempuan', 'Siswa Menengah Pertama', 4, 2, 3, 3, 1, 3, 5, 3, 5, 5, 5, 1, 4, 4, 3, 'Visual'),
(99, 'Iqdan Maulana', 'Laki-laki', 'Siswa Menengah Pertama', 5, 4, 2, 5, 3, 3, 5, 3, 4, 3, 3, 3, 3, 1, 3, 'Visual'),
(100, 'izka nurmaulida', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 3, 5, 5, 4, 5, 1, 5, 5, 1, 2, 5, 3, 'Auditori'),
(101, 'izka nurmaulida', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 5, 1, 5, 5, 'Kinestetik'),
(102, 'Januard Fabregas Putra Tadu', 'Laki-laki', 'Kurikulum Merdeka', 4, 3, 5, 4, 3, 3, 3, 4, 3, 5, 2, 4, 3, 2, 4, 'Visual'),
(103, 'Jasmine Azzahra', 'Perempuan', 'Siswa Menengah Pertama', 3, 4, 3, 3, 3, 3, 3, 3, 4, 3, 4, 4, 4, 4, 4, 'Auditori'),
(104, 'Jibril', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 3, 3, 5, 2, 3, 4, 3, 4, 4, 3, 2, 4, 1, 3, 'Visual'),
(105, 'Joko', 'Laki-laki', 'IPA', 4, 4, 4, 2, 2, 2, 5, 1, 5, 3, 1, 5, 4, 2, 2, 'Visual'),
(106, 'juan davilla', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 5, 1, 4, 4, 2, 3, 4, 3, 3, 1, 3, 3, 4, 'Kinestetik'),
(107, 'Kenzie', 'Laki-laki', 'Nautika Kapal Penangkap?Ikan', 5, 3, 5, 5, 3, 4, 2, 3, 1, 1, 5, 1, 2, 3, 1, 'Auditori'),
(108, 'Kinanti Sekar Ayu', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 5, 4, 4, 4, 5, 5, 5, 3, 4, 4, 4, 3, 4, 'Kinestetik'),
(109, 'Kurnia Krisna Rizky', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 4, 5, 2, 2, 3, 2, 3, 3, 4, 3, 3, 2, 2, 'Visual'),
(110, 'Lalis Indah Fadliyah', 'Perempuan', 'Kurikulum Merdeka', 4, 4, 5, 4, 5, 5, 3, 3, 4, 2, 3, 4, 2, 2, 4, 'Kinestetik'),
(111, 'Lani Asqolani', 'Laki-laki', 'Teknik Mesin', 3, 3, 5, 4, 3, 5, 3, 3, 5, 5, 4, 5, 4, 4, 5, 'Kinestetik'),
(112, 'Lusi', 'Perempuan', 'Administrasi Perkantoran', 1, 4, 2, 4, 2, 5, 3, 5, 3, 4, 3, 1, 1, 3, 5, 'Auditori'),
(113, 'MAHRA NUR\'AISYAH', 'Perempuan', 'Siswa Menengah Pertama', 4, 4, 3, 5, 2, 3, 4, 2, 5, 4, 3, 4, 4, 2, 4, 'Visual'),
(114, 'Malvino Fardan', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 3, 3, 2, 4, 3, 1, 1, 2, 4, 4, 3, 4, 2, 4, 'Visual'),
(115, 'Maya', 'Perempuan', 'Rekayasa Perangkat Lunak', 2, 2, 4, 2, 5, 5, 5, 5, 2, 5, 5, 4, 3, 1, 2, 'Auditori'),
(116, 'Mega Putri', 'Perempuan', 'Administrasi Perkantoran', 3, 2, 5, 5, 3, 3, 5, 5, 5, 2, 2, 5, 1, 2, 3, 'Kinestetik'),
(117, 'Megan', 'Perempuan', 'Kurikulum Merdeka', 4, 2, 2, 3, 5, 3, 4, 2, 1, 1, 2, 1, 5, 1, 1, 'Visual'),
(118, 'meisya', 'Perempuan', 'Siswa Menengah Pertama', 4, 4, 3, 3, 4, 3, 3, 3, 3, 5, 4, 4, 3, 3, 3, 'Visual'),
(119, 'Midah', 'Perempuan', 'Multimedia', 5, 3, 5, 5, 3, 5, 5, 2, 4, 5, 5, 5, 5, 3, 5, 'Visual'),
(120, 'Muhammad Abrar Acyuta', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 4, 5, 5, 5, 2, 5, 3, 5, 3, 1, 1, 1, 3, 'Auditori'),
(121, 'Muhammad Aditya Yusuf', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 2, 3, 4, 4, 'Auditori'),
(122, 'Muhammad Alif Syahban', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 4, 3, 4, 4, 4, 4, 4, 3, 5, 4, 4, 5, 5, 'Auditori'),
(123, 'Muhammad Andika Widiyarto', 'Laki-laki', 'Kurikulum Merdeka', 3, 5, 4, 3, 5, 4, 4, 3, 4, 2, 4, 2, 2, 4, 4, 'Auditori'),
(124, 'Muhammad Fadlan Alghifachri', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 4, 5, 4, 3, 4, 4, 2, 5, 3, 1, 3, 3, 1, 3, 'Kinestetik'),
(125, 'Muhammad iqbal', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 5, 5, 4, 4, 5, 3, 5, 5, 4, 3, 3, 2, 1, 5, 'Kinestetik'),
(126, 'Muhammad Izzat Rabbani Sutisna', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 5, 5, 4, 4, 3, 3, 3, 5, 3, 3, 3, 3, 3, 5, 'Kinestetik'),
(127, 'Muhammad Parhan agustian', 'Laki-laki', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 1, 5, 5, 1, 1, 5, 1, 5, 5, 1, 'Auditori'),
(128, 'Muhammad Rayhan Adzikri', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 1, 3, 3, 2, 3, 4, 3, 3, 5, 3, 4, 2, 1, 1, 5, 'Kinestetik'),
(129, 'Muhammad Rendi Amaludin', 'Laki-laki', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 1, 5, 5, 5, 5, 5, 1, 1, 5, 5, 'Auditori'),
(130, 'Muhammad Rendi Amaludin', 'Laki-laki', 'Siswa Menengah Pertama', 5, 2, 2, 4, 3, 2, 5, 2, 4, 3, 2, 2, 1, 3, 3, 'Visual'),
(131, 'Muhammad Subkhan Mashuri', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 5, 5, 5, 5, 3, 4, 3, 4, 5, 5, 4, 5, 5, 'Auditori'),
(132, 'Muhammad Zaenal Arifin', 'Laki-laki', 'Desain Komunikasi Visual', 3, 5, 4, 4, 5, 4, 5, 3, 4, 3, 3, 3, 2, 3, 4, 'Auditori'),
(133, 'Muhammad Zidan Alfarizi', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 4, 4, 4, 4, 3, 4, 2, 3, 4, 3, 1, 4, 2, 'Auditori'),
(134, 'Munajar', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 5, 5, 3, 4, 4, 3, 3, 4, 3, 2, 3, 3, 4, 4, 'Kinestetik'),
(135, 'Nabila agustin', 'Perempuan', 'Teknik Sepeda Motor', 5, 5, 4, 4, 4, 4, 5, 4, 5, 5, 4, 4, 4, 4, 4, 'Visual'),
(136, 'nahda aliya ghatsa', 'Perempuan', 'Siswa Menengah Pertama', 3, 5, 2, 4, 5, 4, 3, 2, 3, 2, 2, 2, 2, 2, 3, 'Auditori'),
(137, 'naila', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 5, 5, 4, 3, 3, 3, 4, 4, 3, 3, 3, 4, 4, 'Visual'),
(138, 'Najwa Khairana Fadhilah', 'Perempuan', 'Farmasi', 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 2, 4, 4, 2, 4, 'Visual'),
(139, 'Nala', 'Perempuan', 'Siswa Menengah Pertama', 4, 2, 3, 5, 3, 5, 4, 3, 5, 4, 4, 5, 3, 2, 4, 'Kinestetik'),
(140, 'Nanda Herlina', 'Perempuan', 'Multimedia', 3, 4, 1, 2, 1, 5, 4, 3, 2, 2, 1, 2, 1, 1, 4, 'Kinestetik'),
(141, 'Naumi pranamia inayah', 'Perempuan', 'Siswa Menengah Pertama', 2, 4, 5, 3, 4, 2, 4, 3, 4, 1, 2, 4, 2, 3, 3, 'Kinestetik'),
(142, 'ncep Muhamad akbar', 'Laki-laki', 'Siswa Menengah Pertama', 4, 5, 5, 4, 5, 3, 4, 2, 5, 3, 3, 5, 4, 3, 5, 'Kinestetik'),
(143, 'Neneng', 'Perempuan', 'IPA', 2, 5, 2, 4, 2, 1, 4, 3, 2, 5, 2, 5, 2, 3, 1, 'Visual'),
(144, 'Nina', 'Perempuan', 'Farmasi', 1, 5, 3, 5, 3, 4, 5, 1, 4, 5, 3, 2, 1, 3, 1, 'Visual'),
(145, 'Nining', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 3, 4, 5, 1, 2, 2, 4, 2, 1, 1, 5, 2, 4, 'Visual'),
(146, 'nova arisna', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 5, 4, 2, 5, 3, 4, 5, 5, 4, 5, 3, 3, 5, 'Kinestetik'),
(147, 'Novita mega p.', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 4, 5, 'Visual'),
(148, 'Nunung Kusuma', 'Perempuan', 'IPS', 2, 1, 4, 1, 3, 4, 3, 3, 3, 4, 1, 1, 3, 4, 4, 'Kinestetik'),
(149, 'ona', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 3, 5, 4, 5, 4, 5, 5, 5, 3, 4, 4, 5, 2, 5, 'Kinestetik'),
(150, 'Parhan agustian', 'Laki-laki', 'Siswa Menengah Pertama', 5, 5, 5, 4, 4, 3, 4, 5, 3, 3, 5, 4, 2, 4, 3, 'Auditori'),
(151, 'paridddd', 'Laki-laki', 'Siswa Menengah Pertama', 3, 5, 5, 1, 1, 3, 5, 3, 5, 4, 3, 5, 3, 3, 3, 'Kinestetik'),
(152, 'Rafli Ahmad Rizal', 'Laki-laki', 'Desain Komunikasi Visual', 4, 5, 4, 4, 5, 4, 4, 3, 4, 2, 3, 3, 2, 5, 4, 'Auditori'),
(153, 'Rahayu', 'Perempuan', 'Kurikulum Merdeka', 3, 3, 1, 1, 5, 1, 5, 5, 5, 4, 5, 1, 4, 2, 3, 'Auditori'),
(154, 'Rahma', 'Perempuan', 'Siswa Menengah Pertama', 1, 1, 2, 4, 2, 5, 2, 2, 3, 2, 2, 2, 3, 4, 2, 'Kinestetik'),
(155, 'Raisya utami', 'Perempuan', 'Siswa Menengah Pertama', 3, 4, 4, 4, 4, 3, 3, 4, 3, 3, 4, 3, 3, 4, 3, 'Auditori'),
(156, 'Raj Ade Arba\'a', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 5, 4, 5, 4, 5, 5, 4, 2, 5, 3, 4, 4, 4, 'Auditori'),
(157, 'Rani', 'Perempuan', 'Siswa Menengah Pertama', 3, 5, 5, 3, 4, 4, 5, 5, 5, 3, 2, 1, 1, 4, 2, 'Auditori'),
(158, 'rapli dut', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 3, 4, 4, 4, 3, 2, 4, 4, 1, 4, 2, 3, 1, 4, 'Kinestetik'),
(159, 'Regisa inda pratiwi', 'Perempuan', 'Siswa Menengah Pertama', 5, 3, 5, 3, 2, 5, 5, 3, 5, 2, 2, 2, 2, 2, 5, 'Kinestetik'),
(160, 'Rehan Angga Saputra', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 5, 5, 5, 1, 4, 'Kinestetik'),
(161, 'Reyhan Fazry Hamdani', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 5, 3, 4, 5, 3, 4, 4, 3, 2, 4, 2, 3, 3, 3, 'Auditori'),
(162, 'Rianto', 'Laki-laki', 'IPS', 3, 4, 4, 5, 4, 4, 5, 1, 5, 4, 2, 5, 1, 3, 5, 'Kinestetik'),
(163, 'Rifqi', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 4, 5, 5, 4, 5, 2, 5, 5, 5, 5, 5, 5, 'Auditori'),
(164, 'Riko', 'Laki-laki', 'Administrasi Perkantoran', 5, 5, 2, 4, 5, 4, 3, 1, 3, 1, 2, 5, 4, 1, 1, 'Visual'),
(165, 'Rina', 'Perempuan', 'Rekayasa Perangkat Lunak', 4, 3, 2, 3, 4, 4, 4, 2, 4, 3, 5, 3, 3, 2, 2, 'Visual'),
(166, 'Rio maulana', 'Laki-laki', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 3, 5, 4, 5, 5, 3, 3, 5, 5, 'Auditori'),
(167, 'Risky', 'Laki-laki', 'Rekayasa Perangkat Lunak', 4, 3, 5, 4, 4, 5, 3, 4, 5, 4, 3, 3, 4, 3, 5, 'Kinestetik'),
(168, 'Risya Nur Amalia', 'Perempuan', 'Siswa Menengah Pertama', 4, 4, 4, 5, 4, 4, 4, 4, 5, 4, 4, 4, 4, 3, 5, 'Kinestetik'),
(169, 'Rizky aunul huda', 'Laki-laki', 'Teknik Otomotif', 3, 3, 5, 3, 3, 4, 2, 2, 3, 3, 1, 1, 3, 1, 4, 'Kinestetik'),
(170, 'Rizky Maulana Putra', 'Laki-laki', 'Teknik Instalasi Tenaga Listrik', 4, 5, 5, 5, 5, 5, 4, 1, 5, 4, 4, 1, 5, 3, 4, 'Visual'),
(171, 'Rizky Mulia Putra H', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 5, 4, 4, 4, 4, 4, 4, 3, 3, 4, 3, 2, 3, 'Kinestetik'),
(172, 'Romansyifa mutiara hanif', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 3, 5, 4, 4, 3, 5, 3, 5, 5, 3, 5, 'Visual'),
(173, 'satria', 'Laki-laki', 'Desain Pemodelan dan Informasi Bangunan', 2, 3, 3, 5, 4, 5, 4, 3, 5, 3, 4, 4, 3, 3, 4, 'Kinestetik'),
(174, 'Septa Yogi Permana', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 4, 5, 5, 5, 5, 3, 4, 5, 4, 4, 5, 5, 4, 5, 4, 'Auditori'),
(175, 'SEPTIAN AGUSTIANA RAMDAN', 'Laki-laki', 'Siswa Menengah Pertama', 4, 4, 2, 4, 4, 4, 4, 5, 5, 4, 5, 5, 3, 4, 3, 'Auditori'),
(176, 'shafira mawar restiyadi', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 3, 3, 3, 3, 5, 3, 5, 3, 3, 1, 5, 'Kinestetik'),
(177, 'Sheillia Dwi Wulandari', 'Perempuan', 'Kurikulum Merdeka', 3, 4, 5, 5, 5, 5, 4, 5, 5, 5, 2, 3, 1, 1, 5, 'Kinestetik'),
(178, 'Shinta Pandiana', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 2, 5, 5, 5, 3, 5, 5, 1, 5, 'Kinestetik'),
(179, 'shofaa Fauziah zen', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'Visual'),
(180, 'sholehuddin Ali ayyubi', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 5, 3, 5, 4, 'Auditori'),
(181, 'Sidik Nurul Huda', 'Laki-laki', 'Siswa Menengah Pertama', 3, 5, 2, 3, 4, 2, 3, 3, 2, 4, 2, 4, 3, 4, 2, 'Auditori'),
(182, 'Sinta', 'Perempuan', 'Bahasa', 3, 4, 2, 3, 3, 4, 1, 1, 1, 4, 2, 2, 1, 4, 3, 'Auditori'),
(183, 'srii mulyati juniarr', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 4, 3, 4, 4, 4, 4, 5, 4, 3, 4, 3, 2, 5, 'Kinestetik'),
(184, 'Stefanauval Purnama Bintang', 'Laki-laki', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 4, 4, 3, 4, 3, 3, 4, 3, 3, 3, 2, 1, 4, 'Kinestetik'),
(185, 'susanti alvionita', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 4, 5, 5, 4, 3, 4, 2, 4, 5, 5, 'Auditori'),
(186, 'Syafa Nurul dzini', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 1, 1, 5, 1, 5, 5, 5, 5, 2, 1, 1, 5, 'Kinestetik'),
(187, 'Syifa Fauziah', 'Perempuan', 'Akuntansi', 4, 3, 1, 3, 2, 3, 3, 2, 3, 4, 3, 1, 4, 2, 3, 'Visual'),
(188, 'Tari', 'Perempuan', 'Multimedia', 1, 2, 4, 3, 3, 5, 1, 3, 5, 1, 1, 2, 3, 5, 3, 'Kinestetik'),
(189, 'Tia Maharani', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 3, 5, 5, 5, 5, 5, 3, 3, 5, 3, 5, 5, 'Kinestetik'),
(190, 'Tia setiyawati', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'Visual'),
(191, 'Tiara Annisa', 'Perempuan', 'IPA', 5, 2, 5, 2, 2, 1, 2, 1, 5, 3, 2, 3, 2, 5, 5, 'Kinestetik'),
(192, 'tika ramadhani', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 3, 5, 5, 4, 5, 5, 3, 5, 4, 3, 5, 5, 'Auditori'),
(193, 'Tita dwi Hastuti', 'Perempuan', 'Siswa Menengah Pertama', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 'Visual'),
(194, 'Tono', 'Laki-laki', 'Kurikulum Merdeka', 2, 4, 2, 3, 1, 5, 2, 2, 2, 2, 2, 2, 3, 2, 2, 'Kinestetik'),
(195, 'Usna Monto', 'Laki-laki', 'Siswa Menengah Pertama', 3, 3, 4, 4, 3, 5, 1, 1, 1, 1, 4, 5, 2, 3, 4, 'Kinestetik'),
(196, 'Villa Fazar Oktamamsyah', 'Laki-laki', 'Siswa Menengah Pertama', 3, 3, 4, 3, 3, 2, 3, 3, 3, 2, 2, 2, 3, 2, 3, 'Visual'),
(197, 'Wafa Ainul Fikri', 'Perempuan', 'Kurikulum Merdeka', 3, 5, 5, 4, 5, 5, 5, 5, 5, 5, 5, 5, 2, 4, 5, 'Kinestetik'),
(198, 'Wening Tresnasih', 'Perempuan', 'Farmasi', 3, 5, 5, 3, 4, 5, 4, 4, 5, 2, 3, 2, 2, 2, 4, 'Kinestetik'),
(199, 'Windy Trikhailla Wulandari', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 3, 4, 3, 3, 3, 4, 4, 3, 4, 4, 5, 5, 5, 5, 5, 'Kinestetik'),
(200, 'yasfa Fadillah rahmi', 'Perempuan', 'Siswa Menengah Pertama', 4, 4, 4, 4, 2, 5, 4, 4, 4, 4, 2, 3, 2, 2, 4, 'Kinestetik'),
(201, 'yoga', 'Laki-laki', 'Siswa Menengah Pertama', 3, 3, 4, 4, 3, 3, 3, 2, 3, 3, 2, 4, 3, 3, 4, 'Kinestetik'),
(202, 'yuanita', 'Perempuan', 'Siswa Menengah Pertama', 4, 5, 5, 5, 1, 5, 5, 3, 4, 4, 2, 4, 5, 3, 4, 'Visual'),
(203, 'yuli', 'Perempuan', 'Siswa Menengah Pertama', 3, 4, 5, 4, 3, 4, 4, 3, 4, 3, 2, 2, 2, 2, 3, 'Kinestetik'),
(204, 'Yuli Yulaeha', 'Perempuan', 'IPA', 1, 1, 4, 5, 5, 5, 3, 5, 4, 1, 5, 3, 2, 3, 5, 'Kinestetik'),
(205, 'Zahra Zahira', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 2, 5, 3, 4, 5, 3, 2, 4, 4, 4, 5, 3, 2, 2, 4, 'Auditori'),
(206, 'zalfa hasna rabbani idfyan', 'Perempuan', 'Teknik Jaringan Komputer & Telekomunikasi', 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 3, 4, 3, 2, 4, 'Kinestetik'),
(207, 'Ziyad ziddan', 'Laki-laki', 'Siswa Menengah Pertama', 5, 3, 5, 5, 3, 5, 5, 3, 5, 3, 3, 5, 3, 3, 5, 'Kinestetik'),
(208, 'Abbas Permana', 'Laki-laki', 'Siswa Menengah Pertama', 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 4, 3, 4, 'Kinestetik'),
(209, 'SemiOuse', 'Laki-laki', 'Siswa Menengah Pertama', 3, 2, 2, 2, 2, 2, 3, 2, 1, 2, 2, 1, 2, 1, 1, 'Visual'),
(210, 'Albertus', 'Laki-laki', 'Siswa Menengah Pertama', 4, 5, 4, 4, 4, 4, 4, 5, 5, 4, 4, 4, 4, 4, 4, 'Auditori'),
(211, 'A', 'Laki-laki', 'Siswa Menengah Pertama', 3, 2, 2, 3, 2, 2, 3, 2, 2, 3, 2, 2, 3, 2, 2, 'Visual'),
(212, 'B', 'Perempuan', 'Siswa Menengah Pertama', 2, 3, 2, 2, 3, 2, 2, 3, 2, 2, 3, 2, 2, 3, 2, 'Auditori'),
(213, 'C', 'Laki-laki', 'Siswa Menengah Pertama', 1, 3, 2, 2, 2, 3, 2, 1, 3, 3, 3, 3, 3, 3, 3, 'Auditori');

-- --------------------------------------------------------

--
-- Struktur dari tabel `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-05-20 16:22:28.363325', '1', 'Auditori', 1, '[{\"added\": {}}]', 12, 1),
(2, '2025-05-20 16:22:46.974839', '2', 'Kinestetik', 1, '[{\"added\": {}}]', 12, 1),
(3, '2025-05-20 16:22:56.792290', '3', 'Visual', 1, '[{\"added\": {}}]', 12, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'input_data', 'inputdata'),
(8, 'pelatihan', 'datapelatihan'),
(11, 'prediksi', 'gayabelajar'),
(12, 'prediksi', 'gaya_belajar'),
(10, 'prediksi', 'inputdata'),
(9, 'prediksi', 'prediksigayabelajar'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Struktur dari tabel `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-05-06 17:55:26.842899'),
(2, 'auth', '0001_initial', '2025-05-06 17:55:27.211676'),
(3, 'admin', '0001_initial', '2025-05-06 17:55:27.269936'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-05-06 17:55:27.275756'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-06 17:55:27.286545'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-05-06 17:55:27.324552'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-05-06 17:55:27.350370'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-05-06 17:55:27.365502'),
(9, 'auth', '0004_alter_user_username_opts', '2025-05-06 17:55:27.372669'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-05-06 17:55:27.395886'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-05-06 17:55:27.399332'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-05-06 17:55:27.403522'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-05-06 17:55:27.420465'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-05-06 17:55:27.435529'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-05-06 17:55:27.446996'),
(16, 'auth', '0011_update_proxy_permissions', '2025-05-06 17:55:27.454032'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-05-06 17:55:27.468902'),
(18, 'sessions', '0001_initial', '2025-05-06 17:55:27.486770'),
(19, 'input_data', '0001_initial', '2025-05-19 15:47:34.320968'),
(20, 'pelatihan', '0001_initial', '2025-05-19 15:47:34.331149');

-- --------------------------------------------------------

--
-- Struktur dari tabel `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('9gkg86w7bcjmtc22em4qzvmq4m1tcbvh', '.eJxVjMEOgjAQRP-lZ9NsoQXq0Tvf0Ox2txY1JaFwMv67kHDQ48x7M28VcFtz2KosYWJ1VUZdfjvC-JRyAH5guc86zmVdJtKHok9a9TizvG6n-3eQseZ97ThaF6VpO07G9F4oAghQon6gQaBJInZPzqN0iT2wdwwWTWsBEa36fAEPKTkP:1uINsB:2nE6NM0rZaOJONrgyvU87tEJUQVul_0s291aSHc5d0Y', '2025-06-06 08:35:23.422691');

-- --------------------------------------------------------

--
-- Struktur dari tabel `gaya_belajar`
--

CREATE TABLE `gaya_belajar` (
  `id_gaya_belajar` int(1) NOT NULL,
  `nama_target` varchar(20) NOT NULL,
  `gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `gaya_belajar`
--

INSERT INTO `gaya_belajar` (`id_gaya_belajar`, `nama_target`, `gambar`) VALUES
(1, 'Auditori', 'gambar_gaya_belajar/gba.png'),
(2, 'Kinestetik', 'gambar_gaya_belajar/gbk.png'),
(3, 'Visual', 'gambar_gaya_belajar/gbv.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `prediksi_prediksigayabelajar`
--

CREATE TABLE `prediksi_prediksigayabelajar` (
  `id_prediksi` int(11) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `usia` varchar(3) NOT NULL,
  `jenis_kelamin` varchar(200) NOT NULL,
  `kelas` varchar(200) NOT NULL,
  `jurusan` varchar(200) NOT NULL,
  `asal_sekolah` varchar(200) NOT NULL,
  `P1` int(11) NOT NULL,
  `P2` int(11) NOT NULL,
  `P3` int(11) NOT NULL,
  `P4` int(11) NOT NULL,
  `P5` int(11) NOT NULL,
  `P6` int(11) NOT NULL,
  `P7` int(11) NOT NULL,
  `P8` int(11) NOT NULL,
  `P9` int(11) NOT NULL,
  `P10` int(11) NOT NULL,
  `P11` int(11) NOT NULL,
  `P12` int(11) NOT NULL,
  `P13` int(11) NOT NULL,
  `P14` int(11) NOT NULL,
  `P15` int(11) NOT NULL,
  `id_gaya_belajar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `prediksi_prediksigayabelajar`
--

INSERT INTO `prediksi_prediksigayabelajar` (`id_prediksi`, `nama`, `usia`, `jenis_kelamin`, `kelas`, `jurusan`, `asal_sekolah`, `P1`, `P2`, `P3`, `P4`, `P5`, `P6`, `P7`, `P8`, `P9`, `P10`, `P11`, `P12`, `P13`, `P14`, `P15`, `id_gaya_belajar`) VALUES
(1, 'Tegar Rakasiwi', '17', 'Laki-laki', '12', 'Teknik Jaringan Komputer & Telekomunikasi', 'SMKS Islam Malahayati', 4, 5, 3, 4, 5, 4, 3, 4, 4, 4, 4, 3, 4, 5, 4, 1),
(2, 'Tegar', '17', 'Laki-laki', '12', 'Teknik Jaringan Komputer & Telekomunikasi', 'SMK 123', 5, 4, 3, 3, 3, 4, 5, 5, 4, 3, 3, 4, 1, 2, 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indeks untuk tabel `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indeks untuk tabel `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indeks untuk tabel `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indeks untuk tabel `data_pelatihan`
--
ALTER TABLE `data_pelatihan`
  ADD PRIMARY KEY (`id_pelatihan`);

--
-- Indeks untuk tabel `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indeks untuk tabel `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indeks untuk tabel `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indeks untuk tabel `gaya_belajar`
--
ALTER TABLE `gaya_belajar`
  ADD PRIMARY KEY (`id_gaya_belajar`);

--
-- Indeks untuk tabel `prediksi_prediksigayabelajar`
--
ALTER TABLE `prediksi_prediksigayabelajar`
  ADD PRIMARY KEY (`id_prediksi`),
  ADD KEY `real_target` (`id_gaya_belajar`),
  ADD KEY `prediksi_prediksigayabelajar_id_gaya_belajar_id_e6202e50` (`id_gaya_belajar`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT untuk tabel `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `data_pelatihan`
--
ALTER TABLE `data_pelatihan`
  MODIFY `id_pelatihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=214;

--
-- AUTO_INCREMENT untuk tabel `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT untuk tabel `gaya_belajar`
--
ALTER TABLE `gaya_belajar`
  MODIFY `id_gaya_belajar` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `prediksi_prediksigayabelajar`
--
ALTER TABLE `prediksi_prediksigayabelajar`
  MODIFY `id_prediksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ketidakleluasaan untuk tabel `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ketidakleluasaan untuk tabel `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ketidakleluasaan untuk tabel `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ketidakleluasaan untuk tabel `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ketidakleluasaan untuk tabel `prediksi_prediksigayabelajar`
--
ALTER TABLE `prediksi_prediksigayabelajar`
  ADD CONSTRAINT `prediksi_prediksigay_id_gaya_belajar_id_e6202e50_fk_gaya_bela` FOREIGN KEY (`id_gaya_belajar`) REFERENCES `gaya_belajar` (`id_gaya_belajar`),
  ADD CONSTRAINT `prediksi_prediksigayabelajar_ibfk_1` FOREIGN KEY (`id_gaya_belajar`) REFERENCES `gaya_belajar` (`id_gaya_belajar`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
