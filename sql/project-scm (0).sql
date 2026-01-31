-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 07, 2026 at 09:40 PM
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
-- Database: `project-scm`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_stocks`
--

CREATE TABLE `admin_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `opening_stock` decimal(12,2) NOT NULL DEFAULT 0.00,
  `received_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `receive_return_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `sales_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `sales_return_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `wastage_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `current_stock` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_stocks`
--

INSERT INTO `admin_stocks` (`id`, `product_id`, `opening_stock`, `received_qty`, `receive_return_qty`, `sales_qty`, `sales_return_qty`, `wastage_qty`, `current_stock`, `created_at`, `updated_at`) VALUES
(1, 1, 0.00, 1000.00, 10.00, 155.00, 0.00, 100.00, 735.00, '2025-12-20 10:32:12', '2025-12-27 01:16:00'),
(2, 2, 0.00, 2000.00, 100.00, 0.00, 0.00, 10.00, 1890.00, '2025-12-20 11:12:28', '2025-12-26 22:26:42'),
(3, 3, 0.00, 3000.00, 50.00, 0.00, 0.00, 0.00, 2950.00, '2025-12-20 21:26:56', '2025-12-21 00:39:40'),
(4, 4, 0.00, 800.00, 0.00, 0.00, 0.00, 0.00, -100.00, '2025-12-26 22:25:22', '2025-12-27 22:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `depo_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `depos`
--

CREATE TABLE `depos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `depos`
--

INSERT INTO `depos` (`id`, `name`, `location`, `contact_person`, `phone`, `created_at`, `updated_at`) VALUES
(1, 'Dhaka Main Depo', 'Dhaka', 'Karim', '996655', '2025-12-13 05:05:14', '2025-12-13 10:10:29'),
(2, 'Chittagong Distributor', 'Chattogram', 'Rahim', '9876543', '2025-12-13 05:11:14', '2025-12-13 10:10:09'),
(3, 'Kalkata Depo', 'Kalkata', 'Nadim', '98765444', '2025-12-13 09:24:05', '2025-12-26 22:16:56');

-- --------------------------------------------------------

--
-- Table structure for table `depo_sales`
--

CREATE TABLE `depo_sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `sale_date` date NOT NULL,
  `depo_id` bigint(20) UNSIGNED NOT NULL,
  `sale_type` enum('distributor','customer') NOT NULL,
  `sale_to_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `reject_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `depo_sale_details`
--

CREATE TABLE `depo_sale_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `depo_sale_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `depo_stocks`
--

CREATE TABLE `depo_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `depo_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `opening_stock` decimal(12,2) NOT NULL DEFAULT 0.00,
  `received_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `receive_return_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `sales_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `sales_return_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `wastage_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `current_stock` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `depo_stocks`
--

INSERT INTO `depo_stocks` (`id`, `depo_id`, `product_id`, `opening_stock`, `received_qty`, `receive_return_qty`, `sales_qty`, `sales_return_qty`, `wastage_qty`, `current_stock`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0.00, 155.00, 0.00, 0.00, 0.00, 0.00, 155.00, '2025-12-27 01:16:00', '2025-12-27 01:16:00'),
(2, 3, 4, 0.00, 900.00, 0.00, 0.00, 0.00, 0.00, 900.00, '2025-12-27 22:52:21', '2025-12-27 22:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `distributors`
--

CREATE TABLE `distributors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `depo_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `material_issues`
--

CREATE TABLE `material_issues` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `issue_number` varchar(255) NOT NULL,
  `issue_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `material_issues`
--

INSERT INTO `material_issues` (`id`, `issue_number`, `issue_date`, `note`, `created_at`, `updated_at`) VALUES
(1, 'ISS-20251217-483', '2025-12-17', 'fhg', '2025-12-17 16:11:23', '2025-12-17 16:11:23'),
(2, 'ISS-20251221-312', '2025-12-21', 'production', '2025-12-20 21:25:45', '2025-12-20 21:25:45'),
(3, 'ISS-20251227-905', '2025-12-27', NULL, '2025-12-26 22:22:33', '2025-12-26 22:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `material_issue_items`
--

CREATE TABLE `material_issue_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `material_issue_id` bigint(20) UNSIGNED NOT NULL,
  `raw_material_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `batch_no` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `material_issue_items`
--

INSERT INTO `material_issue_items` (`id`, `material_issue_id`, `raw_material_id`, `quantity`, `batch_no`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10.00, '222', '2025-12-17 16:11:23', '2025-12-17 16:11:23'),
(2, 2, 3, 500.00, '444', '2025-12-20 21:25:46', '2025-12-20 21:25:46'),
(3, 2, 2, 300.00, '222', '2025-12-20 21:25:46', '2025-12-20 21:25:46'),
(4, 3, 1, 1000.00, '333', '2025-12-26 22:22:33', '2025-12-26 22:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_12_05_184633_create_personal_access_tokens_table', 1),
(5, '2025_12_05_191016_create_roles_table', 1),
(6, '2025_12_05_191034_create_role_user_table', 1),
(7, '2025_12_11_060100_create_suppliers_table', 2),
(8, '2025_12_13_082006_create_depos_table', 3),
(9, '2025_12_13_082245_add_depo_id_to_users_table', 3),
(10, '2025_12_14_175225_create_units_table', 4),
(12, '2025_12_16_193127_create_raw_materials_table', 5),
(13, '2025_12_17_155429_create_purchase_orders_table', 6),
(14, '2025_12_17_155520_create_purchase_order_items_table', 6),
(15, '2025_12_17_161537_create_raw_material_stocks_table', 6),
(16, '2025_12_17_175610_create_material_issues_table', 7),
(17, '2025_12_17_222844_create_products_table', 8),
(18, '2025_12_17_222856_create_product_receives_table', 8),
(19, '2025_12_20_152953_create_admin_stocks_table', 9),
(20, '2025_12_20_175335_create_product_receive_returns_table', 10),
(21, '2025_12_20_184359_create_product_wastages_table', 11),
(22, '2025_12_20_195324_create_product_sales_tables', 12),
(23, '2025_12_27_060454_create_depo_stocks_table', 13),
(24, '2025_12_28_034937_add_reject_note_to_product_sales_table', 14),
(25, '2025_12_28_062411_create_distributors_table', 15),
(26, '2025_12_28_062422_create_customers_table', 15),
(27, '2025_12_28_062818_create_depo_sales_table', 16),
(28, '2025_12_28_062832_create_depo_sale_details_table', 16);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(3, 'App\\Models\\User', 2, 'auth_token', '40d48f652276bdad5a851cd44a4438ccc6e10c46568d1fd35669b92595ca9c0b', '[\"*\"]', NULL, NULL, '2025-12-08 23:11:23', '2025-12-08 23:11:23'),
(4, 'App\\Models\\User', 2, 'auth_token', 'e110d3cdd0597cdd49cb26510d6625bb263f57c67efaf82f96a80589b0e0150e', '[\"*\"]', NULL, NULL, '2025-12-08 23:11:28', '2025-12-08 23:11:28'),
(5, 'App\\Models\\User', 2, 'auth_token', '5e8b18d65ef436db3a17a4d4cc486f123fe332933725546781e7a28d8e808ded', '[\"*\"]', NULL, NULL, '2025-12-08 23:11:38', '2025-12-08 23:11:38'),
(6, 'App\\Models\\User', 2, 'auth_token', 'bb73b81cc2afb9cfcf46c3bd32dbf30af9aa386de40f44dc1f3454c1d57ed08f', '[\"*\"]', NULL, NULL, '2025-12-08 23:12:05', '2025-12-08 23:12:05'),
(7, 'App\\Models\\User', 2, 'auth_token', '768618d50f26b198b15d36e6220102af89010052746891234fbd59016f6afb9f', '[\"*\"]', NULL, NULL, '2025-12-08 23:12:35', '2025-12-08 23:12:35'),
(10, 'App\\Models\\User', 2, 'auth_token', '3f9413d37c7c4d4217a455bd2d8831736a137a3ad29ea9a493579dce272da846', '[\"*\"]', NULL, NULL, '2025-12-08 23:13:39', '2025-12-08 23:13:39'),
(16, 'App\\Models\\User', 2, 'auth_token', 'a3d99441444afa4401de2cc0f24263712d6d1eef3ca0c608ba8955fd9601d2b6', '[\"*\"]', NULL, NULL, '2025-12-08 23:58:39', '2025-12-08 23:58:39'),
(19, 'App\\Models\\User', 1, 'auth_token', '3e8169b2948dfd4b7fa3fc8fb3d0e3b667dec482fd905e82d0415529787019a8', '[\"*\"]', NULL, NULL, '2025-12-09 00:17:52', '2025-12-09 00:17:52'),
(27, 'App\\Models\\User', 1, 'auth_token', 'f820d1990d24b0b6e5dcecb78065981dca21a59ccf9e441e1ea79a603ef5c688', '[\"*\"]', '2025-12-13 02:43:54', NULL, '2025-12-11 13:23:04', '2025-12-13 02:43:54'),
(29, 'App\\Models\\User', 1, 'auth_token', 'f8c109f0cd25f07df5dd7e96aeb153401408f0fc2777989f6250454a24d6b712', '[\"*\"]', '2025-12-13 11:04:58', NULL, '2025-12-13 02:46:11', '2025-12-13 11:04:58'),
(34, 'App\\Models\\User', 1, 'auth_token', '3c2a2d9bcff0234b7f669c788aff3a0af7be8101f001eb3cc1e6726c66e62a6e', '[\"*\"]', '2025-12-20 14:31:20', NULL, '2025-12-20 08:41:00', '2025-12-20 14:31:20'),
(39, 'App\\Models\\User', 1, 'auth_token', 'c38b82bda366cf61a27b4807edbc470dfd40fadb2f6df3560478d012c328caea', '[\"*\"]', '2025-12-26 22:43:12', NULL, '2025-12-26 22:42:17', '2025-12-26 22:43:12'),
(61, 'App\\Models\\User', 7, 'auth_token', '1accfb59cb6819d010994246fd8f6f60fd2a9a51fe49d013e8aad9f934d5ad69', '[\"*\"]', '2025-12-27 23:12:19', NULL, '2025-12-27 23:12:15', '2025-12-27 23:12:19'),
(63, 'App\\Models\\User', 2, 'auth_token', '240776623516eac0f9e287d4c7291f61942afadb54cbcde16bd2f59d274f3bd9', '[\"*\"]', NULL, NULL, '2025-12-29 08:39:34', '2025-12-29 08:39:34'),
(64, 'App\\Models\\User', 1, 'auth_token', '1518c48211e9f8f53605a5799c1c09d947d2a2a3113509e9bbe05c1ea9d699b2', '[\"*\"]', NULL, NULL, '2025-12-29 08:41:21', '2025-12-29 08:41:21'),
(68, 'App\\Models\\User', 7, 'auth_token', '5b5491ba2ffcb8041eb8d42ef3346be0ca43f69a2a4880e70c339ac7cb430a2b', '[\"*\"]', '2026-01-07 14:39:36', NULL, '2026-01-06 23:17:42', '2026-01-07 14:39:36');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `mrp` decimal(15,2) NOT NULL DEFAULT 0.00,
  `retail_rate` decimal(15,2) NOT NULL DEFAULT 0.00,
  `distributor_rate` decimal(15,2) NOT NULL DEFAULT 0.00,
  `depo_rate` decimal(15,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `sku`, `unit`, `mrp`, `retail_rate`, `distributor_rate`, `depo_rate`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'product 4', '4444', 'Kg', 300.00, 0.00, 280.00, 0.00, NULL, 1, '2025-12-20 08:42:31', '2025-12-20 08:42:31'),
(2, 'Product 5', '5555', 'Pcs', 1000.00, 0.00, 800.00, 0.00, NULL, 1, '2025-12-20 10:33:30', '2025-12-20 10:33:30'),
(3, 'Product 6', '6666', 'Litre', 120.00, 0.00, 100.00, 0.00, NULL, 1, '2025-12-20 21:19:46', '2025-12-20 21:19:46'),
(4, 'Product 1', '1111', 'Pcs', 300.00, 0.00, 280.00, 0.00, NULL, 1, '2025-12-26 22:23:40', '2025-12-26 22:23:40');

-- --------------------------------------------------------

--
-- Table structure for table `product_receives`
--

CREATE TABLE `product_receives` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `receive_number` varchar(255) NOT NULL,
  `receive_date` date NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `batch_no` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_receives`
--

INSERT INTO `product_receives` (`id`, `receive_number`, `receive_date`, `product_id`, `quantity`, `batch_no`, `note`, `created_at`, `updated_at`) VALUES
(1, 'PRC-1766241789', '2025-12-20', 1, 4000.00, '4444', 'Good received', '2025-12-20 08:43:09', '2025-12-20 08:43:09'),
(2, 'PRC-1766248332', '2025-12-20', 1, 1000.00, '4444', 'Goods received', '2025-12-20 10:32:12', '2025-12-20 10:32:12'),
(3, 'PRC-1766250748', '2025-12-20', 2, 2000.00, '5555', 'Good received', '2025-12-20 11:12:28', '2025-12-20 11:12:28'),
(4, 'PRC-1766287616', '2025-12-21', 3, 3000.00, '6666', 'Good received', '2025-12-20 21:26:56', '2025-12-20 21:26:56'),
(5, 'PRC-1766809522', '2025-12-27', 4, 800.00, '1111', 'Good received', '2025-12-26 22:25:22', '2025-12-26 22:25:22');

-- --------------------------------------------------------

--
-- Table structure for table `product_receive_returns`
--

CREATE TABLE `product_receive_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `return_number` varchar(255) NOT NULL,
  `return_date` date NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_receive_returns`
--

INSERT INTO `product_receive_returns` (`id`, `return_number`, `return_date`, `product_id`, `quantity`, `reason`, `created_at`, `updated_at`) VALUES
(1, 'RET-6946EB12EB5DA', '2025-12-20', 2, 100.00, 'Damaged', '2025-12-20 12:29:38', '2025-12-20 12:29:38'),
(2, 'RET-6947962CCD248', '2025-12-21', 3, 50.00, 'Expired', '2025-12-21 00:39:40', '2025-12-21 00:39:40'),
(3, 'RET-694F5F68B3054', '2025-12-27', 4, 20.00, 'Expired', '2025-12-26 22:24:08', '2025-12-26 22:24:08'),
(4, 'RET-694F5FDC66A33', '2025-12-27', 1, 10.00, 'Color not matched', '2025-12-26 22:26:04', '2025-12-26 22:26:04');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `sale_date` date NOT NULL,
  `depo_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `reject_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `invoice_no`, `sale_date`, `depo_id`, `total_amount`, `status`, `note`, `reject_note`, `created_at`, `updated_at`) VALUES
(9, 'INV-176678275329', '2025-12-26', 1, 3565.00, 'accepted', 'cfggh', NULL, '2025-12-26 14:59:13', '2025-12-27 01:16:00'),
(10, 'INV-176680545772', '2025-12-27', 1, 1200.00, 'rejected', 'Colour not matched', NULL, '2025-12-26 21:17:37', '2025-12-27 21:52:35'),
(11, 'INV-176680965469', '2025-12-27', 1, 90000.00, 'rejected', 'Goods sales', 'Size not matched', '2025-12-26 22:27:34', '2025-12-27 22:04:22'),
(12, 'INV-176689518297', '2025-12-28', 3, 162000.00, 'accepted', 'Goods sale', NULL, '2025-12-27 22:13:02', '2025-12-27 22:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales_details`
--

CREATE TABLE `product_sales_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_sale_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales_details`
--

INSERT INTO `product_sales_details` (`id`, `product_sale_id`, `product_id`, `quantity`, `unit_price`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 9, 1, 155.00, 23.00, 3565.00, '2025-12-26 14:59:13', '2025-12-26 14:59:13'),
(2, 10, 2, 12.00, 100.00, 1200.00, '2025-12-26 21:17:37', '2025-12-26 21:17:37'),
(3, 11, 3, 300.00, 300.00, 90000.00, '2025-12-26 22:27:34', '2025-12-26 22:27:34'),
(4, 12, 4, 900.00, 180.00, 162000.00, '2025-12-27 22:13:02', '2025-12-27 22:13:02');

-- --------------------------------------------------------

--
-- Table structure for table `product_wastages`
--

CREATE TABLE `product_wastages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wastage_number` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_wastages`
--

INSERT INTO `product_wastages` (`id`, `wastage_number`, `date`, `product_id`, `quantity`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 'WST-6946F7ED5621A', '2025-12-20', 1, 100.00, 'Date Expired', '2025-12-20 13:24:29', '2025-12-20 13:24:29'),
(2, 'WST-694F6002851AE', '2025-12-27', 2, 10.00, 'Broked', '2025-12-26 22:26:42', '2025-12-26 22:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `po_number` varchar(255) NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `discount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`id`, `po_number`, `supplier_id`, `purchase_date`, `total_amount`, `discount`, `note`, `created_at`, `updated_at`) VALUES
(1, '1', 1, '2025-12-17', 48000.00, 0.00, NULL, '2025-12-17 11:25:13', '2025-12-17 11:25:13'),
(2, '4', 1, '2025-12-21', 120000.00, 0.00, NULL, '2025-12-20 21:24:44', '2025-12-20 21:24:44'),
(3, '3', 3, '2025-12-26', 160000.00, 0.00, NULL, '2025-12-26 22:21:57', '2025-12-26 22:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

CREATE TABLE `purchase_order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` bigint(20) UNSIGNED NOT NULL,
  `raw_material_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(255) DEFAULT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `sub_total` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_order_items`
--

INSERT INTO `purchase_order_items` (`id`, `purchase_order_id`, `raw_material_id`, `batch_no`, `quantity`, `unit_price`, `sub_total`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '111', 200.00, 60.00, 0.00, '2025-12-17 11:25:13', '2025-12-17 11:25:13'),
(2, 1, 1, '222', 300.00, 120.00, 0.00, '2025-12-17 11:25:13', '2025-12-17 11:25:13'),
(3, 2, 1, '444', 1500.00, 80.00, 0.00, '2025-12-20 21:24:44', '2025-12-20 21:24:44'),
(4, 3, 1, '333', 2000.00, 80.00, 0.00, '2025-12-26 22:21:57', '2025-12-26 22:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `raw_materials`
--

CREATE TABLE `raw_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `alert_stock` decimal(10,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `raw_materials`
--

INSERT INTO `raw_materials` (`id`, `name`, `unit_id`, `alert_stock`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Material 3', 1, 60.00, 'Material 1 description', '2025-12-16 13:37:15', '2025-12-26 21:20:02'),
(2, 'Material 4', 1, 40.00, 'Description', '2025-12-16 13:46:45', '2025-12-26 22:20:56'),
(3, 'Material 1', 3, 60.00, 'none', '2025-12-20 21:23:32', '2025-12-20 21:23:32'),
(4, 'Material 2', 1, 50.00, 'New Material', '2025-12-26 21:19:32', '2025-12-26 21:19:32');

-- --------------------------------------------------------

--
-- Table structure for table `raw_material_stocks`
--

CREATE TABLE `raw_material_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `raw_material_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `type` enum('in','out') NOT NULL,
  `reference_id` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `raw_material_stocks`
--

INSERT INTO `raw_material_stocks` (`id`, `raw_material_id`, `quantity`, `type`, `reference_id`, `note`, `created_at`, `updated_at`) VALUES
(1, 2, 200.00, 'in', '1', 'Stock In from Invoice: 1', '2025-12-17 11:25:13', '2025-12-17 11:25:13'),
(2, 1, 300.00, 'in', '1', 'Stock In from Invoice: 1', '2025-12-17 11:25:13', '2025-12-17 11:25:13'),
(3, 1, 1500.00, 'in', '2', 'Stock In from Invoice: 4', '2025-12-20 21:24:44', '2025-12-20 21:24:44'),
(4, 1, 2000.00, 'in', '3', 'Stock In from Invoice: 3', '2025-12-26 22:21:57', '2025-12-26 22:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin', '2025-12-08 23:08:44', '2025-12-08 23:08:44'),
(2, 'Depo', 'depo', '2025-12-08 23:08:44', '2025-12-08 23:08:44'),
(3, 'Distributor', 'distributor', '2025-12-08 23:08:44', '2025-12-08 23:08:44');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`role_id`, `user_id`) VALUES
(1, 1),
(2, 2),
(2, 7),
(3, 3),
(3, 8);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0WDBZVUospXQKx463eZj17ZiRpa4urHwDyUcNFD3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQU12VmwyVUVBa3ZsYnlCczFPMWs3d1hWNDliSWVCODN5dTFRNHlKayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766235786),
('IDtp4pfHJ6DdFgJaR0f9OUA4J50sSllGA67rc5O5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOEJWdXhlTk9mY3pRZnQ1aHNXbVk3YWlVdU1YWUhJd2lsT1NxZUxzVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766807285),
('oZxLNeqPuqBMoDScsoRsVeU7Un51jpvi6WxrbUqQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3Q3NlU4WlQ3Z0tBTm5vMU5Tczk2NXNmbkREWVJBajVxajF1Q3AxQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpVT3RBWlpmNEN5UFVOUFRKIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766286826),
('qoSd3PaoJWyRnqCSWGlirWOu8afAgHeucGoisLGS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidnBxS240dHpUSjB2SmMyT0U1QmROaUhrSDJnd3hlaGdNMG5sQklWeCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767805078),
('rzT3BKWKgOGwi7G9bIunmLknUCLjVQlPlgWUKIm3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblIxeXlrZXEwU0E0Yk00bmdPZ0tHdFhVQmc0MW9nMmVKY09QYWVhNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767763287),
('WbgBL6iF04m59EDCRhMPRhaB2AsWCAXI9lxB8Yqx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjF1Y1RteDZIZHhyT3d1SlhhODFhU09pTDlkVXlFR1Z5SXlmMGxQaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766891787),
('wZMyYJRuoVJGJwuLk4mzTtgMfKwotlVAygG13bxX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3lBVWtEdGNJUkxrTG9OWWZ5T2RoWFU5MmFrb1JzMDBYakx4bWRyQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766235791),
('zuhtPibrNkGWoHgIaXjV3FPAdtRE8gMO59eZDegc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblFCUk5KU2VMaTlLR2pPaVRKSkZvSnpNb0VaRHNZdzVYNzFnbXdSdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767023731);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `contact_person`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Supplier 1', 'Mahatim', 'mahatim@gmail.com', '9876543', 'Noakhali', '2025-12-13 09:46:19', '2025-12-13 09:46:38'),
(2, 'Supplier 2', 'Junayet', 'junayet@gmail.com', '01723334455', 'Hazaribagh,Dhaka', '2025-12-26 22:15:17', '2025-12-26 22:15:17'),
(3, 'Supplier 3', 'Rubel', 'rubel@gmail.com', '01628934631', 'Barishal', '2025-12-26 22:16:11', '2025-12-26 22:16:11');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `short_name` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `short_name`, `created_at`, `updated_at`) VALUES
(1, 'Kilogram', 'KG', '2025-12-16 12:53:32', '2025-12-16 12:53:32'),
(2, 'Piece', 'PCS', '2025-12-16 12:55:26', '2025-12-16 12:55:26'),
(3, 'Box', 'BOX', '2025-12-16 12:56:07', '2025-12-16 12:56:07'),
(4, 'Litre', 'LTR', '2025-12-16 12:59:14', '2025-12-16 12:59:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `depo_id` bigint(20) UNSIGNED DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `depo_id`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@scm.com', NULL, NULL, '$2y$12$MBGYWnqzvHr5JETY7qj2HuOZhovSyLGJYBnHOfRgwBRLkwOnEK/m2', NULL, '2025-12-08 23:08:45', '2025-12-08 23:08:45'),
(2, 'Depo User', 'depo@scm.com', 3, NULL, '$2y$12$ebjb/f9qhm/Ghnj8jHdAY.1Jx2p6IMA4PLHKVw1AsbsCbmwidF4ti', NULL, '2025-12-08 23:10:23', '2025-12-27 22:37:01'),
(3, 'Distributor User', 'distributor@scm.com', NULL, NULL, '$2y$12$BkLlqYRjPuvkjvDN6tb1teSKE3SlldqnR2oV5LzpOvAaLFfMIkZxq', NULL, '2025-12-08 23:10:40', '2025-12-08 23:10:40'),
(7, 'Shefa', 'shefa@gmail.com', 1, NULL, '$2y$12$rKlRLRRvlbI/t1Zjfm8E8O9mMN8CMcM9JmMi9yBnYwCQALrbefKLC', NULL, '2025-12-26 22:18:40', '2025-12-26 22:18:40'),
(8, 'Rokeya', 'rokeya@gmail.com', 2, NULL, '$2y$12$2dkqU2pfLQpyP.7yPXZTq.braaar8CfbiYKfddbQaBeqih1a1fW5u', NULL, '2025-12-26 22:19:49', '2025-12-26 22:19:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_stocks`
--
ALTER TABLE `admin_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_stocks_product_id_foreign` (`product_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customers_depo_id_foreign` (`depo_id`);

--
-- Indexes for table `depos`
--
ALTER TABLE `depos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `depos_name_unique` (`name`);

--
-- Indexes for table `depo_sales`
--
ALTER TABLE `depo_sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `depo_sales_invoice_no_unique` (`invoice_no`),
  ADD KEY `depo_sales_depo_id_foreign` (`depo_id`);

--
-- Indexes for table `depo_sale_details`
--
ALTER TABLE `depo_sale_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `depo_sale_details_depo_sale_id_foreign` (`depo_sale_id`),
  ADD KEY `depo_sale_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `depo_stocks`
--
ALTER TABLE `depo_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `depo_stocks_depo_id_foreign` (`depo_id`),
  ADD KEY `depo_stocks_product_id_foreign` (`product_id`);

--
-- Indexes for table `distributors`
--
ALTER TABLE `distributors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `distributors_depo_id_foreign` (`depo_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `material_issues`
--
ALTER TABLE `material_issues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `material_issues_issue_number_unique` (`issue_number`);

--
-- Indexes for table `material_issue_items`
--
ALTER TABLE `material_issue_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `material_issue_items_material_issue_id_foreign` (`material_issue_id`),
  ADD KEY `material_issue_items_raw_material_id_foreign` (`raw_material_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`);

--
-- Indexes for table `product_receives`
--
ALTER TABLE `product_receives`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_receives_receive_number_unique` (`receive_number`),
  ADD KEY `product_receives_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_receive_returns`
--
ALTER TABLE `product_receive_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_receive_returns_return_number_unique` (`return_number`),
  ADD KEY `product_receive_returns_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_sales_invoice_no_unique` (`invoice_no`),
  ADD KEY `product_sales_depo_id_foreign` (`depo_id`);

--
-- Indexes for table `product_sales_details`
--
ALTER TABLE `product_sales_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_sales_details_product_sale_id_foreign` (`product_sale_id`),
  ADD KEY `product_sales_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_wastages`
--
ALTER TABLE `product_wastages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_wastages_wastage_number_unique` (`wastage_number`),
  ADD KEY `product_wastages_product_id_foreign` (`product_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchase_orders_po_number_unique` (`po_number`),
  ADD KEY `purchase_orders_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_order_items_purchase_order_id_foreign` (`purchase_order_id`),
  ADD KEY `purchase_order_items_raw_material_id_foreign` (`raw_material_id`);

--
-- Indexes for table `raw_materials`
--
ALTER TABLE `raw_materials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `raw_materials_name_unique` (`name`),
  ADD KEY `raw_materials_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `raw_material_stocks`
--
ALTER TABLE `raw_material_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `raw_material_stocks_raw_material_id_foreign` (`raw_material_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`role_id`,`user_id`),
  ADD KEY `role_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suppliers_name_unique` (`name`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `units_name_unique` (`name`),
  ADD UNIQUE KEY `units_short_name_unique` (`short_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_depo_id_foreign` (`depo_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_stocks`
--
ALTER TABLE `admin_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `depos`
--
ALTER TABLE `depos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `depo_sales`
--
ALTER TABLE `depo_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `depo_sale_details`
--
ALTER TABLE `depo_sale_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `depo_stocks`
--
ALTER TABLE `depo_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `distributors`
--
ALTER TABLE `distributors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `material_issues`
--
ALTER TABLE `material_issues`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `material_issue_items`
--
ALTER TABLE `material_issue_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_receives`
--
ALTER TABLE `product_receives`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_receive_returns`
--
ALTER TABLE `product_receive_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_sales_details`
--
ALTER TABLE `product_sales_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_wastages`
--
ALTER TABLE `product_wastages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `raw_materials`
--
ALTER TABLE `raw_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `raw_material_stocks`
--
ALTER TABLE `raw_material_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_stocks`
--
ALTER TABLE `admin_stocks`
  ADD CONSTRAINT `admin_stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_depo_id_foreign` FOREIGN KEY (`depo_id`) REFERENCES `depos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `depo_sales`
--
ALTER TABLE `depo_sales`
  ADD CONSTRAINT `depo_sales_depo_id_foreign` FOREIGN KEY (`depo_id`) REFERENCES `depos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `depo_sale_details`
--
ALTER TABLE `depo_sale_details`
  ADD CONSTRAINT `depo_sale_details_depo_sale_id_foreign` FOREIGN KEY (`depo_sale_id`) REFERENCES `depo_sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `depo_sale_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `depo_stocks`
--
ALTER TABLE `depo_stocks`
  ADD CONSTRAINT `depo_stocks_depo_id_foreign` FOREIGN KEY (`depo_id`) REFERENCES `depos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `depo_stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `distributors`
--
ALTER TABLE `distributors`
  ADD CONSTRAINT `distributors_depo_id_foreign` FOREIGN KEY (`depo_id`) REFERENCES `depos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `material_issue_items`
--
ALTER TABLE `material_issue_items`
  ADD CONSTRAINT `material_issue_items_material_issue_id_foreign` FOREIGN KEY (`material_issue_id`) REFERENCES `material_issues` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `material_issue_items_raw_material_id_foreign` FOREIGN KEY (`raw_material_id`) REFERENCES `raw_materials` (`id`);

--
-- Constraints for table `product_receives`
--
ALTER TABLE `product_receives`
  ADD CONSTRAINT `product_receives_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_receive_returns`
--
ALTER TABLE `product_receive_returns`
  ADD CONSTRAINT `product_receive_returns_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD CONSTRAINT `product_sales_depo_id_foreign` FOREIGN KEY (`depo_id`) REFERENCES `depos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_sales_details`
--
ALTER TABLE `product_sales_details`
  ADD CONSTRAINT `product_sales_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_sales_details_product_sale_id_foreign` FOREIGN KEY (`product_sale_id`) REFERENCES `product_sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_wastages`
--
ALTER TABLE `product_wastages`
  ADD CONSTRAINT `product_wastages_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD CONSTRAINT `purchase_order_items_purchase_order_id_foreign` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_order_items_raw_material_id_foreign` FOREIGN KEY (`raw_material_id`) REFERENCES `raw_materials` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `raw_materials`
--
ALTER TABLE `raw_materials`
  ADD CONSTRAINT `raw_materials_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `raw_material_stocks`
--
ALTER TABLE `raw_material_stocks`
  ADD CONSTRAINT `raw_material_stocks_raw_material_id_foreign` FOREIGN KEY (`raw_material_id`) REFERENCES `raw_materials` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_depo_id_foreign` FOREIGN KEY (`depo_id`) REFERENCES `depos` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
