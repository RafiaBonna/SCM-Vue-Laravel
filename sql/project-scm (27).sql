-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 26, 2025 at 10:00 PM
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
(1, 1, 0.00, 1000.00, 0.00, 0.00, 0.00, 100.00, 900.00, '2025-12-20 10:32:12', '2025-12-20 13:24:29'),
(2, 2, 0.00, 2000.00, 100.00, 0.00, 0.00, 0.00, 1900.00, '2025-12-20 11:12:28', '2025-12-20 12:29:39');

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
(3, 'Mustak', 'Kalkata', 'Nadim', '98765444', '2025-12-13 09:24:05', '2025-12-13 09:25:40');

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
(1, 'ISS-20251217-483', '2025-12-17', 'fhg', '2025-12-17 16:11:23', '2025-12-17 16:11:23');

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
(1, 1, 1, 10.00, '222', '2025-12-17 16:11:23', '2025-12-17 16:11:23');

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
(22, '2025_12_20_195324_create_product_sales_tables', 12);

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
(35, 'App\\Models\\User', 1, 'auth_token', '5754c756215f31aa28c266ce1507f593e85d629603adddc33f2f701217522fe0', '[\"*\"]', '2025-12-26 14:59:20', NULL, '2025-12-26 12:10:17', '2025-12-26 14:59:20');

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
(2, 'Product 5', '5555', 'Pcs', 1000.00, 0.00, 800.00, 0.00, NULL, 1, '2025-12-20 10:33:30', '2025-12-20 10:33:30');

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
(3, 'PRC-1766250748', '2025-12-20', 2, 2000.00, '5555', 'Good received', '2025-12-20 11:12:28', '2025-12-20 11:12:28');

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
(1, 'RET-6946EB12EB5DA', '2025-12-20', 2, 100.00, 'Damaged', '2025-12-20 12:29:38', '2025-12-20 12:29:38');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `invoice_no`, `sale_date`, `depo_id`, `total_amount`, `status`, `note`, `created_at`, `updated_at`) VALUES
(9, 'INV-176678275329', '2025-12-26', 1, 3565.00, 'pending', 'cfggh', '2025-12-26 14:59:13', '2025-12-26 14:59:13');

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
(1, 9, 1, 155.00, 23.00, 3565.00, '2025-12-26 14:59:13', '2025-12-26 14:59:13');

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
(1, 'WST-6946F7ED5621A', '2025-12-20', 1, 100.00, 'Date Expired', '2025-12-20 13:24:29', '2025-12-20 13:24:29');

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
(1, '1', 1, '2025-12-17', 48000.00, 0.00, NULL, '2025-12-17 11:25:13', '2025-12-17 11:25:13');

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
(2, 1, 1, '222', 300.00, 120.00, 0.00, '2025-12-17 11:25:13', '2025-12-17 11:25:13');

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
(1, 'Sugar', 1, 60.00, 'Material 1 description', '2025-12-16 13:37:15', '2025-12-16 13:45:11'),
(2, 'Flour', 1, 40.00, 'Description', '2025-12-16 13:46:45', '2025-12-16 13:46:45');

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
(2, 1, 300.00, 'in', '1', 'Stock In from Invoice: 1', '2025-12-17 11:25:13', '2025-12-17 11:25:13');

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
(2, 4),
(2, 6),
(3, 3);

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
('tnCq0OhQyAz5MIlY50GORF70mfRmKRDtOxsyphyV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmxhWDJVOFU5RGF1UzRxS2hwMUNpRkFINEM2aHl5Q3daajhwTkQ1ZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766774169),
('wZMyYJRuoVJGJwuLk4mzTtgMfKwotlVAygG13bxX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3lBVWtEdGNJUkxrTG9OWWZ5T2RoWFU5MmFrb1JzMDBYakx4bWRyQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766235791);

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
(1, 'Supplier 1', 'Mahatim', 'mahatim@gmail.com', '9876543', 'Noakhali', '2025-12-13 09:46:19', '2025-12-13 09:46:38');

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
(2, 'Depo User', 'depo@scm.com', NULL, NULL, '$2y$12$ebjb/f9qhm/Ghnj8jHdAY.1Jx2p6IMA4PLHKVw1AsbsCbmwidF4ti', NULL, '2025-12-08 23:10:23', '2025-12-08 23:10:23'),
(3, 'Distributor User', 'distributor@scm.com', NULL, NULL, '$2y$12$BkLlqYRjPuvkjvDN6tb1teSKE3SlldqnR2oV5LzpOvAaLFfMIkZxq', NULL, '2025-12-08 23:10:40', '2025-12-08 23:10:40'),
(4, 'Rafia', 'rafia@gmail.com', NULL, NULL, '$2y$12$gkahsmwe6bwpnpq0hE40feIMHZ.LDCWg99./t8bpLvejrjv9HnFQq', NULL, '2025-12-12 13:47:39', '2025-12-12 13:47:39'),
(6, 'afia', 'afia@scm.com', 1, NULL, '$2y$12$Div.9.OJwVCblTLIPQ6mc.4cxDmDBAGtjpzDags7MG5fnot..7POi', NULL, '2025-12-13 05:12:56', '2025-12-13 05:12:56');

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
-- Indexes for table `depos`
--
ALTER TABLE `depos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `depos_name_unique` (`name`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `depos`
--
ALTER TABLE `depos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `material_issue_items`
--
ALTER TABLE `material_issue_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_receives`
--
ALTER TABLE `product_receives`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_receive_returns`
--
ALTER TABLE `product_receive_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product_sales_details`
--
ALTER TABLE `product_sales_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_wastages`
--
ALTER TABLE `product_wastages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `raw_materials`
--
ALTER TABLE `raw_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `raw_material_stocks`
--
ALTER TABLE `raw_material_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_stocks`
--
ALTER TABLE `admin_stocks`
  ADD CONSTRAINT `admin_stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

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
