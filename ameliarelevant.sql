-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-02-2025 a las 15:30:04
-- Versión del servidor: 8.0.37
-- Versión de PHP: 8.3.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `peltieri_wp240`
--
CREATE DATABASE IF NOT EXISTS `peltieri_wp240` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
USE `peltieri_wp240`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_annual_fee_control`
--

DROP TABLE IF EXISTS `wp6w_amelia_annual_fee_control`;
CREATE TABLE `wp6w_amelia_annual_fee_control` (
  `id` int NOT NULL,
  `customerId` int NOT NULL,
  `firstName` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `lastName` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` enum('pending','paid','exempt') COLLATE utf8mb4_unicode_520_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_appointments`
--

DROP TABLE IF EXISTS `wp6w_amelia_appointments`;
CREATE TABLE `wp6w_amelia_appointments` (
  `id` int NOT NULL,
  `status` enum('approved','pending','canceled','rejected','no-show') DEFAULT NULL,
  `bookingStart` datetime NOT NULL,
  `bookingEnd` datetime NOT NULL,
  `notifyParticipants` tinyint(1) NOT NULL,
  `serviceId` int NOT NULL,
  `packageId` int DEFAULT NULL,
  `providerId` int NOT NULL,
  `locationId` int DEFAULT NULL,
  `internalNotes` mediumtext,
  `googleCalendarEventId` varchar(255) DEFAULT NULL,
  `googleMeetUrl` varchar(255) DEFAULT NULL,
  `outlookCalendarEventId` varchar(255) DEFAULT NULL,
  `zoomMeeting` mediumtext,
  `lessonSpace` mediumtext,
  `parentId` int DEFAULT NULL,
  `error` mediumtext,
  `appleCalendarEventId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_cache`
--

DROP TABLE IF EXISTS `wp6w_amelia_cache`;
CREATE TABLE `wp6w_amelia_cache` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `paymentId` int DEFAULT NULL,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_categories`
--

DROP TABLE IF EXISTS `wp6w_amelia_categories`;
CREATE TABLE `wp6w_amelia_categories` (
  `id` int NOT NULL,
  `status` enum('hidden','visible','disabled') NOT NULL DEFAULT 'visible',
  `name` varchar(255) NOT NULL DEFAULT '',
  `position` int NOT NULL,
  `translations` text,
  `color` varchar(255) NOT NULL DEFAULT '#1788FB',
  `pictureFullPath` varchar(767) DEFAULT NULL,
  `pictureThumbPath` varchar(767) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_coupons`
--

DROP TABLE IF EXISTS `wp6w_amelia_coupons`;
CREATE TABLE `wp6w_amelia_coupons` (
  `id` int NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `discount` double NOT NULL,
  `deduction` double NOT NULL,
  `limit` double NOT NULL,
  `customerLimit` double NOT NULL DEFAULT '0',
  `status` enum('hidden','visible') NOT NULL,
  `notificationInterval` int NOT NULL DEFAULT '0',
  `notificationRecurring` tinyint(1) NOT NULL DEFAULT '0',
  `expirationDate` datetime DEFAULT NULL,
  `allServices` tinyint(1) NOT NULL DEFAULT '0',
  `allEvents` tinyint(1) NOT NULL DEFAULT '0',
  `allPackages` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_coupons_to_events`
--

DROP TABLE IF EXISTS `wp6w_amelia_coupons_to_events`;
CREATE TABLE `wp6w_amelia_coupons_to_events` (
  `id` int NOT NULL,
  `couponId` int NOT NULL,
  `eventId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_coupons_to_packages`
--

DROP TABLE IF EXISTS `wp6w_amelia_coupons_to_packages`;
CREATE TABLE `wp6w_amelia_coupons_to_packages` (
  `id` int NOT NULL,
  `couponId` int NOT NULL,
  `packageId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_coupons_to_services`
--

DROP TABLE IF EXISTS `wp6w_amelia_coupons_to_services`;
CREATE TABLE `wp6w_amelia_coupons_to_services` (
  `id` int NOT NULL,
  `couponId` int NOT NULL,
  `serviceId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_customer_bookings`
--

DROP TABLE IF EXISTS `wp6w_amelia_customer_bookings`;
CREATE TABLE `wp6w_amelia_customer_bookings` (
  `id` int NOT NULL,
  `appointmentId` int DEFAULT NULL,
  `customerId` int NOT NULL,
  `status` enum('approved','pending','canceled','rejected','no-show','waiting') DEFAULT NULL,
  `price` double NOT NULL,
  `tax` varchar(255) DEFAULT NULL,
  `persons` int NOT NULL,
  `couponId` int DEFAULT NULL,
  `token` varchar(10) DEFAULT NULL,
  `customFields` text,
  `info` text,
  `utcOffset` int DEFAULT NULL,
  `aggregatedPrice` tinyint(1) DEFAULT '1',
  `packageCustomerServiceId` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `actionsCompleted` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_customer_bookings_to_events_periods`
--

DROP TABLE IF EXISTS `wp6w_amelia_customer_bookings_to_events_periods`;
CREATE TABLE `wp6w_amelia_customer_bookings_to_events_periods` (
  `id` int NOT NULL,
  `customerBookingId` bigint NOT NULL,
  `eventPeriodId` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_customer_bookings_to_events_tickets`
--

DROP TABLE IF EXISTS `wp6w_amelia_customer_bookings_to_events_tickets`;
CREATE TABLE `wp6w_amelia_customer_bookings_to_events_tickets` (
  `id` int NOT NULL,
  `customerBookingId` bigint NOT NULL,
  `eventTicketId` bigint NOT NULL,
  `price` double DEFAULT '0',
  `persons` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_customer_bookings_to_extras`
--

DROP TABLE IF EXISTS `wp6w_amelia_customer_bookings_to_extras`;
CREATE TABLE `wp6w_amelia_customer_bookings_to_extras` (
  `id` int NOT NULL,
  `customerBookingId` int NOT NULL,
  `extraId` int NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  `tax` varchar(255) DEFAULT NULL,
  `aggregatedPrice` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_custom_fields`
--

DROP TABLE IF EXISTS `wp6w_amelia_custom_fields`;
CREATE TABLE `wp6w_amelia_custom_fields` (
  `id` int NOT NULL,
  `label` text,
  `type` enum('text','text-area','select','checkbox','radio','content','file','datepicker','address') NOT NULL DEFAULT 'text',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `position` int NOT NULL,
  `translations` text,
  `allServices` tinyint(1) DEFAULT NULL,
  `allEvents` tinyint(1) DEFAULT NULL,
  `useAsLocation` tinyint(1) DEFAULT NULL,
  `width` int NOT NULL DEFAULT '50'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_custom_fields_events`
--

DROP TABLE IF EXISTS `wp6w_amelia_custom_fields_events`;
CREATE TABLE `wp6w_amelia_custom_fields_events` (
  `id` int NOT NULL,
  `customFieldId` int NOT NULL,
  `eventId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_custom_fields_options`
--

DROP TABLE IF EXISTS `wp6w_amelia_custom_fields_options`;
CREATE TABLE `wp6w_amelia_custom_fields_options` (
  `id` int NOT NULL,
  `customFieldId` int NOT NULL,
  `label` text,
  `position` int NOT NULL,
  `translations` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_custom_fields_services`
--

DROP TABLE IF EXISTS `wp6w_amelia_custom_fields_services`;
CREATE TABLE `wp6w_amelia_custom_fields_services` (
  `id` int NOT NULL,
  `customFieldId` int NOT NULL,
  `serviceId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_events`
--

DROP TABLE IF EXISTS `wp6w_amelia_events`;
CREATE TABLE `wp6w_amelia_events` (
  `id` int NOT NULL,
  `parentId` bigint DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `status` enum('approved','pending','canceled','rejected') NOT NULL,
  `bookingOpens` datetime DEFAULT NULL,
  `bookingCloses` datetime DEFAULT NULL,
  `bookingOpensRec` enum('same','calculate') DEFAULT 'same',
  `bookingClosesRec` enum('same','calculate') DEFAULT 'same',
  `ticketRangeRec` enum('same','calculate') DEFAULT 'calculate',
  `recurringCycle` enum('daily','weekly','monthly','yearly') DEFAULT NULL,
  `recurringOrder` int DEFAULT NULL,
  `recurringInterval` int DEFAULT '1',
  `recurringMonthly` enum('each','on') DEFAULT 'each',
  `monthlyDate` datetime DEFAULT NULL,
  `monthlyOnRepeat` enum('first','second','third','fourth','fifth','last') DEFAULT NULL,
  `monthlyOnDay` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') DEFAULT NULL,
  `recurringUntil` datetime DEFAULT NULL,
  `maxCapacity` int NOT NULL,
  `maxCustomCapacity` int DEFAULT NULL,
  `maxExtraPeople` int DEFAULT NULL,
  `price` double NOT NULL,
  `locationId` bigint DEFAULT NULL,
  `customLocation` varchar(255) DEFAULT NULL,
  `description` mediumtext,
  `color` varchar(255) DEFAULT NULL,
  `show` tinyint(1) NOT NULL DEFAULT '1',
  `notifyParticipants` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `settings` mediumtext,
  `zoomUserId` varchar(255) DEFAULT NULL,
  `bringingAnyone` tinyint(1) DEFAULT '1',
  `bookMultipleTimes` tinyint(1) DEFAULT '1',
  `translations` text,
  `depositPayment` enum('disabled','fixed','percentage') DEFAULT 'disabled',
  `depositPerPerson` tinyint(1) DEFAULT '1',
  `fullPayment` tinyint(1) DEFAULT '0',
  `deposit` double DEFAULT '0',
  `customPricing` tinyint(1) DEFAULT '0',
  `organizerId` bigint DEFAULT NULL,
  `closeAfterMin` int DEFAULT NULL,
  `closeAfterMinBookings` tinyint(1) DEFAULT '0',
  `aggregatedPrice` tinyint(1) DEFAULT '1',
  `error` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_events_periods`
--

DROP TABLE IF EXISTS `wp6w_amelia_events_periods`;
CREATE TABLE `wp6w_amelia_events_periods` (
  `id` int NOT NULL,
  `eventId` bigint NOT NULL,
  `periodStart` datetime NOT NULL,
  `periodEnd` datetime NOT NULL,
  `zoomMeeting` mediumtext,
  `lessonSpace` mediumtext,
  `googleCalendarEventId` varchar(255) DEFAULT NULL,
  `googleMeetUrl` varchar(255) DEFAULT NULL,
  `outlookCalendarEventId` varchar(255) DEFAULT NULL,
  `appleCalendarEventId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_events_tags`
--

DROP TABLE IF EXISTS `wp6w_amelia_events_tags`;
CREATE TABLE `wp6w_amelia_events_tags` (
  `id` int NOT NULL,
  `eventId` bigint NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_events_to_providers`
--

DROP TABLE IF EXISTS `wp6w_amelia_events_to_providers`;
CREATE TABLE `wp6w_amelia_events_to_providers` (
  `id` int NOT NULL,
  `eventId` bigint NOT NULL,
  `userId` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_events_to_tickets`
--

DROP TABLE IF EXISTS `wp6w_amelia_events_to_tickets`;
CREATE TABLE `wp6w_amelia_events_to_tickets` (
  `id` int NOT NULL,
  `eventId` bigint NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `price` double DEFAULT '0',
  `dateRanges` text,
  `spots` int NOT NULL,
  `waitingListSpots` int NOT NULL,
  `translations` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_extras`
--

DROP TABLE IF EXISTS `wp6w_amelia_extras`;
CREATE TABLE `wp6w_amelia_extras` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext,
  `price` double NOT NULL,
  `maxQuantity` int NOT NULL,
  `duration` int DEFAULT NULL,
  `serviceId` int NOT NULL,
  `position` int NOT NULL,
  `aggregatedPrice` tinyint(1) DEFAULT NULL,
  `translations` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_galleries`
--

DROP TABLE IF EXISTS `wp6w_amelia_galleries`;
CREATE TABLE `wp6w_amelia_galleries` (
  `id` int NOT NULL,
  `entityId` int NOT NULL,
  `entityType` enum('service','event','package') NOT NULL,
  `pictureFullPath` varchar(767) DEFAULT NULL,
  `pictureThumbPath` varchar(767) DEFAULT NULL,
  `position` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_locations`
--

DROP TABLE IF EXISTS `wp6w_amelia_locations`;
CREATE TABLE `wp6w_amelia_locations` (
  `id` int NOT NULL,
  `status` enum('hidden','visible','disabled') NOT NULL DEFAULT 'visible',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext,
  `address` varchar(255) NOT NULL,
  `phone` varchar(63) NOT NULL,
  `latitude` decimal(8,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `pictureFullPath` varchar(767) DEFAULT NULL,
  `pictureThumbPath` varchar(767) DEFAULT NULL,
  `pin` mediumtext,
  `translations` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_locations_views`
--

DROP TABLE IF EXISTS `wp6w_amelia_locations_views`;
CREATE TABLE `wp6w_amelia_locations_views` (
  `id` int NOT NULL,
  `locationId` int NOT NULL,
  `date` date NOT NULL,
  `views` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_notifications`
--

DROP TABLE IF EXISTS `wp6w_amelia_notifications`;
CREATE TABLE `wp6w_amelia_notifications` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `customName` varchar(255) DEFAULT NULL,
  `status` enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
  `type` enum('email','sms','whatsapp') NOT NULL,
  `entity` enum('appointment','event') NOT NULL DEFAULT 'appointment',
  `time` time DEFAULT NULL,
  `timeBefore` int DEFAULT NULL,
  `timeAfter` int DEFAULT NULL,
  `sendTo` enum('customer','provider') NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `translations` text,
  `sendOnlyMe` tinyint(1) DEFAULT '0',
  `whatsAppTemplate` varchar(255) DEFAULT NULL,
  `minimumTimeBeforeBooking` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_notifications_log`
--

DROP TABLE IF EXISTS `wp6w_amelia_notifications_log`;
CREATE TABLE `wp6w_amelia_notifications_log` (
  `id` int NOT NULL,
  `notificationId` int NOT NULL,
  `userId` int DEFAULT NULL,
  `appointmentId` int DEFAULT NULL,
  `eventId` int DEFAULT NULL,
  `packageCustomerId` int DEFAULT NULL,
  `sentDateTime` datetime NOT NULL,
  `sent` tinyint(1) DEFAULT NULL,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_notifications_sms_history`
--

DROP TABLE IF EXISTS `wp6w_amelia_notifications_sms_history`;
CREATE TABLE `wp6w_amelia_notifications_sms_history` (
  `id` int NOT NULL,
  `notificationId` int NOT NULL,
  `userId` int DEFAULT NULL,
  `appointmentId` int DEFAULT NULL,
  `eventId` int DEFAULT NULL,
  `packageCustomerId` int DEFAULT NULL,
  `logId` int DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL,
  `text` varchar(1600) NOT NULL,
  `phone` varchar(63) NOT NULL,
  `alphaSenderId` varchar(11) NOT NULL,
  `status` enum('prepared','accepted','queued','sent','failed','delivered','undelivered') NOT NULL DEFAULT 'prepared',
  `price` double DEFAULT NULL,
  `segments` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_notifications_to_entities`
--

DROP TABLE IF EXISTS `wp6w_amelia_notifications_to_entities`;
CREATE TABLE `wp6w_amelia_notifications_to_entities` (
  `id` int NOT NULL,
  `notificationId` int NOT NULL,
  `entityId` int NOT NULL,
  `entity` enum('appointment','event') NOT NULL DEFAULT 'appointment'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_no_show_customers`
--

DROP TABLE IF EXISTS `wp6w_amelia_no_show_customers`;
CREATE TABLE `wp6w_amelia_no_show_customers` (
  `id` int NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `appointment_date` datetime NOT NULL,
  `cancellation_date` datetime NOT NULL,
  `package_id` int DEFAULT NULL,
  `package_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_no_show_history`
--

DROP TABLE IF EXISTS `wp6w_amelia_no_show_history`;
CREATE TABLE `wp6w_amelia_no_show_history` (
  `id` int NOT NULL,
  `customerId` int NOT NULL,
  `firstName` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `lastName` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `total_no_shows` int NOT NULL,
  `total_penalty` decimal(10,2) NOT NULL,
  `date_paid` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_no_show_penalties`
--

DROP TABLE IF EXISTS `wp6w_amelia_no_show_penalties`;
CREATE TABLE `wp6w_amelia_no_show_penalties` (
  `id` int NOT NULL,
  `customerId` int NOT NULL,
  `total_no_shows` int NOT NULL DEFAULT '0',
  `total_penalty` decimal(10,2) NOT NULL DEFAULT '0.00',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_packages`
--

DROP TABLE IF EXISTS `wp6w_amelia_packages`;
CREATE TABLE `wp6w_amelia_packages` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext,
  `color` varchar(255) NOT NULL DEFAULT '',
  `price` double NOT NULL,
  `status` enum('hidden','visible','disabled') NOT NULL DEFAULT 'visible',
  `pictureFullPath` varchar(767) DEFAULT NULL,
  `pictureThumbPath` varchar(767) DEFAULT NULL,
  `position` int DEFAULT '0',
  `calculatedPrice` tinyint(1) DEFAULT '1',
  `discount` double NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `durationType` enum('day','week','month') DEFAULT NULL,
  `durationCount` int DEFAULT NULL,
  `settings` mediumtext,
  `translations` text,
  `depositPayment` enum('disabled','fixed','percentage') DEFAULT 'disabled',
  `deposit` double DEFAULT '0',
  `fullPayment` tinyint(1) DEFAULT '0',
  `sharedCapacity` tinyint(1) DEFAULT '0',
  `quantity` int DEFAULT '1',
  `limitPerCustomer` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_packages_customers_to_services`
--

DROP TABLE IF EXISTS `wp6w_amelia_packages_customers_to_services`;
CREATE TABLE `wp6w_amelia_packages_customers_to_services` (
  `id` int NOT NULL,
  `packageCustomerId` int NOT NULL,
  `serviceId` int NOT NULL,
  `providerId` int DEFAULT NULL,
  `locationId` int DEFAULT NULL,
  `bookingsCount` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_packages_services_to_locations`
--

DROP TABLE IF EXISTS `wp6w_amelia_packages_services_to_locations`;
CREATE TABLE `wp6w_amelia_packages_services_to_locations` (
  `id` int NOT NULL,
  `packageServiceId` int NOT NULL,
  `locationId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_packages_services_to_providers`
--

DROP TABLE IF EXISTS `wp6w_amelia_packages_services_to_providers`;
CREATE TABLE `wp6w_amelia_packages_services_to_providers` (
  `id` int NOT NULL,
  `packageServiceId` int NOT NULL,
  `userId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_packages_to_customers`
--

DROP TABLE IF EXISTS `wp6w_amelia_packages_to_customers`;
CREATE TABLE `wp6w_amelia_packages_to_customers` (
  `id` int NOT NULL,
  `packageId` int NOT NULL,
  `customerId` int NOT NULL,
  `price` double NOT NULL,
  `tax` varchar(255) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `purchased` datetime NOT NULL,
  `status` enum('approved','pending','canceled','rejected') DEFAULT NULL,
  `bookingsCount` int DEFAULT NULL,
  `couponId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Disparadores `wp6w_amelia_packages_to_customers`
--
DROP TRIGGER IF EXISTS `actualizar_anualidad_despues_de_compra`;
DELIMITER $$
CREATE TRIGGER `actualizar_anualidad_despues_de_compra` AFTER INSERT ON `wp6w_amelia_packages_to_customers` FOR EACH ROW BEGIN
    -- Verificar si el usuario compró un paquete de anualidad (1-9)
    IF NEW.packageId BETWEEN 1 AND 9 THEN
        INSERT INTO wp6w_amelia_annual_fee_control (customerId, firstName, lastName, email, status, created_at, expires_at)
        SELECT 
            u.id, u.firstName, u.lastName, u.email, 'paid', NOW(), DATE_ADD(NEW.purchased, INTERVAL 365 DAY)
        FROM wp6w_amelia_users u
        WHERE u.id = NEW.customerId
        ON DUPLICATE KEY UPDATE 
            status = 'paid',
            expires_at = DATE_ADD(NEW.purchased, INTERVAL 365 DAY);
    
    -- Si el usuario compró un paquete 24-33 Y NO tiene un paquete 1-9
    ELSEIF NEW.packageId IN (24, 25, 26, 27, 28, 30, 31, 32, 33) THEN
        IF NOT EXISTS (SELECT 1 FROM wp6w_amelia_packages_to_customers WHERE customerId = NEW.customerId AND packageId BETWEEN 1 AND 9) THEN
            INSERT INTO wp6w_amelia_annual_fee_control (customerId, firstName, lastName, email, status, created_at, expires_at)
            SELECT 
                u.id, u.firstName, u.lastName, u.email, 'pending', NOW(), NULL
            FROM wp6w_amelia_users u
            WHERE u.id = NEW.customerId
            ON DUPLICATE KEY UPDATE 
                status = 'pending',
                expires_at = NULL;
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_packages_to_services`
--

DROP TABLE IF EXISTS `wp6w_amelia_packages_to_services`;
CREATE TABLE `wp6w_amelia_packages_to_services` (
  `id` int NOT NULL,
  `serviceId` int NOT NULL,
  `packageId` int NOT NULL,
  `quantity` int NOT NULL,
  `minimumScheduled` int DEFAULT '1',
  `maximumScheduled` int DEFAULT '1',
  `allowProviderSelection` tinyint(1) DEFAULT '1',
  `position` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_payments`
--

DROP TABLE IF EXISTS `wp6w_amelia_payments`;
CREATE TABLE `wp6w_amelia_payments` (
  `id` int NOT NULL,
  `customerBookingId` int DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `dateTime` datetime DEFAULT NULL,
  `status` enum('paid','pending','partiallyPaid','refunded') NOT NULL,
  `gateway` enum('onSite','payPal','stripe','wc','mollie','razorpay','square') NOT NULL,
  `gatewayTitle` varchar(255) DEFAULT NULL,
  `data` text,
  `packageCustomerId` int DEFAULT NULL,
  `parentId` int DEFAULT NULL,
  `entity` enum('appointment','event','package') DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `actionsCompleted` tinyint(1) DEFAULT NULL,
  `triggeredActions` tinyint(1) DEFAULT NULL,
  `wcOrderId` bigint DEFAULT NULL,
  `wcOrderItemId` bigint DEFAULT NULL,
  `transactionId` varchar(255) DEFAULT NULL,
  `transfers` text,
  `invoiceNumber` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_resources`
--

DROP TABLE IF EXISTS `wp6w_amelia_resources`;
CREATE TABLE `wp6w_amelia_resources` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `quantity` int DEFAULT '1',
  `shared` enum('service','location') DEFAULT NULL,
  `status` enum('hidden','visible','disabled') NOT NULL DEFAULT 'visible',
  `countAdditionalPeople` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `wp6w_amelia_resources`
--

INSERT INTO `wp6w_amelia_resources` (`id`, `name`, `quantity`, `shared`, `status`, `countAdditionalPeople`) VALUES
(1, 'Salón de Barre', 1, 'service', 'visible', 0),
(2, 'Salón de Pilates', 1, 'service', 'visible', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_resources_to_entities`
--

DROP TABLE IF EXISTS `wp6w_amelia_resources_to_entities`;
CREATE TABLE `wp6w_amelia_resources_to_entities` (
  `id` int NOT NULL,
  `resourceId` int NOT NULL,
  `entityId` int NOT NULL,
  `entityType` enum('service','location','employee') NOT NULL DEFAULT 'service'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_services`
--

DROP TABLE IF EXISTS `wp6w_amelia_services`;
CREATE TABLE `wp6w_amelia_services` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext,
  `color` varchar(255) NOT NULL DEFAULT '',
  `price` double NOT NULL,
  `status` enum('hidden','visible','disabled') NOT NULL DEFAULT 'visible',
  `categoryId` int NOT NULL,
  `minCapacity` int NOT NULL,
  `maxCapacity` int NOT NULL,
  `duration` int NOT NULL,
  `timeBefore` int DEFAULT '0',
  `timeAfter` int DEFAULT '0',
  `bringingAnyone` tinyint(1) DEFAULT '1',
  `priority` enum('least_expensive','most_expensive','least_occupied','most_occupied') NOT NULL,
  `pictureFullPath` varchar(767) DEFAULT NULL,
  `pictureThumbPath` varchar(767) DEFAULT NULL,
  `position` int DEFAULT '0',
  `show` tinyint(1) DEFAULT '1',
  `aggregatedPrice` tinyint(1) DEFAULT '1',
  `settings` mediumtext,
  `recurringCycle` enum('disabled','all','daily','weekly','monthly') DEFAULT 'disabled',
  `recurringSub` enum('disabled','past','future','both') DEFAULT 'future',
  `recurringPayment` int DEFAULT '0',
  `translations` text,
  `depositPayment` enum('disabled','fixed','percentage') DEFAULT 'disabled',
  `depositPerPerson` tinyint(1) DEFAULT '1',
  `deposit` double DEFAULT '0',
  `fullPayment` tinyint(1) DEFAULT '0',
  `mandatoryExtra` tinyint(1) DEFAULT '0',
  `minSelectedExtras` int DEFAULT '0',
  `customPricing` text,
  `maxExtraPeople` int DEFAULT NULL,
  `limitPerCustomer` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_taxes`
--

DROP TABLE IF EXISTS `wp6w_amelia_taxes`;
CREATE TABLE `wp6w_amelia_taxes` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `amount` double NOT NULL,
  `type` enum('percentage','fixed') NOT NULL,
  `status` enum('hidden','visible') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_taxes_to_entities`
--

DROP TABLE IF EXISTS `wp6w_amelia_taxes_to_entities`;
CREATE TABLE `wp6w_amelia_taxes_to_entities` (
  `id` int NOT NULL,
  `taxId` int NOT NULL,
  `entityId` int NOT NULL,
  `entityType` enum('service','extra','event','package') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp6w_amelia_users`
--

DROP TABLE IF EXISTS `wp6w_amelia_users`;
CREATE TABLE `wp6w_amelia_users` (
  `id` int NOT NULL,
  `status` enum('hidden','visible','disabled','blocked') NOT NULL DEFAULT 'visible',
  `type` enum('customer','provider','manager','admin') NOT NULL,
  `externalId` bigint DEFAULT NULL,
  `firstName` varchar(255) NOT NULL DEFAULT '',
  `lastName` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` varchar(63) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `note` text,
  `description` text,
  `pictureFullPath` varchar(767) DEFAULT NULL,
  `pictureThumbPath` varchar(767) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `usedTokens` text,
  `zoomUserId` varchar(255) DEFAULT NULL,
  `stripeConnect` varchar(255) DEFAULT NULL,
  `countryPhoneIso` varchar(2) DEFAULT NULL,
  `translations` text,
  `timeZone` varchar(255) DEFAULT NULL,
  `badgeId` int DEFAULT NULL,
  `error` mediumtext,
  `appleCalendarId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `wp6w_amelia_annual_fee_control`
--
ALTER TABLE `wp6w_amelia_annual_fee_control`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customerId` (`customerId`);

--
-- Indices de la tabla `wp6w_amelia_appointments`
--
ALTER TABLE `wp6w_amelia_appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_cache`
--
ALTER TABLE `wp6w_amelia_cache`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_categories`
--
ALTER TABLE `wp6w_amelia_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_coupons`
--
ALTER TABLE `wp6w_amelia_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_coupons_to_events`
--
ALTER TABLE `wp6w_amelia_coupons_to_events`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_coupons_to_packages`
--
ALTER TABLE `wp6w_amelia_coupons_to_packages`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_coupons_to_services`
--
ALTER TABLE `wp6w_amelia_coupons_to_services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_customer_bookings`
--
ALTER TABLE `wp6w_amelia_customer_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_customer_bookings_to_events_periods`
--
ALTER TABLE `wp6w_amelia_customer_bookings_to_events_periods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bookingEventPeriod` (`customerBookingId`,`eventPeriodId`);

--
-- Indices de la tabla `wp6w_amelia_customer_bookings_to_events_tickets`
--
ALTER TABLE `wp6w_amelia_customer_bookings_to_events_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_customer_bookings_to_extras`
--
ALTER TABLE `wp6w_amelia_customer_bookings_to_extras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bookingExtra` (`customerBookingId`,`extraId`);

--
-- Indices de la tabla `wp6w_amelia_custom_fields`
--
ALTER TABLE `wp6w_amelia_custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_custom_fields_events`
--
ALTER TABLE `wp6w_amelia_custom_fields_events`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_custom_fields_options`
--
ALTER TABLE `wp6w_amelia_custom_fields_options`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_custom_fields_services`
--
ALTER TABLE `wp6w_amelia_custom_fields_services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_events`
--
ALTER TABLE `wp6w_amelia_events`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_events_periods`
--
ALTER TABLE `wp6w_amelia_events_periods`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_events_tags`
--
ALTER TABLE `wp6w_amelia_events_tags`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_events_to_providers`
--
ALTER TABLE `wp6w_amelia_events_to_providers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_events_to_tickets`
--
ALTER TABLE `wp6w_amelia_events_to_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_extras`
--
ALTER TABLE `wp6w_amelia_extras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_galleries`
--
ALTER TABLE `wp6w_amelia_galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_locations`
--
ALTER TABLE `wp6w_amelia_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_locations_views`
--
ALTER TABLE `wp6w_amelia_locations_views`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `wp6w_amelia_notifications`
--
ALTER TABLE `wp6w_amelia_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_notifications_log`
--
ALTER TABLE `wp6w_amelia_notifications_log`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_notifications_sms_history`
--
ALTER TABLE `wp6w_amelia_notifications_sms_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `wp6w_amelia_notifications_to_entities`
--
ALTER TABLE `wp6w_amelia_notifications_to_entities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_no_show_customers`
--
ALTER TABLE `wp6w_amelia_no_show_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_no_show_history`
--
ALTER TABLE `wp6w_amelia_no_show_history`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_no_show_penalties`
--
ALTER TABLE `wp6w_amelia_no_show_penalties`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_packages`
--
ALTER TABLE `wp6w_amelia_packages`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_packages_customers_to_services`
--
ALTER TABLE `wp6w_amelia_packages_customers_to_services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_packages_services_to_locations`
--
ALTER TABLE `wp6w_amelia_packages_services_to_locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `wp6w_amelia_packages_services_to_providers`
--
ALTER TABLE `wp6w_amelia_packages_services_to_providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `wp6w_amelia_packages_to_customers`
--
ALTER TABLE `wp6w_amelia_packages_to_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_packages_to_services`
--
ALTER TABLE `wp6w_amelia_packages_to_services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_payments`
--
ALTER TABLE `wp6w_amelia_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_resources`
--
ALTER TABLE `wp6w_amelia_resources`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_resources_to_entities`
--
ALTER TABLE `wp6w_amelia_resources_to_entities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_services`
--
ALTER TABLE `wp6w_amelia_services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_taxes`
--
ALTER TABLE `wp6w_amelia_taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_taxes_to_entities`
--
ALTER TABLE `wp6w_amelia_taxes_to_entities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wp6w_amelia_users`
--
ALTER TABLE `wp6w_amelia_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_annual_fee_control`
--
ALTER TABLE `wp6w_amelia_annual_fee_control`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_appointments`
--
ALTER TABLE `wp6w_amelia_appointments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_cache`
--
ALTER TABLE `wp6w_amelia_cache`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_categories`
--
ALTER TABLE `wp6w_amelia_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_coupons`
--
ALTER TABLE `wp6w_amelia_coupons`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_coupons_to_events`
--
ALTER TABLE `wp6w_amelia_coupons_to_events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_coupons_to_packages`
--
ALTER TABLE `wp6w_amelia_coupons_to_packages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_coupons_to_services`
--
ALTER TABLE `wp6w_amelia_coupons_to_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_customer_bookings`
--
ALTER TABLE `wp6w_amelia_customer_bookings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_customer_bookings_to_events_periods`
--
ALTER TABLE `wp6w_amelia_customer_bookings_to_events_periods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_customer_bookings_to_events_tickets`
--
ALTER TABLE `wp6w_amelia_customer_bookings_to_events_tickets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_customer_bookings_to_extras`
--
ALTER TABLE `wp6w_amelia_customer_bookings_to_extras`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_custom_fields`
--
ALTER TABLE `wp6w_amelia_custom_fields`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_custom_fields_events`
--
ALTER TABLE `wp6w_amelia_custom_fields_events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_custom_fields_options`
--
ALTER TABLE `wp6w_amelia_custom_fields_options`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_custom_fields_services`
--
ALTER TABLE `wp6w_amelia_custom_fields_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_events`
--
ALTER TABLE `wp6w_amelia_events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_events_periods`
--
ALTER TABLE `wp6w_amelia_events_periods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_events_tags`
--
ALTER TABLE `wp6w_amelia_events_tags`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_events_to_providers`
--
ALTER TABLE `wp6w_amelia_events_to_providers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_events_to_tickets`
--
ALTER TABLE `wp6w_amelia_events_to_tickets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_extras`
--
ALTER TABLE `wp6w_amelia_extras`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_galleries`
--
ALTER TABLE `wp6w_amelia_galleries`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_locations`
--
ALTER TABLE `wp6w_amelia_locations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_locations_views`
--
ALTER TABLE `wp6w_amelia_locations_views`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_notifications`
--
ALTER TABLE `wp6w_amelia_notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_notifications_log`
--
ALTER TABLE `wp6w_amelia_notifications_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_notifications_sms_history`
--
ALTER TABLE `wp6w_amelia_notifications_sms_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_notifications_to_entities`
--
ALTER TABLE `wp6w_amelia_notifications_to_entities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_no_show_customers`
--
ALTER TABLE `wp6w_amelia_no_show_customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_no_show_history`
--
ALTER TABLE `wp6w_amelia_no_show_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_no_show_penalties`
--
ALTER TABLE `wp6w_amelia_no_show_penalties`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_packages`
--
ALTER TABLE `wp6w_amelia_packages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_packages_customers_to_services`
--
ALTER TABLE `wp6w_amelia_packages_customers_to_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_packages_services_to_locations`
--
ALTER TABLE `wp6w_amelia_packages_services_to_locations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_packages_services_to_providers`
--
ALTER TABLE `wp6w_amelia_packages_services_to_providers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_packages_to_customers`
--
ALTER TABLE `wp6w_amelia_packages_to_customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_packages_to_services`
--
ALTER TABLE `wp6w_amelia_packages_to_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_payments`
--
ALTER TABLE `wp6w_amelia_payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_resources`
--
ALTER TABLE `wp6w_amelia_resources`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_resources_to_entities`
--
ALTER TABLE `wp6w_amelia_resources_to_entities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_services`
--
ALTER TABLE `wp6w_amelia_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_taxes`
--
ALTER TABLE `wp6w_amelia_taxes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_taxes_to_entities`
--
ALTER TABLE `wp6w_amelia_taxes_to_entities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp6w_amelia_users`
--
ALTER TABLE `wp6w_amelia_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `wp6w_amelia_annual_fee_control`
--
ALTER TABLE `wp6w_amelia_annual_fee_control`
  ADD CONSTRAINT `wp6w_amelia_annual_fee_control_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `wp6w_amelia_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
