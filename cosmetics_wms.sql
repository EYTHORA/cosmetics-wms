-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 12, 2026 at 01:37 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cosmetics_wms`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `old_value` text,
  `new_value` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int NOT NULL,
  `brand_code` varchar(10) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `halal_certified` tinyint(1) DEFAULT '0',
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `brand_code`, `name`, `country`, `halal_certified`, `status`) VALUES
(1, 'BR001', 'Wardah', 'Indonesia', 1, 'active'),
(2, 'BR002', 'Make Over', 'Indonesia', 0, 'active'),
(3, 'BR003', 'ESQA', 'Indonesia', 1, 'active'),
(4, 'BR004', 'Implora', 'Indonesia', 1, 'active'),
(5, 'BR005', 'Sariayu', 'Indonesia', 1, 'active'),
(6, 'BR006', 'Maybelline', 'USA', 0, 'active'),
(7, 'BR007', 'L\'Oreal', 'France', 0, 'active'),
(8, 'BR008', 'Pixy', 'Indonesia', 1, 'active'),
(9, 'BR009', 'Dear Me', 'Indonesia', 1, 'active'),
(10, 'BR010', 'Viva', 'Indonesia', 1, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `category_code` varchar(10) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `storage_condition` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_code`, `name`, `description`, `storage_condition`) VALUES
(1, 'CAT001', 'Lipstick', 'Lipstik, lip gloss, lip liner', 'room_temp'),
(2, 'CAT002', 'Foundation', 'Foundation, BB Cream, CC Cream', 'cool'),
(3, 'CAT003', 'Face Powder', 'Bedak wajah, compact powder', 'room_temp'),
(4, 'CAT004', 'Mascara', 'Maskara, eyebrow pencil', 'room_temp'),
(5, 'CAT005', 'Eyeshadow', 'Eyeshadow palette, single shadow', 'room_temp'),
(6, 'CAT006', 'Skincare', 'Serum, moisturizer, cleanser', 'cool'),
(7, 'CAT007', 'Fragrance', 'Parfum, eau de toilette', 'cool_dark'),
(8, 'CAT008', 'Nail Polish', 'Kuteks, nail care', 'room_temp'),
(9, 'CAT009', 'Makeup Tools', 'Brush, sponge, applicator', 'room_temp'),
(10, 'CAT010', 'Skincare Set', 'Paket perawatan wajah', 'cool');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int NOT NULL,
  `customer_code` varchar(20) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `type` enum('retail','distributor','reseller','online_store') DEFAULT 'retail',
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text,
  `tax_number` varchar(50) DEFAULT NULL,
  `credit_limit` decimal(15,2) DEFAULT '0.00',
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_code`, `name`, `type`, `phone`, `email`, `address`, `tax_number`, `credit_limit`, `status`) VALUES
(1, 'CUST001', 'Toko Ratu Kosmetik', 'retail', '021-1112222', 'ratu@tokokosmetik.com', 'Jl. Mangga Besar, Jakarta', NULL, 0.00, 'active'),
(2, 'CUST002', 'CV Beauty Distributor', 'distributor', '021-3334444', 'sales@beautydist.com', 'Jl. Gatot Subroto, Jakarta', NULL, 0.00, 'active'),
(3, 'CUST003', 'Online Store: BibirMerah.com', 'online_store', '085612345678', 'cs@bibirmerah.com', 'BSD City, Tangerang', NULL, 0.00, 'active'),
(4, 'CUST004', 'Reseller Group Bandung', 'reseller', '022-5556666', 'order@resellerbdg.com', 'Jl. Dago, Bandung', NULL, 0.00, 'active'),
(5, 'CUST005', 'Toko Sari Indah', 'retail', '021-7778888', 'sariindah@store.com', 'Pasar Senen, Jakarta', NULL, 0.00, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `expiry_alerts`
--

CREATE TABLE `expiry_alerts` (
  `id` int NOT NULL,
  `batch_id` int NOT NULL,
  `alert_type` enum('warning','critical','expired') NOT NULL,
  `days_remaining` int DEFAULT NULL,
  `alert_message` text,
  `notified_to` int DEFAULT NULL,
  `is_resolved` tinyint(1) DEFAULT '0',
  `resolved_by` int DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `expiry_alerts`
--

INSERT INTO `expiry_alerts` (`id`, `batch_id`, `alert_type`, `days_remaining`, `alert_message`, `notified_to`, `is_resolved`, `resolved_by`, `resolved_at`, `created_at`) VALUES
(1, 3, 'warning', 45, 'Produk akan expired dalam 45 hari', 2, 0, NULL, NULL, '2026-01-12 01:06:16'),
(2, 4, 'critical', 10, 'Produk akan expired dalam 10 hari', 2, 0, NULL, NULL, '2026-01-12 01:06:16'),
(3, 5, 'expired', -5, 'Produk sudah expired 5 hari yang lalu', 1, 0, NULL, NULL, '2026-01-12 01:06:16');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_transactions`
--

CREATE TABLE `inventory_transactions` (
  `id` int NOT NULL,
  `transaction_code` varchar(50) DEFAULT NULL,
  `product_id` int NOT NULL,
  `batch_id` int DEFAULT NULL,
  `transaction_type` enum('purchase_in','return_in','adjustment_in','transfer_in','sale_out','sample_out','damage_out','adjustment_out','transfer_out') DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) DEFAULT NULL,
  `total_value` decimal(15,2) DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL COMMENT 'PO No, SO No, dll',
  `location_id` int DEFAULT NULL,
  `notes` text,
  `created_by` int DEFAULT NULL,
  `transaction_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `inventory_transactions`
--

INSERT INTO `inventory_transactions` (`id`, `transaction_code`, `product_id`, `batch_id`, `transaction_type`, `quantity`, `unit_price`, `total_value`, `reference_no`, `location_id`, `notes`, `created_by`, `transaction_date`) VALUES
(1, 'TRX-001', 1, 1, 'purchase_in', 200, 50000.00, 10000000.00, 'PO-001-2024', NULL, 'Pembelian awal', NULL, '2026-01-12 01:06:16'),
(2, 'TRX-002', 1, 1, 'sale_out', 20, 75000.00, 1500000.00, 'ORD-2024-001', NULL, 'Penjualan ke Toko Ratu', NULL, '2026-01-12 01:06:16'),
(3, 'TRX-003', 5, 5, 'purchase_in', 80, 120000.00, 9600000.00, 'PO-002-2024', NULL, 'Pembelian foundation', NULL, '2026-01-12 01:06:16'),
(4, 'TRX-004', 10, 7, 'purchase_in', 300, 35000.00, 10500000.00, 'PO-003-2024', NULL, 'Pembelian bedak', NULL, '2026-01-12 01:06:16');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_date` date NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `discount` decimal(15,2) DEFAULT '0.00',
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `grand_total` decimal(15,2) DEFAULT NULL,
  `status` enum('draft','confirmed','picking','packing','shipped','delivered','cancelled') DEFAULT 'draft',
  `priority` enum('normal','urgent','express') DEFAULT 'normal',
  `payment_status` enum('pending','partial','paid') DEFAULT 'pending',
  `notes` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `customer_id`, `order_date`, `delivery_date`, `total_amount`, `discount`, `tax_amount`, `grand_total`, `status`, `priority`, `payment_status`, `notes`, `created_by`, `created_at`) VALUES
(1, 'ORD-2024-001', 1, '2024-06-01', NULL, 750000.00, 0.00, 0.00, 825000.00, 'delivered', 'normal', 'pending', NULL, NULL, '2026-01-12 01:06:16'),
(2, 'ORD-2024-002', 2, '2024-06-05', NULL, 1200000.00, 0.00, 0.00, 1320000.00, 'picking', 'normal', 'pending', NULL, NULL, '2026-01-12 01:06:16'),
(3, 'ORD-2024-003', 3, '2024-06-10', NULL, 450000.00, 0.00, 0.00, 495000.00, 'confirmed', 'normal', 'pending', NULL, NULL, '2026-01-12 01:06:16'),
(4, 'ORD-2024-004', 4, '2024-06-12', NULL, 850000.00, 0.00, 0.00, 935000.00, 'draft', 'normal', 'pending', NULL, NULL, '2026-01-12 01:06:16');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `batch_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `picked_quantity` int DEFAULT '0',
  `packed_quantity` int DEFAULT '0',
  `picking_status` enum('pending','picked','partial') DEFAULT 'pending',
  `picking_date` datetime DEFAULT NULL,
  `picked_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `batch_id`, `quantity`, `unit_price`, `total_price`, `picked_quantity`, `packed_quantity`, `picking_status`, `picking_date`, `picked_by`) VALUES
(1, 1, 1, 1, 10, 75000.00, 750000.00, 0, 0, 'pending', NULL, NULL),
(2, 2, 5, 5, 5, 150000.00, 750000.00, 0, 0, 'pending', NULL, NULL),
(3, 2, 10, 7, 10, 45000.00, 450000.00, 0, 0, 'pending', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `picking_lists`
--

CREATE TABLE `picking_lists` (
  `id` int NOT NULL,
  `picking_number` varchar(50) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `picker_id` int DEFAULT NULL,
  `picking_date` date DEFAULT NULL,
  `status` enum('pending','in_progress','completed','cancelled') DEFAULT 'pending',
  `completed_at` datetime DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `sku` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `category_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `description` text,
  `weight` decimal(10,2) DEFAULT NULL COMMENT 'dalam gram',
  `dimensions` varchar(50) DEFAULT NULL COMMENT 'PxLxT dalam cm',
  `unit_price` decimal(15,2) NOT NULL,
  `min_stock` int DEFAULT '10',
  `max_stock` int DEFAULT '100',
  `weight_volume` varchar(50) DEFAULT NULL COMMENT '50ml, 100gr, etc',
  `halal_certified` tinyint(1) DEFAULT '0',
  `bpom_required` tinyint(1) DEFAULT '1',
  `storage_temperature` varchar(50) DEFAULT 'room_temp',
  `status` enum('active','inactive','discontinued') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `name`, `category_id`, `brand_id`, `description`, `weight`, `dimensions`, `unit_price`, `min_stock`, `max_stock`, `weight_volume`, `halal_certified`, `bpom_required`, `storage_temperature`, `status`, `created_at`, `updated_at`) VALUES
(1, 'LIP-001', 'Wardah Lip Cream Matte', 1, 1, NULL, 50.00, NULL, 75000.00, 20, 200, '4.5g', 1, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(2, 'LIP-002', 'Make Over Liquid Lipstick', 1, 2, NULL, 45.00, NULL, 125000.00, 15, 150, '5ml', 0, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(3, 'LIP-003', 'ESQA Moisturizing Lipstick', 1, 3, NULL, 55.00, NULL, 95000.00, 25, 250, '3.8g', 1, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(4, 'LIP-004', 'Maybelline Superstay', 1, 6, NULL, 60.00, NULL, 110000.00, 30, 300, '5ml', 0, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(5, 'FND-001', 'Wardah Lightening Foundation', 2, 1, NULL, 120.00, NULL, 150000.00, 15, 150, '30ml', 1, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(6, 'FND-002', 'Make Over Two Way Cake', 2, 2, NULL, 100.00, NULL, 180000.00, 10, 100, '12g', 0, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(7, 'FND-003', 'L\'Oreal True Match', 2, 7, NULL, 150.00, NULL, 250000.00, 20, 200, '30ml', 0, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(8, 'FND-004', 'Pixy Make It Glow', 2, 8, NULL, 110.00, NULL, 120000.00, 25, 250, '20ml', 1, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(9, 'POW-001', 'Wardah Everyday Powder', 3, 1, NULL, 80.00, NULL, 65000.00, 30, 300, '10g', 1, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(10, 'POW-002', 'Sariayu Bedak Padat', 3, 5, NULL, 90.00, NULL, 55000.00, 40, 400, '12g', 1, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(11, 'POW-003', 'Implora Compact Powder', 3, 4, NULL, 85.00, NULL, 45000.00, 35, 350, '9g', 1, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(12, 'MSC-001', 'Wardah Lengthboost Mascara', 4, 1, NULL, 60.00, NULL, 85000.00, 20, 200, '8ml', 1, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(13, 'MSC-002', 'Maybelline Hypercurl', 4, 6, NULL, 65.00, NULL, 120000.00, 25, 250, '9ml', 0, 1, 'room_temp', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(14, 'SKN-001', 'Wardah White Secret Serum', 6, 1, NULL, 100.00, NULL, 225000.00, 15, 150, '30ml', 1, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(15, 'SKN-002', 'ESQA Glow Serum', 6, 3, NULL, 95.00, NULL, 275000.00, 10, 100, '20ml', 1, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(16, 'SKN-003', 'Dear Me Beauty Serum', 6, 9, NULL, 105.00, NULL, 195000.00, 20, 200, '25ml', 1, 1, 'cool', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(17, 'FRG-001', 'Viva Woman EDP', 7, 10, NULL, 200.00, NULL, 185000.00, 10, 100, '50ml', 1, 1, 'cool_dark', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(18, 'FRG-002', 'Wardah Exclusive Parfume', 7, 1, NULL, 180.00, NULL, 165000.00, 12, 120, '30ml', 1, 1, 'cool_dark', 'active', '2026-01-12 01:06:15', '2026-01-12 01:06:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `batch_number` varchar(100) NOT NULL,
  `manufacturing_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `quantity` int NOT NULL COMMENT 'jumlah awal',
  `current_quantity` int NOT NULL COMMENT 'jumlah saat ini',
  `supplier_id` int DEFAULT NULL,
  `bpom_number` varchar(100) DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `temperature_requirement` varchar(50) DEFAULT NULL,
  `purchase_price` decimal(15,2) DEFAULT NULL,
  `status` enum('quarantine','released','reserved','expired','recalled','sold_out') DEFAULT 'quarantine',
  `notes` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_number`, `manufacturing_date`, `expiry_date`, `quantity`, `current_quantity`, `supplier_id`, `bpom_number`, `location_id`, `temperature_requirement`, `purchase_price`, `status`, `notes`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'BATCH-LIP001-2024-01', '2024-01-15', '2025-07-15', 200, 180, 1, 'BPOM123456789', 5, 'room_temp', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(2, 1, 'BATCH-LIP001-2024-02', '2024-03-20', '2025-09-20', 150, 150, 1, 'BPOM123456790', 5, 'room_temp', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(3, 2, 'BATCH-LIP002-2023-11', '2023-11-10', '2024-11-10', 100, 50, 2, 'BPOM987654321', 1, 'room_temp', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(4, 5, 'BATCH-FND001-2023-12', '2023-12-01', '2024-12-01', 80, 30, 1, 'BPOM456789123', 9, 'cool', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(5, 3, 'BATCH-LIP003-2023-08', '2023-08-01', '2024-08-01', 120, 40, 3, 'BPOM789123456', 6, 'room_temp', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(6, 4, 'BATCH-LIP004-2023-05', '2023-05-15', '2024-05-15', 200, 15, 2, 'BPOM321654987', 2, 'room_temp', NULL, 'expired', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(7, 6, 'BATCH-FND002-2024-05', '2024-05-10', '2025-05-10', 100, 100, 1, 'BPOM159357456', 10, 'cool', NULL, 'quarantine', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(8, 10, 'BATCH-POW002-2024-02', '2024-02-20', '2025-08-20', 300, 250, 5, 'BPOM753951852', 7, 'room_temp', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(9, 15, 'BATCH-SKN001-2024-04', '2024-04-01', '2025-10-01', 120, 100, 1, 'BPOM258147369', 11, 'cool', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15'),
(10, 18, 'BATCH-FRG001-2024-03', '2024-03-15', '2026-03-15', 80, 75, 4, 'BPOM147258369', 13, 'cold', NULL, 'released', NULL, NULL, '2026-01-12 01:06:15', '2026-01-12 01:06:15');

-- --------------------------------------------------------

--
-- Table structure for table `qc_checks`
--

CREATE TABLE `qc_checks` (
  `id` int NOT NULL,
  `batch_id` int NOT NULL,
  `check_type` enum('incoming','periodic','outgoing') NOT NULL,
  `checked_by` int DEFAULT NULL,
  `check_date` date NOT NULL,
  `temperature_check` decimal(5,2) DEFAULT NULL,
  `humidity_check` decimal(5,2) DEFAULT NULL,
  `packaging_condition` enum('good','damaged','sealed') DEFAULT 'good',
  `product_condition` enum('good','expired','damaged','contaminated') DEFAULT 'good',
  `passed` tinyint(1) DEFAULT '0',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `qc_checks`
--

INSERT INTO `qc_checks` (`id`, `batch_id`, `check_type`, `checked_by`, `check_date`, `temperature_check`, `humidity_check`, `packaging_condition`, `product_condition`, `passed`, `notes`) VALUES
(1, 1, 'incoming', 4, '2024-01-20', 25.50, 55.00, 'sealed', 'good', 1, NULL),
(2, 6, 'incoming', 4, '2024-05-12', 22.00, 60.00, 'damaged', 'good', 0, NULL),
(3, 7, 'periodic', 4, '2024-06-01', 24.00, 58.00, 'good', 'good', 1, NULL),
(4, 9, 'outgoing', 4, '2024-06-02', 23.50, 56.50, 'good', 'good', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int NOT NULL,
  `supplier_code` varchar(20) DEFAULT NULL,
  `company_name` varchar(200) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text,
  `tax_number` varchar(50) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplier_code`, `company_name`, `contact_person`, `phone`, `email`, `address`, `tax_number`, `status`) VALUES
(1, 'SUP001', 'PT Kosmetika Indonesia', 'Bapak Agus', '021-1234567', 'agus@kosmetika.co.id', 'Jl. Industri No. 123, Jakarta', NULL, 'active'),
(2, 'SUP002', 'CV Beauty Supplies', 'Ibu Maya', '021-7654321', 'maya@beauty.co.id', 'Jl. Raya Bogor KM 5, Depok', NULL, 'active'),
(3, 'SUP003', 'PT Global Cosmetic', 'Mr. Lee', '021-8889999', 'lee@globalcosmetic.com', 'Pluit, Jakarta Utara', NULL, 'active'),
(4, 'SUP004', 'UD Sari Kosmetik', 'Bapak Bambang', '022-123456', 'bambang@sarikosmetik.com', 'Jl. Cihampelas, Bandung', NULL, 'active'),
(5, 'SUP005', 'PT Halal Beauty', 'Ibu Aisyah', '021-4567890', 'aisyah@halalbeauty.id', 'Jl. Thamrin, Jakarta Pusat', NULL, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('admin','manager','staff_gudang','qc_staff') DEFAULT 'staff_gudang',
  `department` varchar(50) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `email`, `role`, `department`, `last_login`, `status`, `created_at`) VALUES
(1, 'admin', '$2y$10$YourHashedPasswordHere', 'Admin Utama', 'admin@cosmetics.id', 'admin', 'Administration', NULL, 'active', '2026-01-12 01:06:15'),
(2, 'manager1', '$2y$10$YourHashedPasswordHere', 'Budi Santoso', 'budi@cosmetics.id', 'manager', 'Warehouse', NULL, 'active', '2026-01-12 01:06:15'),
(3, 'staff1', '$2y$10$YourHashedPasswordHere', 'Sari Dewi', 'sari@cosmetics.id', 'staff_gudang', 'Warehouse', NULL, 'active', '2026-01-12 01:06:15'),
(4, 'qc1', '$2y$10$YourHashedPasswordHere', 'Ratna Wijaya', 'ratna@cosmetics.id', 'qc_staff', 'Quality Control', NULL, 'active', '2026-01-12 01:06:15'),
(5, 'picker1', '$2y$10$YourHashedPasswordHere', 'Andi Pratama', 'andi@cosmetics.id', 'staff_gudang', 'Picking', NULL, 'active', '2026-01-12 01:06:15');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_locations`
--

CREATE TABLE `warehouse_locations` (
  `id` int NOT NULL,
  `location_code` varchar(20) NOT NULL COMMENT 'Format: ZONE-RACK-SHELF (A-01-01)',
  `zone_code` varchar(10) NOT NULL,
  `rack_number` varchar(10) DEFAULT NULL,
  `shelf_number` varchar(10) DEFAULT NULL,
  `temperature_zone` enum('room_temp','cool','cold') DEFAULT 'room_temp',
  `halal_zone` tinyint(1) DEFAULT '0',
  `max_capacity` int DEFAULT NULL COMMENT 'max item yang bisa disimpan',
  `current_capacity` int DEFAULT '0',
  `status` enum('available','full','maintenance') DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `warehouse_locations`
--

INSERT INTO `warehouse_locations` (`id`, `location_code`, `zone_code`, `rack_number`, `shelf_number`, `temperature_zone`, `halal_zone`, `max_capacity`, `current_capacity`, `status`, `created_at`) VALUES
(1, 'A-01-01', 'A', '01', '01', 'room_temp', 0, 100, 0, 'available', '2026-01-12 01:06:15'),
(2, 'A-01-02', 'A', '01', '02', 'room_temp', 0, 100, 0, 'available', '2026-01-12 01:06:15'),
(3, 'A-02-01', 'A', '02', '01', 'room_temp', 0, 80, 0, 'available', '2026-01-12 01:06:15'),
(4, 'A-02-02', 'A', '02', '02', 'room_temp', 0, 80, 0, 'available', '2026-01-12 01:06:15'),
(5, 'B-01-01', 'B', '01', '01', 'room_temp', 1, 120, 0, 'available', '2026-01-12 01:06:15'),
(6, 'B-01-02', 'B', '01', '02', 'room_temp', 1, 120, 0, 'available', '2026-01-12 01:06:15'),
(7, 'B-02-01', 'B', '02', '01', 'room_temp', 1, 100, 0, 'available', '2026-01-12 01:06:15'),
(8, 'B-02-02', 'B', '02', '02', 'room_temp', 1, 100, 0, 'available', '2026-01-12 01:06:15'),
(9, 'C-01-01', 'C', '01', '01', 'cool', 0, 60, 0, 'available', '2026-01-12 01:06:15'),
(10, 'C-01-02', 'C', '01', '02', 'cool', 0, 60, 0, 'available', '2026-01-12 01:06:15'),
(11, 'C-02-01', 'C', '02', '01', 'cool', 1, 60, 0, 'available', '2026-01-12 01:06:15'),
(12, 'C-02-02', 'C', '02', '02', 'cool', 1, 60, 0, 'available', '2026-01-12 01:06:15'),
(13, 'D-01-01', 'D', '01', '01', 'cold', 1, 40, 0, 'available', '2026-01-12 01:06:15'),
(14, 'D-01-02', 'D', '01', '02', 'cold', 1, 40, 0, 'available', '2026-01-12 01:06:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brand_code` (`brand_code`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_code` (`category_code`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_code` (`customer_code`);

--
-- Indexes for table `expiry_alerts`
--
ALTER TABLE `expiry_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `batch_id` (`batch_id`),
  ADD KEY `notified_to` (`notified_to`),
  ADD KEY `resolved_by` (`resolved_by`);

--
-- Indexes for table `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_code` (`transaction_code`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `batch_id` (`batch_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `batch_id` (`batch_id`),
  ADD KEY `picked_by` (`picked_by`);

--
-- Indexes for table `picking_lists`
--
ALTER TABLE `picking_lists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `picking_number` (`picking_number`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `picker_id` (`picker_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `batch_number` (`batch_number`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `qc_checks`
--
ALTER TABLE `qc_checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `batch_id` (`batch_id`),
  ADD KEY `checked_by` (`checked_by`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `supplier_code` (`supplier_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `warehouse_locations`
--
ALTER TABLE `warehouse_locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `location_code` (`location_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expiry_alerts`
--
ALTER TABLE `expiry_alerts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `picking_lists`
--
ALTER TABLE `picking_lists`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `qc_checks`
--
ALTER TABLE `qc_checks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `warehouse_locations`
--
ALTER TABLE `warehouse_locations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `expiry_alerts`
--
ALTER TABLE `expiry_alerts`
  ADD CONSTRAINT `expiry_alerts_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `product_batches` (`id`),
  ADD CONSTRAINT `expiry_alerts_ibfk_2` FOREIGN KEY (`notified_to`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `expiry_alerts_ibfk_3` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  ADD CONSTRAINT `inventory_transactions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `inventory_transactions_ibfk_2` FOREIGN KEY (`batch_id`) REFERENCES `product_batches` (`id`),
  ADD CONSTRAINT `inventory_transactions_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `warehouse_locations` (`id`),
  ADD CONSTRAINT `inventory_transactions_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`batch_id`) REFERENCES `product_batches` (`id`),
  ADD CONSTRAINT `order_items_ibfk_4` FOREIGN KEY (`picked_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `picking_lists`
--
ALTER TABLE `picking_lists`
  ADD CONSTRAINT `picking_lists_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `picking_lists_ibfk_2` FOREIGN KEY (`picker_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Constraints for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD CONSTRAINT `product_batches_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_batches_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  ADD CONSTRAINT `product_batches_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `warehouse_locations` (`id`),
  ADD CONSTRAINT `product_batches_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `qc_checks`
--
ALTER TABLE `qc_checks`
  ADD CONSTRAINT `qc_checks_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `product_batches` (`id`),
  ADD CONSTRAINT `qc_checks_ibfk_2` FOREIGN KEY (`checked_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
