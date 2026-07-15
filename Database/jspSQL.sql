/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.25 : Database - streetfood
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`streetfood` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `streetfood`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `admin` */

insert  into `admin`(`id`,`email`,`password`) values 
(1,'admin@gmail.com','12345');

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add contact',7,'add_contact'),
(26,'Can change contact',7,'change_contact'),
(27,'Can delete contact',7,'delete_contact'),
(28,'Can view contact',7,'view_contact'),
(29,'Can add customer',8,'add_customer'),
(30,'Can change customer',8,'change_customer'),
(31,'Can delete customer',8,'delete_customer'),
(32,'Can view customer',8,'view_customer'),
(33,'Can add merchant',9,'add_merchant'),
(34,'Can change merchant',9,'change_merchant'),
(35,'Can delete merchant',9,'delete_merchant'),
(36,'Can view merchant',9,'view_merchant'),
(37,'Can add foodcourt',10,'add_foodcourt'),
(38,'Can change foodcourt',10,'change_foodcourt'),
(39,'Can delete foodcourt',10,'delete_foodcourt'),
(40,'Can view foodcourt',10,'view_foodcourt'),
(41,'Can add addcart',11,'add_addcart'),
(42,'Can change addcart',11,'change_addcart'),
(43,'Can delete addcart',11,'delete_addcart'),
(44,'Can view addcart',11,'view_addcart'),
(45,'Can add feedback',12,'add_feedback'),
(46,'Can change feedback',12,'change_feedback'),
(47,'Can delete feedback',12,'delete_feedback'),
(48,'Can view feedback',12,'view_feedback'),
(49,'Can add admin',13,'add_admin'),
(50,'Can change admin',13,'change_admin'),
(51,'Can delete admin',13,'delete_admin'),
(52,'Can view admin',13,'view_admin');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$320000$6Y0soZBYoC6rq94w6w5dmf$+T8aFN7X/sgLbMJP9uwedtlSPOo5g2aAddT7e5ODZ+Q=','2023-09-28 07:46:02.149296',1,'admin','','','admin@gmail.com',1,1,'2023-09-28 07:45:00.391682');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `booking_food` */

DROP TABLE IF EXISTS `booking_food`;

CREATE TABLE `booking_food` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cart` varchar(100) NOT NULL,
  `cost` bigint NOT NULL,
  `discount` bigint NOT NULL,
  `finalcost` bigint NOT NULL,
  `add` varchar(100) NOT NULL,
  `customer_id` bigint NOT NULL,
  `food_id` bigint NOT NULL,
  `stutuss` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_food_customer_id_5a14bc67_fk_Customer_table_id` (`customer_id`),
  KEY `booking_food_food_id_73332971_fk_food_details_id` (`food_id`),
  CONSTRAINT `booking_food_customer_id_5a14bc67_fk_Customer_table_id` FOREIGN KEY (`customer_id`) REFERENCES `customer_table` (`id`),
  CONSTRAINT `booking_food_food_id_73332971_fk_food_details_id` FOREIGN KEY (`food_id`) REFERENCES `food_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `booking_food` */

insert  into `booking_food`(`id`,`cart`,`cost`,`discount`,`finalcost`,`add`,`customer_id`,`food_id`,`stutuss`) values 
(1,'2',140,20,260,'Hyderabad',1,1,3),
(2,'1',140,20,120,'Hyderabad',2,1,3),
(3,'1',140,20,120,'Hyderabad',2,1,2),
(4,'1',140,20,120,'Hyderabad',2,1,1),
(5,'1',140,20,120,'Hyderabad',2,1,2),
(6,'1',140,20,120,'Hyderabad',1,1,4),
(7,'1',140,20,120,'Hyderabad',2,1,3),
(8,'1',140,20,120,'Hyderabad',1,1,3);

/*Table structure for table `contact_table` */

DROP TABLE IF EXISTS `contact_table`;

CREATE TABLE `contact_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `contactemail` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `msg` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `contact_table` */

insert  into `contact_table`(`id`,`name`,`contactemail`,`subject`,`msg`) values 
(1,'basha','basha@gmail.com','basha','basha');

/*Table structure for table `customer_table` */

DROP TABLE IF EXISTS `customer_table`;

CREATE TABLE `customer_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `mobile` bigint NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `customer_table` */

insert  into `customer_table`(`id`,`fullname`,`mobile`,`city`,`email`,`password`,`address`) values 
(1,'abcd',1234567888,'Hyderabad','abcd@gmail.com','12345','Hyderabad'),
(2,'gg',1234567890,'Hyd','gg@gmail.com','12345','gg');

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session'),
(11,'streetfoodapp','addcart'),
(13,'streetfoodapp','admin'),
(7,'streetfoodapp','contact'),
(8,'streetfoodapp','customer'),
(12,'streetfoodapp','feedback'),
(10,'streetfoodapp','foodcourt'),
(9,'streetfoodapp','merchant');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-09-28 05:19:35.587848'),
(2,'auth','0001_initial','2023-09-28 05:19:36.827006'),
(3,'admin','0001_initial','2023-09-28 05:19:37.097849'),
(4,'admin','0002_logentry_remove_auto_add','2023-09-28 05:19:37.115739'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-09-28 05:19:37.131786'),
(6,'contenttypes','0002_remove_content_type_name','2023-09-28 05:19:37.366479'),
(7,'auth','0002_alter_permission_name_max_length','2023-09-28 05:19:37.465735'),
(8,'auth','0003_alter_user_email_max_length','2023-09-28 05:19:37.566776'),
(9,'auth','0004_alter_user_username_opts','2023-09-28 05:19:37.582579'),
(10,'auth','0005_alter_user_last_login_null','2023-09-28 05:19:37.658125'),
(11,'auth','0006_require_contenttypes_0002','2023-09-28 05:19:37.662964'),
(12,'auth','0007_alter_validators_add_error_messages','2023-09-28 05:19:37.669457'),
(13,'auth','0008_alter_user_username_max_length','2023-09-28 05:19:37.767548'),
(14,'auth','0009_alter_user_last_name_max_length','2023-09-28 05:19:37.915485'),
(15,'auth','0010_alter_group_name_max_length','2023-09-28 05:19:37.969586'),
(16,'auth','0011_update_proxy_permissions','2023-09-28 05:19:37.990435'),
(17,'auth','0012_alter_user_first_name_max_length','2023-09-28 05:19:38.151150'),
(18,'sessions','0001_initial','2023-09-28 05:19:38.297642'),
(19,'streetfoodapp','0001_initial','2023-09-28 05:19:38.345337'),
(20,'streetfoodapp','0002_customer','2023-09-28 05:19:38.388423'),
(21,'streetfoodapp','0003_merchant','2023-09-28 05:19:38.430372'),
(22,'streetfoodapp','0004_foodcourt','2023-09-28 05:19:38.475874'),
(23,'streetfoodapp','0005_foodcourt_merchant','2023-09-28 05:19:38.614021'),
(24,'streetfoodapp','0006_auto_20220407_1834','2023-09-28 05:19:38.786627'),
(25,'streetfoodapp','0007_foodcourt_type','2023-09-28 05:19:38.839666'),
(26,'streetfoodapp','0008_addcart','2023-09-28 05:19:39.081776'),
(27,'streetfoodapp','0009_addcart_add','2023-09-28 05:19:39.137376'),
(28,'streetfoodapp','0010_addcart_customer','2023-09-28 05:19:39.257153'),
(29,'streetfoodapp','0011_remove_addcart_hotel','2023-09-28 05:19:39.367332'),
(30,'streetfoodapp','0012_addcart_merchant','2023-09-28 05:19:39.578429'),
(31,'streetfoodapp','0013_remove_addcart_merchant','2023-09-28 05:19:39.704798'),
(32,'streetfoodapp','0014_remove_addcart_food','2023-09-28 05:19:39.814370'),
(33,'streetfoodapp','0015_addcart_food','2023-09-28 05:19:39.944325'),
(34,'streetfoodapp','0016_remove_addcart_food','2023-09-28 05:19:40.062639'),
(35,'streetfoodapp','0017_addcart_foods','2023-09-28 05:19:40.193020'),
(36,'streetfoodapp','0018_rename_foods_addcart_food','2023-09-28 05:19:40.399405'),
(37,'streetfoodapp','0019_addcart_stutus','2023-09-28 05:19:40.568314'),
(38,'streetfoodapp','0020_remove_addcart_stutus','2023-09-28 05:19:40.696295'),
(39,'streetfoodapp','0021_addcart_stutuss','2023-09-28 05:19:40.750812'),
(40,'streetfoodapp','0022_feedback','2023-09-28 05:19:40.958478'),
(41,'streetfoodapp','0023_alter_merchant_img','2023-09-28 05:19:40.979305'),
(42,'streetfoodapp','0024_alter_foodcourt_image','2023-09-28 05:19:40.992007'),
(43,'streetfoodapp','0025_admin','2023-09-28 09:48:25.354255');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('3tzn1aqpy0l996nd6g2cwdkljsnhg7l3','eyJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSJ9:1qm8Vg:-ngY-kUJhioMvSY5UWs6pqt-zR2xAstPHZNnv0wA5o8','2023-10-13 08:06:04.244911');

/*Table structure for table `feedbacks` */

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL,
  `star` int NOT NULL,
  `customer_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_customer_id_a064ac85_fk_Customer_table_id` (`customer_id`),
  KEY `feedbacks_merchant_id_ca9fb84b_fk_merchant_table_id` (`merchant_id`),
  CONSTRAINT `feedbacks_customer_id_a064ac85_fk_Customer_table_id` FOREIGN KEY (`customer_id`) REFERENCES `customer_table` (`id`),
  CONSTRAINT `feedbacks_merchant_id_ca9fb84b_fk_merchant_table_id` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `feedbacks` */

insert  into `feedbacks`(`id`,`text`,`star`,`customer_id`,`merchant_id`) values 
(1,'Nice',4,1,1);

/*Table structure for table `food_details` */

DROP TABLE IF EXISTS `food_details`;

CREATE TABLE `food_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `foodname` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `cost` bigint NOT NULL,
  `discount` bigint NOT NULL,
  `description` longtext NOT NULL,
  `categoty` varchar(100) NOT NULL,
  `merchant_id` bigint NOT NULL,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `food_details_merchant_id_e594de64_fk_merchant_table_id` (`merchant_id`),
  CONSTRAINT `food_details_merchant_id_e594de64_fk_merchant_table_id` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `food_details` */

insert  into `food_details`(`id`,`foodname`,`image`,`cost`,`discount`,`description`,`categoty`,`merchant_id`,`type`) values 
(1,'Chicken','chicken_8f1jc3o.jpg',140,20,'Best Food','shawarma',1,'nonveg');

/*Table structure for table `merchant_table` */

DROP TABLE IF EXISTS `merchant_table`;

CREATE TABLE `merchant_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `mobile` bigint NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  `hotel` varchar(100) NOT NULL,
  `img` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `merchant_table` */

insert  into `merchant_table`(`id`,`fullname`,`mobile`,`city`,`email`,`password`,`address`,`hotel`,`img`) values 
(1,'Bahi',1234567890,'Hyderabad','abcd@gmail.com','12345','Hyderabad','Bhai','hotel1.jpg');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
