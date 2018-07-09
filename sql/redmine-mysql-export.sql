-- MySQL dump 10.15  Distrib 10.0.35-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: redmine
-- ------------------------------------------------------
-- Server version	10.0.35-MariaDB-1~xenial

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `redmine`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `redmine` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `redmine`;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `container_id` int(11) DEFAULT NULL,
  `container_type` varchar(30) DEFAULT NULL,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `disk_filename` varchar(255) NOT NULL DEFAULT '',
  `filesize` bigint(20) NOT NULL DEFAULT '0',
  `content_type` varchar(255) DEFAULT '',
  `digest` varchar(64) NOT NULL DEFAULT '',
  `downloads` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `disk_directory` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_attachments_on_author_id` (`author_id`),
  KEY `index_attachments_on_created_on` (`created_on`),
  KEY `index_attachments_on_container_id_and_container_type` (`container_id`,`container_type`),
  KEY `index_attachments_on_disk_filename` (`disk_filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_sources`
--

DROP TABLE IF EXISTS `auth_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `host` varchar(60) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `account_password` varchar(255) DEFAULT '',
  `base_dn` varchar(255) DEFAULT NULL,
  `attr_login` varchar(30) DEFAULT NULL,
  `attr_firstname` varchar(30) DEFAULT NULL,
  `attr_lastname` varchar(30) DEFAULT NULL,
  `attr_mail` varchar(30) DEFAULT NULL,
  `onthefly_register` tinyint(1) NOT NULL DEFAULT '0',
  `tls` tinyint(1) NOT NULL DEFAULT '0',
  `filter` text,
  `timeout` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_auth_sources_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_sources`
--

LOCK TABLES `auth_sources` WRITE;
/*!40000 ALTER TABLE `auth_sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `topics_count` int(11) NOT NULL DEFAULT '0',
  `messages_count` int(11) NOT NULL DEFAULT '0',
  `last_message_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boards_project_id` (`project_id`),
  KEY `index_boards_on_last_message_id` (`last_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boards`
--

LOCK TABLES `boards` WRITE;
/*!40000 ALTER TABLE `boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changes`
--

DROP TABLE IF EXISTS `changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `changeset_id` int(11) NOT NULL,
  `action` varchar(1) NOT NULL DEFAULT '',
  `path` text NOT NULL,
  `from_path` text,
  `from_revision` varchar(255) DEFAULT NULL,
  `revision` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changesets_changeset_id` (`changeset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changes`
--

LOCK TABLES `changes` WRITE;
/*!40000 ALTER TABLE `changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changeset_parents`
--

DROP TABLE IF EXISTS `changeset_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changeset_parents` (
  `changeset_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  KEY `changeset_parents_changeset_ids` (`changeset_id`),
  KEY `changeset_parents_parent_ids` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changeset_parents`
--

LOCK TABLES `changeset_parents` WRITE;
/*!40000 ALTER TABLE `changeset_parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `changeset_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changesets`
--

DROP TABLE IF EXISTS `changesets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changesets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repository_id` int(11) NOT NULL,
  `revision` varchar(255) NOT NULL,
  `committer` varchar(255) DEFAULT NULL,
  `committed_on` datetime NOT NULL,
  `comments` longtext,
  `commit_date` date DEFAULT NULL,
  `scmid` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `changesets_repos_rev` (`repository_id`,`revision`),
  KEY `index_changesets_on_user_id` (`user_id`),
  KEY `index_changesets_on_repository_id` (`repository_id`),
  KEY `index_changesets_on_committed_on` (`committed_on`),
  KEY `changesets_repos_scmid` (`repository_id`,`scmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changesets`
--

LOCK TABLES `changesets` WRITE;
/*!40000 ALTER TABLE `changesets` DISABLE KEYS */;
/*!40000 ALTER TABLE `changesets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changesets_issues`
--

DROP TABLE IF EXISTS `changesets_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changesets_issues` (
  `changeset_id` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  UNIQUE KEY `changesets_issues_ids` (`changeset_id`,`issue_id`),
  KEY `index_changesets_issues_on_issue_id` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changesets_issues`
--

LOCK TABLES `changesets_issues` WRITE;
/*!40000 ALTER TABLE `changesets_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `changesets_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commented_type` varchar(30) NOT NULL DEFAULT '',
  `commented_id` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL DEFAULT '0',
  `comments` text,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comments_on_commented_id_and_commented_type` (`commented_id`,`commented_type`),
  KEY `index_comments_on_author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_field_enumerations`
--

DROP TABLE IF EXISTS `custom_field_enumerations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_field_enumerations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `position` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_field_enumerations`
--

LOCK TABLES `custom_field_enumerations` WRITE;
/*!40000 ALTER TABLE `custom_field_enumerations` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_field_enumerations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(30) NOT NULL DEFAULT '',
  `field_format` varchar(30) NOT NULL DEFAULT '',
  `possible_values` text,
  `regexp` varchar(255) DEFAULT '',
  `min_length` int(11) DEFAULT NULL,
  `max_length` int(11) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_for_all` tinyint(1) NOT NULL DEFAULT '0',
  `is_filter` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `searchable` tinyint(1) DEFAULT '0',
  `default_value` text,
  `editable` tinyint(1) DEFAULT '1',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `multiple` tinyint(1) DEFAULT '0',
  `format_store` text,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `index_custom_fields_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields`
--

LOCK TABLES `custom_fields` WRITE;
/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields_projects`
--

DROP TABLE IF EXISTS `custom_fields_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields_projects` (
  `custom_field_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_custom_fields_projects_on_custom_field_id_and_project_id` (`custom_field_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields_projects`
--

LOCK TABLES `custom_fields_projects` WRITE;
/*!40000 ALTER TABLE `custom_fields_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields_roles`
--

DROP TABLE IF EXISTS `custom_fields_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields_roles` (
  `custom_field_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  UNIQUE KEY `custom_fields_roles_ids` (`custom_field_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields_roles`
--

LOCK TABLES `custom_fields_roles` WRITE;
/*!40000 ALTER TABLE `custom_fields_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields_trackers`
--

DROP TABLE IF EXISTS `custom_fields_trackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields_trackers` (
  `custom_field_id` int(11) NOT NULL DEFAULT '0',
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `index_custom_fields_trackers_on_custom_field_id_and_tracker_id` (`custom_field_id`,`tracker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields_trackers`
--

LOCK TABLES `custom_fields_trackers` WRITE;
/*!40000 ALTER TABLE `custom_fields_trackers` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_fields_trackers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_values`
--

DROP TABLE IF EXISTS `custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customized_type` varchar(30) NOT NULL DEFAULT '',
  `customized_id` int(11) NOT NULL DEFAULT '0',
  `custom_field_id` int(11) NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`id`),
  KEY `custom_values_customized` (`customized_type`,`customized_id`),
  KEY `index_custom_values_on_custom_field_id` (`custom_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_values`
--

LOCK TABLES `custom_values` WRITE;
/*!40000 ALTER TABLE `custom_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_project_id` (`project_id`),
  KEY `index_documents_on_category_id` (`category_id`),
  KEY `index_documents_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_addresses`
--

DROP TABLE IF EXISTS `email_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_email_addresses_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_addresses`
--

LOCK TABLES `email_addresses` WRITE;
/*!40000 ALTER TABLE `email_addresses` DISABLE KEYS */;
INSERT INTO `email_addresses` VALUES (1,1,'admin@example.net',1,1,'2018-06-25 00:27:04','2018-06-25 00:27:04'),(2,5,'automated-reminders@example.com',1,1,'2018-07-07 00:05:12','2018-07-07 00:05:12');
/*!40000 ALTER TABLE `email_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enabled_modules`
--

DROP TABLE IF EXISTS `enabled_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enabled_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enabled_modules_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enabled_modules`
--

LOCK TABLES `enabled_modules` WRITE;
/*!40000 ALTER TABLE `enabled_modules` DISABLE KEYS */;
INSERT INTO `enabled_modules` VALUES (1,1,'issue_tracking'),(2,1,'wiki'),(3,2,'issue_tracking'),(4,3,'issue_tracking'),(5,4,'issue_tracking'),(6,5,'issue_tracking');
/*!40000 ALTER TABLE `enabled_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enumerations`
--

DROP TABLE IF EXISTS `enumerations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enumerations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `position` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `project_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `position_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_enumerations_on_project_id` (`project_id`),
  KEY `index_enumerations_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enumerations`
--

LOCK TABLES `enumerations` WRITE;
/*!40000 ALTER TABLE `enumerations` DISABLE KEYS */;
INSERT INTO `enumerations` VALUES (1,'Low',1,0,'IssuePriority',1,NULL,NULL,'lowest'),(2,'Normal',2,1,'IssuePriority',1,NULL,NULL,'default'),(3,'High',3,0,'IssuePriority',1,NULL,NULL,'high3'),(4,'Urgent',4,0,'IssuePriority',1,NULL,NULL,'high2'),(5,'Immediate',5,0,'IssuePriority',1,NULL,NULL,'highest'),(6,'User documentation',1,0,'DocumentCategory',1,NULL,NULL,NULL),(7,'Technical documentation',2,0,'DocumentCategory',1,NULL,NULL,NULL),(8,'Design',1,0,'TimeEntryActivity',1,NULL,NULL,NULL),(9,'Development',2,0,'TimeEntryActivity',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `enumerations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_users`
--

DROP TABLE IF EXISTS `groups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_users` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  UNIQUE KEY `groups_users_ids` (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_users`
--

LOCK TABLES `groups_users` WRITE;
/*!40000 ALTER TABLE `groups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_items`
--

DROP TABLE IF EXISTS `import_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `import_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `obj_id` int(11) DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_items`
--

LOCK TABLES `import_items` WRITE;
/*!40000 ALTER TABLE `import_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `settings` text,
  `total_items` int(11) DEFAULT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_categories`
--

DROP TABLE IF EXISTS `issue_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(60) NOT NULL DEFAULT '',
  `assigned_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_categories_project_id` (`project_id`),
  KEY `index_issue_categories_on_assigned_to_id` (`assigned_to_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_categories`
--

LOCK TABLES `issue_categories` WRITE;
/*!40000 ALTER TABLE `issue_categories` DISABLE KEYS */;
INSERT INTO `issue_categories` VALUES (1,2,'Unassigned',1),(2,4,'Checks - Email',1),(3,4,'Checks - Storage',1),(4,4,'Cleanup/Sort',1),(5,3,'Patch',1),(6,5,'Air Filter',1),(7,5,'Bathroom',1),(8,5,'Bedroom',1),(9,5,'Cleaning',1),(10,5,'Fees',1),(11,5,'Kitchen',1),(12,5,'Pest Control',1),(13,5,'Pets',1),(14,5,'Purchasing',1),(15,5,'Vehicles',1),(16,5,'Yard',1);
/*!40000 ALTER TABLE `issue_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_relations`
--

DROP TABLE IF EXISTS `issue_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_from_id` int(11) NOT NULL,
  `issue_to_id` int(11) NOT NULL,
  `relation_type` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_issue_relations_on_issue_from_id_and_issue_to_id` (`issue_from_id`,`issue_to_id`),
  KEY `index_issue_relations_on_issue_from_id` (`issue_from_id`),
  KEY `index_issue_relations_on_issue_to_id` (`issue_to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_relations`
--

LOCK TABLES `issue_relations` WRITE;
/*!40000 ALTER TABLE `issue_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_statuses`
--

DROP TABLE IF EXISTS `issue_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `default_done_ratio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_issue_statuses_on_position` (`position`),
  KEY `index_issue_statuses_on_is_closed` (`is_closed`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_statuses`
--

LOCK TABLES `issue_statuses` WRITE;
/*!40000 ALTER TABLE `issue_statuses` DISABLE KEYS */;
INSERT INTO `issue_statuses` VALUES (1,'New',0,1,NULL),(2,'In Progress',0,2,NULL),(3,'Resolved',0,3,NULL),(4,'Feedback',0,4,NULL),(5,'Closed',1,5,NULL),(6,'Rejected',1,6,NULL);
/*!40000 ALTER TABLE `issue_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracker_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `description` longtext,
  `due_date` date DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `assigned_to_id` int(11) DEFAULT NULL,
  `priority_id` int(11) NOT NULL,
  `fixed_version_id` int(11) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `done_ratio` int(11) NOT NULL DEFAULT '0',
  `estimated_hours` float DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `root_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `closed_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issues_project_id` (`project_id`),
  KEY `index_issues_on_status_id` (`status_id`),
  KEY `index_issues_on_category_id` (`category_id`),
  KEY `index_issues_on_assigned_to_id` (`assigned_to_id`),
  KEY `index_issues_on_fixed_version_id` (`fixed_version_id`),
  KEY `index_issues_on_tracker_id` (`tracker_id`),
  KEY `index_issues_on_priority_id` (`priority_id`),
  KEY `index_issues_on_author_id` (`author_id`),
  KEY `index_issues_on_created_on` (`created_on`),
  KEY `index_issues_on_root_id_and_lft_and_rgt` (`root_id`,`lft`,`rgt`),
  KEY `index_issues_on_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,3,2,'Test email number 2','Testing against literal \'automated-tickets\' bare alias',NULL,1,1,1,2,NULL,4,0,'2018-07-06 22:17:56','2018-07-06 22:17:56','2018-07-06',0,NULL,NULL,1,1,2,0,NULL),(2,3,2,'Test email number 3','Testing against literal \'automated-tickets-mysql@localhost alias\'',NULL,1,1,1,2,NULL,4,0,'2018-07-06 22:17:56','2018-07-06 22:17:56','2018-07-06',0,NULL,NULL,2,1,2,0,NULL),(3,3,2,'Test email number 1','Testing against literal \'automated-tickets@localhost alias\'',NULL,1,1,1,2,NULL,4,0,'2018-07-06 22:17:57','2018-07-06 22:17:57','2018-07-06',0,NULL,NULL,3,1,2,0,NULL),(4,3,2,'Test email number 4','Testing against literal \'automated-tickets-mysql\' bare alias',NULL,1,1,1,2,NULL,4,0,'2018-07-06 22:17:57','2018-07-06 22:17:57','2018-07-06',0,NULL,NULL,4,1,2,0,NULL);
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_details`
--

DROP TABLE IF EXISTS `journal_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(30) NOT NULL DEFAULT '',
  `prop_key` varchar(30) NOT NULL DEFAULT '',
  `old_value` longtext,
  `value` longtext,
  PRIMARY KEY (`id`),
  KEY `journal_details_journal_id` (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_details`
--

LOCK TABLES `journal_details` WRITE;
/*!40000 ALTER TABLE `journal_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalized_id` int(11) NOT NULL DEFAULT '0',
  `journalized_type` varchar(30) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `notes` longtext,
  `created_on` datetime NOT NULL,
  `private_notes` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `journals_journalized_id` (`journalized_id`,`journalized_type`),
  KEY `index_journals_on_user_id` (`user_id`),
  KEY `index_journals_on_journalized_id` (`journalized_id`),
  KEY `index_journals_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_roles`
--

DROP TABLE IF EXISTS `member_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `inherited_from` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_member_roles_on_member_id` (`member_id`),
  KEY `index_member_roles_on_role_id` (`role_id`),
  KEY `index_member_roles_on_inherited_from` (`inherited_from`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_roles`
--

LOCK TABLES `member_roles` WRITE;
/*!40000 ALTER TABLE `member_roles` DISABLE KEYS */;
INSERT INTO `member_roles` VALUES (1,1,3,NULL),(2,2,3,NULL),(3,3,5,NULL),(4,4,5,NULL),(5,5,3,NULL),(6,6,5,NULL),(7,7,3,NULL);
/*!40000 ALTER TABLE `member_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `mail_notification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_members_on_user_id_and_project_id` (`user_id`,`project_id`),
  KEY `index_members_on_user_id` (`user_id`),
  KEY `index_members_on_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,1,2,'2018-07-06 00:11:02',0),(2,1,4,'2018-07-06 23:45:12',0),(3,5,4,'2018-07-07 00:05:27',0),(4,5,3,'2018-07-07 00:05:27',0),(5,1,3,'2018-07-07 00:13:36',0),(6,5,5,'2018-07-07 21:45:42',0),(7,1,5,'2018-07-07 21:45:50',0);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `author_id` int(11) DEFAULT NULL,
  `replies_count` int(11) NOT NULL DEFAULT '0',
  `last_reply_id` int(11) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `sticky` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `messages_board_id` (`board_id`),
  KEY `messages_parent_id` (`parent_id`),
  KEY `index_messages_on_last_reply_id` (`last_reply_id`),
  KEY `index_messages_on_author_id` (`author_id`),
  KEY `index_messages_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `title` varchar(60) NOT NULL DEFAULT '',
  `summary` varchar(255) DEFAULT '',
  `description` text,
  `author_id` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `comments_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `news_project_id` (`project_id`),
  KEY `index_news_on_author_id` (`author_id`),
  KEY `index_news_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_id_authentication_associations`
--

DROP TABLE IF EXISTS `open_id_authentication_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_id_authentication_associations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issued` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `assoc_type` varchar(255) DEFAULT NULL,
  `server_url` blob,
  `secret` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_id_authentication_associations`
--

LOCK TABLES `open_id_authentication_associations` WRITE;
/*!40000 ALTER TABLE `open_id_authentication_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `open_id_authentication_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_id_authentication_nonces`
--

DROP TABLE IF EXISTS `open_id_authentication_nonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_id_authentication_nonces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL,
  `server_url` varchar(255) DEFAULT NULL,
  `salt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_id_authentication_nonces`
--

LOCK TABLES `open_id_authentication_nonces` WRITE;
/*!40000 ALTER TABLE `open_id_authentication_nonces` DISABLE KEYS */;
/*!40000 ALTER TABLE `open_id_authentication_nonces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `homepage` varchar(255) DEFAULT '',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `inherit_members` tinyint(1) NOT NULL DEFAULT '0',
  `default_version_id` int(11) DEFAULT NULL,
  `default_assigned_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_projects_on_lft` (`lft`),
  KEY `index_projects_on_rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Documentation','Demo project to hold wiki pages for:\r\n\r\n* https://github.com/WhyAskWhy/automated-tickets\r\n* https://github.com/WhyAskWhy/automated-tickets-dev\r\n','',1,NULL,'2018-06-25 00:35:42','2018-07-06 23:47:02','docs',1,3,4,0,NULL,NULL),(2,'Unassigned','','',1,NULL,'2018-07-06 00:10:50','2018-07-07 22:02:14','unassigned',1,9,10,0,NULL,NULL),(3,'Server Support','','',1,NULL,'2018-07-06 23:43:56','2018-07-06 23:43:56','server-support',1,7,8,0,NULL,NULL),(4,'Desktop Support','','',1,NULL,'2018-07-06 23:44:24','2018-07-06 23:44:24','desktop-support',1,1,2,0,NULL,NULL),(5,'Home','Target project for \"Home\" tasks. \r\n\r\nTasks for this project are intended to be in contrast to those set within an enterprise/educational environment (e.g, project:desktop-support and project:server-support).','',1,NULL,'2018-07-07 21:45:10','2018-07-07 21:45:10','home',1,5,6,0,NULL,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_trackers`
--

DROP TABLE IF EXISTS `projects_trackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_trackers` (
  `project_id` int(11) NOT NULL DEFAULT '0',
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `projects_trackers_unique` (`project_id`,`tracker_id`),
  KEY `projects_trackers_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_trackers`
--

LOCK TABLES `projects_trackers` WRITE;
/*!40000 ALTER TABLE `projects_trackers` DISABLE KEYS */;
INSERT INTO `projects_trackers` VALUES (1,1),(1,2),(1,3),(2,3),(3,1),(3,2),(3,3),(4,1),(4,2),(4,3),(5,1),(5,2),(5,3);
/*!40000 ALTER TABLE `projects_trackers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queries`
--

DROP TABLE IF EXISTS `queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `filters` text,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `column_names` text,
  `sort_criteria` text,
  `group_by` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `visibility` int(11) DEFAULT '0',
  `options` text,
  PRIMARY KEY (`id`),
  KEY `index_queries_on_project_id` (`project_id`),
  KEY `index_queries_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queries`
--

LOCK TABLES `queries` WRITE;
/*!40000 ALTER TABLE `queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queries_roles`
--

DROP TABLE IF EXISTS `queries_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queries_roles` (
  `query_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  UNIQUE KEY `queries_roles_ids` (`query_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queries_roles`
--

LOCK TABLES `queries_roles` WRITE;
/*!40000 ALTER TABLE `queries_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `queries_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repositories`
--

DROP TABLE IF EXISTS `repositories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repositories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `login` varchar(60) DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `root_url` varchar(255) DEFAULT '',
  `type` varchar(255) DEFAULT NULL,
  `path_encoding` varchar(64) DEFAULT NULL,
  `log_encoding` varchar(64) DEFAULT NULL,
  `extra_info` longtext,
  `identifier` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_repositories_on_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repositories`
--

LOCK TABLES `repositories` WRITE;
/*!40000 ALTER TABLE `repositories` DISABLE KEYS */;
/*!40000 ALTER TABLE `repositories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `position` int(11) DEFAULT NULL,
  `assignable` tinyint(1) DEFAULT '1',
  `builtin` int(11) NOT NULL DEFAULT '0',
  `permissions` text,
  `issues_visibility` varchar(30) NOT NULL DEFAULT 'default',
  `users_visibility` varchar(30) NOT NULL DEFAULT 'all',
  `time_entries_visibility` varchar(30) NOT NULL DEFAULT 'all',
  `all_roles_managed` tinyint(1) NOT NULL DEFAULT '1',
  `settings` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Non member',0,1,1,'---\n- :view_issues\n- :add_issues\n- :add_issue_notes\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :view_time_entries\n- :view_news\n- :comment_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :view_messages\n- :add_messages\n- :view_files\n- :browse_repository\n- :view_changesets\n','default','all','all',1,NULL),(2,'Anonymous',0,1,2,'---\n- :view_issues\n- :view_gantt\n- :view_calendar\n- :view_time_entries\n- :view_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :view_messages\n- :view_files\n- :browse_repository\n- :view_changesets\n','default','all','all',1,NULL),(3,'Manager',1,1,0,'---\n- :add_project\n- :edit_project\n- :close_project\n- :select_project_modules\n- :manage_members\n- :manage_versions\n- :add_subprojects\n- :manage_public_queries\n- :save_queries\n- :view_issues\n- :add_issues\n- :edit_issues\n- :copy_issues\n- :manage_issue_relations\n- :manage_subtasks\n- :set_issues_private\n- :set_own_issues_private\n- :add_issue_notes\n- :edit_issue_notes\n- :edit_own_issue_notes\n- :view_private_notes\n- :set_notes_private\n- :delete_issues\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :import_issues\n- :manage_categories\n- :view_time_entries\n- :log_time\n- :edit_time_entries\n- :edit_own_time_entries\n- :manage_project_activities\n- :view_news\n- :manage_news\n- :comment_news\n- :view_documents\n- :add_documents\n- :edit_documents\n- :delete_documents\n- :view_files\n- :manage_files\n- :view_wiki_pages\n- :view_wiki_edits\n- :export_wiki_pages\n- :edit_wiki_pages\n- :rename_wiki_pages\n- :delete_wiki_pages\n- :delete_wiki_pages_attachments\n- :protect_wiki_pages\n- :manage_wiki\n- :view_changesets\n- :browse_repository\n- :commit_access\n- :manage_related_issues\n- :manage_repository\n- :view_messages\n- :add_messages\n- :edit_messages\n- :edit_own_messages\n- :delete_messages\n- :delete_own_messages\n- :manage_boards\n- :view_calendar\n- :view_gantt\n','all','all','all',1,NULL),(4,'Developer',2,1,0,'---\n- :manage_versions\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :view_private_notes\n- :set_notes_private\n- :manage_issue_relations\n- :manage_subtasks\n- :add_issue_notes\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :log_time\n- :view_time_entries\n- :view_news\n- :comment_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages\n- :view_messages\n- :add_messages\n- :edit_own_messages\n- :view_files\n- :manage_files\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_related_issues\n','default','all','all',1,NULL),(5,'Reporter',3,1,0,'---\n- :view_issues\n- :add_issues\n- :add_issue_notes\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :log_time\n- :view_time_entries\n- :view_news\n- :comment_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :view_messages\n- :add_messages\n- :edit_own_messages\n- :view_files\n- :browse_repository\n- :view_changesets\n','default','all','all',1,NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_managed_roles`
--

DROP TABLE IF EXISTS `roles_managed_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_managed_roles` (
  `role_id` int(11) NOT NULL,
  `managed_role_id` int(11) NOT NULL,
  UNIQUE KEY `index_roles_managed_roles_on_role_id_and_managed_role_id` (`role_id`,`managed_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_managed_roles`
--

LOCK TABLES `roles_managed_roles` WRITE;
/*!40000 ALTER TABLE `roles_managed_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_managed_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('1'),('10'),('100'),('101'),('102'),('103'),('104'),('105'),('106'),('107'),('108'),('11'),('12'),('13'),('14'),('15'),('16'),('17'),('18'),('19'),('2'),('20'),('20090214190337'),('20090312172426'),('20090312194159'),('20090318181151'),('20090323224724'),('20090401221305'),('20090401231134'),('20090403001910'),('20090406161854'),('20090425161243'),('20090503121501'),('20090503121505'),('20090503121510'),('20090614091200'),('20090704172350'),('20090704172355'),('20090704172358'),('20091010093521'),('20091017212227'),('20091017212457'),('20091017212644'),('20091017212938'),('20091017213027'),('20091017213113'),('20091017213151'),('20091017213228'),('20091017213257'),('20091017213332'),('20091017213444'),('20091017213536'),('20091017213642'),('20091017213716'),('20091017213757'),('20091017213835'),('20091017213910'),('20091017214015'),('20091017214107'),('20091017214136'),('20091017214236'),('20091017214308'),('20091017214336'),('20091017214406'),('20091017214440'),('20091017214519'),('20091017214611'),('20091017214644'),('20091017214720'),('20091017214750'),('20091025163651'),('20091108092559'),('20091114105931'),('20091123212029'),('20091205124427'),('20091220183509'),('20091220183727'),('20091220184736'),('20091225164732'),('20091227112908'),('20100129193402'),('20100129193813'),('20100221100219'),('20100313132032'),('20100313171051'),('20100705164950'),('20100819172912'),('20101104182107'),('20101107130441'),('20101114115114'),('20101114115359'),('20110220160626'),('20110223180944'),('20110223180953'),('20110224000000'),('20110226120112'),('20110226120132'),('20110227125750'),('20110228000000'),('20110228000100'),('20110401192910'),('20110408103312'),('20110412065600'),('20110511000000'),('20110902000000'),('20111201201315'),('20120115143024'),('20120115143100'),('20120115143126'),('20120127174243'),('20120205111326'),('20120223110929'),('20120301153455'),('20120422150750'),('20120705074331'),('20120707064544'),('20120714122000'),('20120714122100'),('20120714122200'),('20120731164049'),('20120930112914'),('20121026002032'),('20121026003537'),('20121209123234'),('20121209123358'),('20121213084931'),('20130110122628'),('20130201184705'),('20130202090625'),('20130207175206'),('20130207181455'),('20130215073721'),('20130215111127'),('20130215111141'),('20130217094251'),('20130602092539'),('20130710182539'),('20130713104233'),('20130713111657'),('20130729070143'),('20130911193200'),('20131004113137'),('20131005100610'),('20131124175346'),('20131210180802'),('20131214094309'),('20131215104612'),('20131218183023'),('20140228130325'),('20140903143914'),('20140920094058'),('20141029181752'),('20141029181824'),('20141109112308'),('20141122124142'),('20150113194759'),('20150113211532'),('20150113213922'),('20150113213955'),('20150208105930'),('20150510083747'),('20150525103953'),('20150526183158'),('20150528084820'),('20150528092912'),('20150528093249'),('20150725112753'),('20150730122707'),('20150730122735'),('20150921204850'),('20150921210243'),('20151020182334'),('20151020182731'),('20151021184614'),('20151021185456'),('20151021190616'),('20151024082034'),('20151025072118'),('20151031095005'),('20160404080304'),('20160416072926'),('20160529063352'),('20161001122012'),('20161002133421'),('20161010081301'),('20161010081528'),('20161010081600'),('20161126094932'),('20161220091118'),('20170207050700'),('20170302015225'),('20170309214320'),('20170320051650'),('20170418090031'),('20170419144536'),('21'),('22'),('23'),('24'),('25'),('26'),('27'),('28'),('29'),('3'),('30'),('31'),('32'),('33'),('34'),('35'),('36'),('37'),('38'),('39'),('4'),('40'),('41'),('42'),('43'),('44'),('45'),('46'),('47'),('48'),('49'),('5'),('50'),('51'),('52'),('53'),('54'),('55'),('56'),('57'),('58'),('59'),('6'),('60'),('61'),('62'),('63'),('64'),('65'),('66'),('67'),('68'),('69'),('7'),('70'),('71'),('72'),('73'),('74'),('75'),('76'),('77'),('78'),('79'),('8'),('80'),('81'),('82'),('83'),('84'),('85'),('86'),('87'),('88'),('89'),('9'),('90'),('91'),('92'),('93'),('94'),('95'),('96'),('97'),('98'),('99');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_settings_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'app_title','Automated Tickets Development: MySQL','2018-07-06 00:11:44'),(2,'welcome_text','Demo/Test environment for the Automated Tickets project.\r\n\r\nSee these repos for additional info:\r\n\r\n* https://github.com/WhyAskWhy/automated-tickets\r\n* https://github.com/WhyAskWhy/automated-tickets-dev','2018-07-06 17:46:53'),(3,'per_page_options','25,50,100','2018-07-06 00:11:44'),(4,'search_results_per_page','10','2018-07-06 00:11:44'),(5,'activity_days_default','30','2018-07-06 00:11:44'),(6,'host_name','localhost:3000','2018-07-06 00:11:44'),(7,'protocol','http','2018-07-06 00:11:44'),(8,'text_formatting','textile','2018-07-06 00:11:44'),(9,'cache_formatted_text','0','2018-07-06 00:11:44'),(10,'wiki_compression','','2018-07-06 00:11:44'),(11,'feeds_limit','15','2018-07-06 00:11:44'),(12,'mail_handler_body_delimiters','','2018-07-06 00:12:01'),(13,'mail_handler_enable_regex_delimiters','0','2018-07-06 00:12:01'),(14,'mail_handler_excluded_filenames','','2018-07-06 00:12:01'),(15,'mail_handler_api_enabled','1','2018-07-06 00:12:01'),(16,'mail_handler_api_key','5QZFfhLOs7SPc0wMgBrY','2018-07-06 00:12:01'),(17,'login_required','0','2018-07-06 17:43:30'),(18,'autologin','0','2018-07-06 17:43:30'),(19,'self_registration','2','2018-07-06 17:43:30'),(20,'show_custom_fields_on_registration','1','2018-07-06 17:43:30'),(21,'unsubscribe','0','2018-07-06 17:43:30'),(22,'password_min_length','5','2018-07-06 17:43:30'),(23,'password_max_age','0','2018-07-06 17:43:30'),(24,'lost_password','0','2018-07-06 17:43:30'),(25,'max_additional_emails','5','2018-07-06 17:43:30'),(26,'openid','0','2018-07-06 17:43:30'),(27,'session_lifetime','0','2018-07-06 17:43:30'),(28,'session_timeout','0','2018-07-06 17:43:30'),(29,'default_users_hide_mail','1','2018-07-06 17:43:30'),(30,'default_users_time_zone','','2018-07-06 17:43:30'),(31,'cross_project_issue_relations','1','2018-07-06 17:47:48'),(32,'link_copied_issue','ask','2018-07-06 17:47:48'),(33,'cross_project_subtasks','tree','2018-07-06 17:47:48'),(34,'issue_group_assignment','1','2018-07-06 17:47:48'),(35,'default_issue_start_date_to_creation_date','1','2018-07-06 17:47:48'),(36,'display_subprojects_issues','1','2018-07-06 17:47:48'),(37,'issue_done_ratio','issue_field','2018-07-06 17:47:48'),(38,'non_working_week_days','---\n- \'6\'\n- \'7\'\n','2018-07-06 17:47:48'),(39,'issues_export_limit','500','2018-07-06 17:47:48'),(40,'gantt_items_limit','500','2018-07-06 17:47:48'),(41,'parent_issue_dates','derived','2018-07-06 17:47:48'),(42,'parent_issue_priority','derived','2018-07-06 17:47:48'),(43,'parent_issue_done_ratio','derived','2018-07-06 17:47:48'),(44,'issue_list_default_columns','---\n- tracker\n- status\n- priority\n- subject\n- assigned_to\n- updated_on\n','2018-07-06 17:47:48'),(45,'issue_list_default_totals','--- []\n','2018-07-06 17:47:48'),(46,'default_projects_public','1','2018-07-07 22:02:46'),(47,'default_projects_modules','---\n- issue_tracking\n','2018-07-07 22:02:46'),(48,'default_projects_tracker_ids','---\n- \'1\'\n- \'2\'\n- \'3\'\n','2018-07-07 22:02:46'),(49,'sequential_project_identifiers','0','2018-07-07 22:02:46');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_entries`
--

DROP TABLE IF EXISTS `time_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `hours` float NOT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `activity_id` int(11) NOT NULL,
  `spent_on` date NOT NULL,
  `tyear` int(11) NOT NULL,
  `tmonth` int(11) NOT NULL,
  `tweek` int(11) NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time_entries_project_id` (`project_id`),
  KEY `time_entries_issue_id` (`issue_id`),
  KEY `index_time_entries_on_activity_id` (`activity_id`),
  KEY `index_time_entries_on_user_id` (`user_id`),
  KEY `index_time_entries_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_entries`
--

LOCK TABLES `time_entries` WRITE;
/*!40000 ALTER TABLE `time_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `action` varchar(30) NOT NULL DEFAULT '',
  `value` varchar(40) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_value` (`value`),
  KEY `index_tokens_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (3,1,'feeds','ae8529e5bc5c462170967c50c992fe5a7999b6a3','2018-06-25 00:34:35','2018-06-25 00:34:35');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trackers`
--

DROP TABLE IF EXISTS `trackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `is_in_chlog` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `is_in_roadmap` tinyint(1) NOT NULL DEFAULT '1',
  `fields_bits` int(11) DEFAULT '0',
  `default_status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackers`
--

LOCK TABLES `trackers` WRITE;
/*!40000 ALTER TABLE `trackers` DISABLE KEYS */;
INSERT INTO `trackers` VALUES (1,'Bug',1,1,0,0,1),(2,'Feature',1,2,1,0,1),(3,'Support',0,3,0,0,1);
/*!40000 ALTER TABLE `trackers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `others` text,
  `hide_mail` tinyint(1) DEFAULT '1',
  `time_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_preferences_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` VALUES (1,1,'---\n:no_self_notified: true\n:my_page_layout:\n  left:\n  - issuesassignedtome\n  right:\n  - issuesreportedbyme\n:my_page_settings: {}\n',1,''),(2,5,'---\n:no_self_notified: \'1\'\n:comments_sorting: asc\n:warn_on_leaving_unsaved: \'1\'\n:textarea_font: \'\'\n:my_page_layout:\n  left:\n  - issuesassignedtome\n  right:\n  - issuesreportedbyme\n:my_page_settings: {}\n',1,'');
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL DEFAULT '',
  `hashed_password` varchar(40) NOT NULL DEFAULT '',
  `firstname` varchar(30) NOT NULL DEFAULT '',
  `lastname` varchar(255) NOT NULL DEFAULT '',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `last_login_on` datetime DEFAULT NULL,
  `language` varchar(5) DEFAULT '',
  `auth_source_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `identity_url` varchar(255) DEFAULT NULL,
  `mail_notification` varchar(255) NOT NULL DEFAULT '',
  `salt` varchar(64) DEFAULT NULL,
  `must_change_passwd` tinyint(1) NOT NULL DEFAULT '0',
  `passwd_changed_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_id_and_type` (`id`,`type`),
  KEY `index_users_on_auth_source_id` (`auth_source_id`),
  KEY `index_users_on_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','b5a27e6276bb99e3d58ec04af96091188f879833','Redmine','Admin',1,1,'2018-07-07 21:42:45','',NULL,'2018-06-25 00:27:01','2018-07-06 17:44:04','User',NULL,'all','cd9270b463604cdb7df93cc33622a06d',0,'2018-07-06 17:44:04'),(2,'','','','Anonymous users',0,1,NULL,'',NULL,'2018-06-25 00:27:04','2018-06-25 00:27:04','GroupAnonymous',NULL,'',NULL,0,NULL),(3,'','','','Non member users',0,1,NULL,'',NULL,'2018-06-25 00:27:04','2018-06-25 00:27:04','GroupNonMember',NULL,'',NULL,0,NULL),(4,'','','','Anonymous',0,0,NULL,'',NULL,'2018-06-25 00:30:36','2018-06-25 00:30:36','AnonymousUser',NULL,'only_my_events',NULL,0,NULL),(5,'automated-reminders','7994d2cbf15cfb8924df3535da21b65efbdaec0b','Automated','Reminders',0,1,NULL,'en',NULL,'2018-07-07 00:05:12','2018-07-07 00:05:12','User',NULL,'none','b161074aa805a3bb67327c59f36766b6',0,'2018-07-07 00:05:12');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `effective_date` date DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `wiki_page_title` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'open',
  `sharing` varchar(255) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  KEY `versions_project_id` (`project_id`),
  KEY `index_versions_on_sharing` (`sharing`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchers`
--

DROP TABLE IF EXISTS `watchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `watchable_type` varchar(255) NOT NULL DEFAULT '',
  `watchable_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `watchers_user_id_type` (`user_id`,`watchable_type`),
  KEY `index_watchers_on_user_id` (`user_id`),
  KEY `index_watchers_on_watchable_id_and_watchable_type` (`watchable_id`,`watchable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchers`
--

LOCK TABLES `watchers` WRITE;
/*!40000 ALTER TABLE `watchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_content_versions`
--

DROP TABLE IF EXISTS `wiki_content_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_content_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wiki_content_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `data` longblob,
  `compression` varchar(6) DEFAULT '',
  `comments` varchar(1024) DEFAULT '',
  `updated_on` datetime NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_content_versions_wcid` (`wiki_content_id`),
  KEY `index_wiki_content_versions_on_updated_on` (`updated_on`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_content_versions`
--

LOCK TABLES `wiki_content_versions` WRITE;
/*!40000 ALTER TABLE `wiki_content_versions` DISABLE KEYS */;
INSERT INTO `wiki_content_versions` VALUES (1,1,1,1,'h1. Wiki\r\n\r\n{{child_pages}}\r\n','','Add child_pages macro','2018-06-25 00:36:04',1),(2,2,2,1,'h1. Include pages\r\n\r\nParent page to root include pages from.\r\n\r\n{{child_pages}}\r\n','','Stub page','2018-07-06 22:29:50',1),(3,3,3,1,'{{>toc}}\r\n\r\nh1. AutomatedTickets\r\n\r\nh2. Overview\r\n\r\nBelow are the wiki pages that are sourced/included by various scripts that we use to generate \"automated tickets\". Most of those are generated by the @automated_tickets.py@ script that runs on the server hosting this site, but some scripts run on other boxes and make include references to one or more of these pages. This is done to provide a consistent set of instructions for anyone who processes those tickets.\r\n\r\nSee these pages for more information:\r\n\r\n* [[docs:Automated_Tickets]]\r\n\r\nh2. Automated Ticket include pages\r\n\r\n{{child_pages}}\r\n\r\n','','Rough draft','2018-07-06 22:31:56',1),(4,3,3,1,'{{>toc}}\r\n\r\nh1. AutomatedTickets\r\n\r\nh2. Overview\r\n\r\nBelow are the wiki pages that are sourced/included by various scripts that we use to generate \"automated tickets\". Most of those are generated by the @automated_tickets.py@ script that runs on the server hosting this site, but some scripts run on other boxes and make include references to one or more of these pages. This is done to provide a consistent set of instructions for anyone who processes those tickets.\r\n\r\n\r\nh2. Automated Ticket include pages\r\n\r\n{{child_pages}}\r\n\r\n','','Remove unused page ref','2018-07-06 22:39:38',2),(5,4,4,1,'---\r\n\r\nYou can close this ticket by responding to this email with @Status: Closed@ all on a line by itself. This works best by including a short status update to note why you\'re closing it.','','Create footer for inclusion by all AutomatedTickets include pages','2018-07-06 22:56:23',1),(6,5,5,1,'# Clean fridge coils\r\n# Vacuum loose matter and clean brush\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','First draft','2018-07-06 22:59:43',1),(7,6,6,1,'Check these supplies and update the order list:\r\n\r\n* Litter\r\n* Baking soda\r\n* Food\r\n\r\nWhile doing this, glance at their food and water levels (separate ticket, but a good habit regardless).\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:01:19',1),(8,7,7,1,'All vehicles:\r\n\r\n# Vacuum\r\n# Remove debris\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:03:06',1),(9,8,8,1,'Check tire pressure on all vehicles and add pressure as needed.\r\n\r\n|_.Vehicle|_.Pressure|\r\n|Car|FILL THIS IN|\r\n|Van|FILL THIS IN|\r\n|Truck|FILL THIS IN|\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:06:38',1),(10,9,9,1,'* Clean windows in all vehicles.\r\n* Make sure there is a clean cleaning cloth in glove box (to be used for wiping inside glass while traveling).\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:07:50',1),(11,10,10,1,'It is time to swap toothbrushes and check our stock. If low, we need to add a new package to the order list.\r\n\r\nNote: Even if there is still life left on the existing brushes, it is suggested to go ahead and replace now to keep the schedule consistent.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:09:05',1),(12,11,11,1,'# First, check the Google Calendar entry to see what specific date the filter should be replaced\r\n#* _this script is currently limited in its scheduling functionality; every X weeks is problematic_\r\n# Update the due date for this ticket to reflect that specific date\r\n# Retrieve a spare filter first (it wouldn\'t be good to remove the old one before making sure there _is_ a new one)\r\n# Rinse out the filter canister\r\n# Insert new filter\r\n# Run water for five minutes at medium pressure\r\n# Taste test\r\n# Double-check current stock, add to order list if low\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','','Create initial page','2018-07-06 23:10:10',1),(13,12,12,1,'# Review inventory\r\n# Add items to lunchbox for work\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:11:09',1),(14,13,13,1,'The wet food is a treat, but the main purpose is as a carrier for the cranberry powder. This is intended as a treatment for their bladders to help prevent repeat kidney infections.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:11:52',1),(15,14,14,1,'Clean front and back porches.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:12:36',1),(16,15,15,1,'Supplies used:\r\n\r\n* mop handle\r\n** _used to push leaves out of gutter_\r\n* cable ties\r\n** _for securing mop handle_\r\n* gloves\r\n* S hook\r\n** _for holding mop handle from top of ladder_\r\n* ladder\r\n* pole saw\r\n** _used to scrape leaves off of front roof, need something better_\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:13:22',1),(17,16,16,1,'# Remove random containers\r\n# Remove old food\r\n# Review stock\r\n# Clean shelves to remove spilled food matter\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:14:14',1),(18,17,17,1,'# Brush the vent cover\r\n# Vacuum the vent cover\r\n# Vacuum floor where debris fell\r\n# Vacuum fan itself\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:14:55',1),(19,18,18,1,'# Check work supplies\r\n# Update inventory\r\n# Post items to this ticket to bring with me on Monday\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','','Create initial page','2018-07-06 23:17:58',1),(20,19,19,1,'In addition to making sure it is at least half full, this is a good time to check the quantity of unopened cat food we have on hand.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:18:49',1),(21,20,20,1,'Swap out bowls.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','','Create initial page','2018-07-06 23:19:27',1),(22,21,21,1,'Prep spare pan first, dump old pan and wash for use at next scheduled swap.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:20:11',1),(23,22,22,1,'Replace or clean pre and main air filter.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:20:55',1),(24,23,23,1,'Replace or clean pre and main air filter.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:21:40',1),(25,24,24,1,'Replace or clean pre and main air filter.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','','Create initial page','2018-07-06 23:22:24',1),(26,25,25,1,'Replace or clean central air filter. If using a disposable filter, mark the current date that you\'re installing the new filter. Bonus points: add related ticket number as *@see #1234@*.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:23:10',1),(27,26,26,1,'# Add one tablet to tray behind central air filter\r\n# Examine tray for breaks or leaks\r\n# Examine surrounding areas for discoloration\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:24:04',1),(28,27,27,1,'Wash sheets used in the kids bedroom.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:25:01',1),(29,28,28,1,'Replace all sinus rinse bottles with spares in the cabinet.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:25:41',1),(30,29,29,1,'Pay the water bill. This is usually done by initiating a bank payment?\r\n\r\nNote: This should trigger on the first of the month with a due date 9 days later.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','','Create initial page','2018-07-06 23:26:22',1),(31,30,30,1,'Pay the van note. This is currently done by initiating a payment through example.com. This may eventually be changed to an automatic payment.\r\n\r\nNote: This should trigger on the first of the month with a due date 4 days later.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','','Create initial page','2018-07-06 23:27:24',1),(32,31,31,1,'Tasks:\r\n\r\n* Pollen filters\r\n** Inspect, clean\r\n** Replace every six months (April, October)\r\n** *Last replaced*: *April 2018*\r\n\r\n* Ultra-fine filters\r\n** inspect\r\n** replace monthly\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n\r\n* Wiki template: [[docs:AutomatedTicketsAirFilterCPAP]]\r\n* Replacement filters: https://www.amazon.com/gp/product/B01N3SRZ76/','','Create initial page','2018-07-06 23:28:57',1),(33,32,32,1,'# Clean prefilter\r\n# Clean main air filter.\r\n# Check due date for replacing filters\r\n\r\n|_.Item|_.Last Replaced|_.Next Replacement|_.Notes|\r\n|Germguardian Filter E|2018-03-12|between Sept 12-Nov 12|Replace every 6-8 months|\r\n\r\n\r\nUpdate the template above by modifying the [[docs:AutomatedTicketsAirFilterMaintenanceMasterBedroom]] page.\r\n\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','','Create initial page','2018-07-06 23:29:51',1),(34,33,33,1,'h2. Overview\r\n\r\nWe occasionally have semi-sensitive paperwork that needs to be shredded before recycling. This paperwork is collected in a box within the student worker cubicle area. This box will need to be processed as indicated on this page. This box usually sits on the cabinet to the right of the entryway.\r\n\r\nh2. Frequency\r\n\r\nAt least once a week.\r\n\r\nh2. Processing instructions\r\n\r\n# locate box\r\n# locate shredder (loading dock-immediately when entering loading dock it is located to the left against wall beside garbage can-it is tan)\r\n# turn the shredder on (power button red switch on the side and then press forward button)\r\n# shred documents *be sure to remove staples and paper clips from documents--caution (be sure to keep hands clear of shredding area)\r\n# when shredding complete, be sure to power off the machine\r\n# return box to designated location in student worker cubicle.','','Create initial page','2018-07-06 23:35:30',1),(35,34,34,1,'h2. Background\r\n\r\nCurrently we have a 4 month dry-erase calendar on the outside of a cubicle wall when you enter our area. This calendar is primarily used to note leave, conferences and holidays.\r\n\r\nh2. Tasks\r\n\r\n# Remove the previous month\r\n# Include the current month\r\n# Include the following three months\r\n','','Create initial page','2018-07-06 23:38:03',1),(36,35,35,1,'h1. Work Area Cleanup\r\n\r\nh2. About\r\n\r\nPeriodically, our work areas need to be cleaned up. This includes, but is not limited to, cables, open computers, spare parts, recyclable materials, trash, etc. \r\n\r\nh2. Where\r\n\r\nWork areas we\'re responsible for include:\r\n\r\n* The back room\r\n* Walkways between cubicles\r\n* Student worker workspace\r\n* Storage cabinets\r\n* Shelving\r\n* Systems Conference room\r\n* Any other area used for storage or misc work\r\n\r\nh2. Frequency\r\n\r\nAt least once a week, or when you see that things are not where they\'re supposed to be. We want our work areas to be reasonably clean at all times.\r\n\r\nh2. Processing instructions\r\n\r\n* Gather any loose power, video or extension cables, paper, and hard drives and place in the appropriate cabinets.\r\n* Place full surplus carts in the Graveyard and process as necessary.\r\n* Place optical media back in the binder, and place the binder on a shelf in the work area.\r\n* Organize and place supplies like tape, rubber bands and bread ties in a consistent location within the work area.\r\n* Remove extra carts from our dept and place in the tech services hallway. Please be sure to place them out of the immediate walkway. It\'s ok to keep one or two carts around, particularly if there is a job coming up.\r\n* Any computers or printers around the back room should be put into its proper location','','Create initial page','2018-07-06 23:49:26',1),(37,36,36,1,'{{include(sysdocs:Work_Area_Cleanup)}}','','Create initial page','2018-07-06 23:49:52',1),(38,36,36,1,'{{include(docs:Work_Area_Cleanup)}}','','Fix project ref','2018-07-06 23:50:16',2),(39,1,1,1,'h1. Wiki\r\n\r\nSee the [[docs:IncludePages]] page (and subpages) for content used by the \"Automated Tickets project\":https://github.com/WhyAskWhy/automated-tickets.\r\n\r\n{{child_pages}}\r\n','','Add references to Automated Tickets project, include pages','2018-07-06 23:52:54',2),(40,1,1,1,'h1. Wiki\r\n\r\nThe [[docs:IncludePages]] page, subpages and any pages linked below are sourced (directly or indirectly) by the \"Automated Tickets project\":https://github.com/WhyAskWhy/automated-tickets.\r\n\r\n{{child_pages(docs:IncludePages)}}\r\n\r\n{{child_pages}}\r\n','','Enable auto-indexed listing for IncludePages child pages','2018-07-06 23:54:57',3),(41,37,37,1,'Please pickup and deliver mail for our dept.\r\n\r\n*Note:* Please mark the ticket as \"follow up\" if you have checked the mail but are not ready to close the ticket yet.\r\n\r\n<redpre style=\"white-space: pre-line; border-style: solid; border-width: medium; background-color: white; border-color: black; display:block; padding: 1em;\">\r\nBecause mail is often delivered later in the day, it is best to make a final late afternoon check for mail before closing this ticket.\r\n</redpre>','','Create initial page','2018-07-06 23:58:19',1),(42,38,38,1,'Please pickup more paper boxes from the Admin office if we have fewer than 8 boxes.','','Create initial page','2018-07-07 00:00:05',1),(43,39,39,1,'Automatic Updates have been disabled for this box due to various issues with dependent services not handling auto-restart gracefully.\r\n\r\nSee these pages for directions:\r\n\r\n* placeholder1\r\n* placeholder2\r\n* placeholder3','','Create initial page','2018-07-07 00:09:04',1);
/*!40000 ALTER TABLE `wiki_content_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_contents`
--

DROP TABLE IF EXISTS `wiki_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `text` longtext,
  `comments` varchar(1024) DEFAULT '',
  `updated_on` datetime NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_contents_page_id` (`page_id`),
  KEY `index_wiki_contents_on_author_id` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_contents`
--

LOCK TABLES `wiki_contents` WRITE;
/*!40000 ALTER TABLE `wiki_contents` DISABLE KEYS */;
INSERT INTO `wiki_contents` VALUES (1,1,1,'h1. Wiki\r\n\r\nThe [[docs:IncludePages]] page, subpages and any pages linked below are sourced (directly or indirectly) by the \"Automated Tickets project\":https://github.com/WhyAskWhy/automated-tickets.\r\n\r\n{{child_pages(docs:IncludePages)}}\r\n\r\n{{child_pages}}\r\n','Enable auto-indexed listing for IncludePages child pages','2018-07-06 23:54:57',3),(2,2,1,'h1. Include pages\r\n\r\nParent page to root include pages from.\r\n\r\n{{child_pages}}\r\n','Stub page','2018-07-06 22:29:50',1),(3,3,1,'{{>toc}}\r\n\r\nh1. AutomatedTickets\r\n\r\nh2. Overview\r\n\r\nBelow are the wiki pages that are sourced/included by various scripts that we use to generate \"automated tickets\". Most of those are generated by the @automated_tickets.py@ script that runs on the server hosting this site, but some scripts run on other boxes and make include references to one or more of these pages. This is done to provide a consistent set of instructions for anyone who processes those tickets.\r\n\r\n\r\nh2. Automated Ticket include pages\r\n\r\n{{child_pages}}\r\n\r\n','Remove unused page ref','2018-07-06 22:39:38',2),(4,4,1,'---\r\n\r\nYou can close this ticket by responding to this email with @Status: Closed@ all on a line by itself. This works best by including a short status update to note why you\'re closing it.','Create footer for inclusion by all AutomatedTickets include pages','2018-07-06 22:56:23',1),(5,5,1,'# Clean fridge coils\r\n# Vacuum loose matter and clean brush\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','First draft','2018-07-06 22:59:43',1),(6,6,1,'Check these supplies and update the order list:\r\n\r\n* Litter\r\n* Baking soda\r\n* Food\r\n\r\nWhile doing this, glance at their food and water levels (separate ticket, but a good habit regardless).\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:01:19',1),(7,7,1,'All vehicles:\r\n\r\n# Vacuum\r\n# Remove debris\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:03:06',1),(8,8,1,'Check tire pressure on all vehicles and add pressure as needed.\r\n\r\n|_.Vehicle|_.Pressure|\r\n|Car|FILL THIS IN|\r\n|Van|FILL THIS IN|\r\n|Truck|FILL THIS IN|\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:06:38',1),(9,9,1,'* Clean windows in all vehicles.\r\n* Make sure there is a clean cleaning cloth in glove box (to be used for wiping inside glass while traveling).\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:07:50',1),(10,10,1,'It is time to swap toothbrushes and check our stock. If low, we need to add a new package to the order list.\r\n\r\nNote: Even if there is still life left on the existing brushes, it is suggested to go ahead and replace now to keep the schedule consistent.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:09:05',1),(11,11,1,'# First, check the Google Calendar entry to see what specific date the filter should be replaced\r\n#* _this script is currently limited in its scheduling functionality; every X weeks is problematic_\r\n# Update the due date for this ticket to reflect that specific date\r\n# Retrieve a spare filter first (it wouldn\'t be good to remove the old one before making sure there _is_ a new one)\r\n# Rinse out the filter canister\r\n# Insert new filter\r\n# Run water for five minutes at medium pressure\r\n# Taste test\r\n# Double-check current stock, add to order list if low\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','Create initial page','2018-07-06 23:10:10',1),(12,12,1,'# Review inventory\r\n# Add items to lunchbox for work\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:11:09',1),(13,13,1,'The wet food is a treat, but the main purpose is as a carrier for the cranberry powder. This is intended as a treatment for their bladders to help prevent repeat kidney infections.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:11:52',1),(14,14,1,'Clean front and back porches.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:12:36',1),(15,15,1,'Supplies used:\r\n\r\n* mop handle\r\n** _used to push leaves out of gutter_\r\n* cable ties\r\n** _for securing mop handle_\r\n* gloves\r\n* S hook\r\n** _for holding mop handle from top of ladder_\r\n* ladder\r\n* pole saw\r\n** _used to scrape leaves off of front roof, need something better_\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:13:22',1),(16,16,1,'# Remove random containers\r\n# Remove old food\r\n# Review stock\r\n# Clean shelves to remove spilled food matter\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:14:14',1),(17,17,1,'# Brush the vent cover\r\n# Vacuum the vent cover\r\n# Vacuum floor where debris fell\r\n# Vacuum fan itself\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:14:55',1),(18,18,1,'# Check work supplies\r\n# Update inventory\r\n# Post items to this ticket to bring with me on Monday\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','Create initial page','2018-07-06 23:17:58',1),(19,19,1,'In addition to making sure it is at least half full, this is a good time to check the quantity of unopened cat food we have on hand.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:18:49',1),(20,20,1,'Swap out bowls.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','Create initial page','2018-07-06 23:19:27',1),(21,21,1,'Prep spare pan first, dump old pan and wash for use at next scheduled swap.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:20:11',1),(22,22,1,'Replace or clean pre and main air filter.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:20:55',1),(23,23,1,'Replace or clean pre and main air filter.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:21:40',1),(24,24,1,'Replace or clean pre and main air filter.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','Create initial page','2018-07-06 23:22:24',1),(25,25,1,'Replace or clean central air filter. If using a disposable filter, mark the current date that you\'re installing the new filter. Bonus points: add related ticket number as *@see #1234@*.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:23:10',1),(26,26,1,'# Add one tablet to tray behind central air filter\r\n# Examine tray for breaks or leaks\r\n# Examine surrounding areas for discoloration\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:24:04',1),(27,27,1,'Wash sheets used in the kids bedroom.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:25:01',1),(28,28,1,'Replace all sinus rinse bottles with spares in the cabinet.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:25:41',1),(29,29,1,'Pay the water bill. This is usually done by initiating a bank payment?\r\n\r\nNote: This should trigger on the first of the month with a due date 9 days later.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}','Create initial page','2018-07-06 23:26:22',1),(30,30,1,'Pay the van note. This is currently done by initiating a payment through example.com. This may eventually be changed to an automatic payment.\r\n\r\nNote: This should trigger on the first of the month with a due date 4 days later.\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','Create initial page','2018-07-06 23:27:24',1),(31,31,1,'Tasks:\r\n\r\n* Pollen filters\r\n** Inspect, clean\r\n** Replace every six months (April, October)\r\n** *Last replaced*: *April 2018*\r\n\r\n* Ultra-fine filters\r\n** inspect\r\n** replace monthly\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n\r\n* Wiki template: [[docs:AutomatedTicketsAirFilterCPAP]]\r\n* Replacement filters: https://www.amazon.com/gp/product/B01N3SRZ76/','Create initial page','2018-07-06 23:28:57',1),(32,32,1,'# Clean prefilter\r\n# Clean main air filter.\r\n# Check due date for replacing filters\r\n\r\n|_.Item|_.Last Replaced|_.Next Replacement|_.Notes|\r\n|Germguardian Filter E|2018-03-12|between Sept 12-Nov 12|Replace every 6-8 months|\r\n\r\n\r\nUpdate the template above by modifying the [[docs:AutomatedTicketsAirFilterMaintenanceMasterBedroom]] page.\r\n\r\n\r\n{{include(docs:AutomatedTicketsFooter)}}\r\n','Create initial page','2018-07-06 23:29:51',1),(33,33,1,'h2. Overview\r\n\r\nWe occasionally have semi-sensitive paperwork that needs to be shredded before recycling. This paperwork is collected in a box within the student worker cubicle area. This box will need to be processed as indicated on this page. This box usually sits on the cabinet to the right of the entryway.\r\n\r\nh2. Frequency\r\n\r\nAt least once a week.\r\n\r\nh2. Processing instructions\r\n\r\n# locate box\r\n# locate shredder (loading dock-immediately when entering loading dock it is located to the left against wall beside garbage can-it is tan)\r\n# turn the shredder on (power button red switch on the side and then press forward button)\r\n# shred documents *be sure to remove staples and paper clips from documents--caution (be sure to keep hands clear of shredding area)\r\n# when shredding complete, be sure to power off the machine\r\n# return box to designated location in student worker cubicle.','Create initial page','2018-07-06 23:35:30',1),(34,34,1,'h2. Background\r\n\r\nCurrently we have a 4 month dry-erase calendar on the outside of a cubicle wall when you enter our area. This calendar is primarily used to note leave, conferences and holidays.\r\n\r\nh2. Tasks\r\n\r\n# Remove the previous month\r\n# Include the current month\r\n# Include the following three months\r\n','Create initial page','2018-07-06 23:38:03',1),(35,35,1,'h1. Work Area Cleanup\r\n\r\nh2. About\r\n\r\nPeriodically, our work areas need to be cleaned up. This includes, but is not limited to, cables, open computers, spare parts, recyclable materials, trash, etc. \r\n\r\nh2. Where\r\n\r\nWork areas we\'re responsible for include:\r\n\r\n* The back room\r\n* Walkways between cubicles\r\n* Student worker workspace\r\n* Storage cabinets\r\n* Shelving\r\n* Systems Conference room\r\n* Any other area used for storage or misc work\r\n\r\nh2. Frequency\r\n\r\nAt least once a week, or when you see that things are not where they\'re supposed to be. We want our work areas to be reasonably clean at all times.\r\n\r\nh2. Processing instructions\r\n\r\n* Gather any loose power, video or extension cables, paper, and hard drives and place in the appropriate cabinets.\r\n* Place full surplus carts in the Graveyard and process as necessary.\r\n* Place optical media back in the binder, and place the binder on a shelf in the work area.\r\n* Organize and place supplies like tape, rubber bands and bread ties in a consistent location within the work area.\r\n* Remove extra carts from our dept and place in the tech services hallway. Please be sure to place them out of the immediate walkway. It\'s ok to keep one or two carts around, particularly if there is a job coming up.\r\n* Any computers or printers around the back room should be put into its proper location','Create initial page','2018-07-06 23:49:26',1),(36,36,1,'{{include(docs:Work_Area_Cleanup)}}','Fix project ref','2018-07-06 23:50:16',2),(37,37,1,'Please pickup and deliver mail for our dept.\r\n\r\n*Note:* Please mark the ticket as \"follow up\" if you have checked the mail but are not ready to close the ticket yet.\r\n\r\n<redpre style=\"white-space: pre-line; border-style: solid; border-width: medium; background-color: white; border-color: black; display:block; padding: 1em;\">\r\nBecause mail is often delivered later in the day, it is best to make a final late afternoon check for mail before closing this ticket.\r\n</redpre>','Create initial page','2018-07-06 23:58:19',1),(38,38,1,'Please pickup more paper boxes from the Admin office if we have fewer than 8 boxes.','Create initial page','2018-07-07 00:00:05',1),(39,39,1,'Automatic Updates have been disabled for this box due to various issues with dependent services not handling auto-restart gracefully.\r\n\r\nSee these pages for directions:\r\n\r\n* placeholder1\r\n* placeholder2\r\n* placeholder3','Create initial page','2018-07-07 00:09:04',1);
/*!40000 ALTER TABLE `wiki_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_pages`
--

DROP TABLE IF EXISTS `wiki_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wiki_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_on` datetime NOT NULL,
  `protected` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_pages_wiki_id_title` (`wiki_id`,`title`),
  KEY `index_wiki_pages_on_wiki_id` (`wiki_id`),
  KEY `index_wiki_pages_on_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_pages`
--

LOCK TABLES `wiki_pages` WRITE;
/*!40000 ALTER TABLE `wiki_pages` DISABLE KEYS */;
INSERT INTO `wiki_pages` VALUES (1,1,'Wiki','2018-06-25 00:36:04',0,NULL),(2,1,'IncludePages','2018-07-06 22:29:50',0,NULL),(3,1,'AutomatedTickets','2018-07-06 22:31:56',0,2),(4,1,'AutomatedTicketsFooter','2018-07-06 22:56:23',0,3),(5,1,'AutomatedTicketsCleanFridgeCoils','2018-07-06 22:59:43',0,3),(6,1,'AutomatedTicketsInventoryCatSupplies','2018-07-06 23:01:19',0,3),(7,1,'AutomatedTicketsVacuumVehicles','2018-07-06 23:03:06',0,3),(8,1,'AutomatedTicketsVehiclesCheckTirePressure','2018-07-06 23:06:38',0,3),(9,1,'AutomatedTicketsVehiclesCleanWindows','2018-07-06 23:07:50',0,3),(10,1,'AutomatedTicketsReplaceToothbrushes','2018-07-06 23:09:05',0,3),(11,1,'AutomatedTicketsReplaceSinkWaterFilter','2018-07-06 23:10:10',0,3),(12,1,'AutomatedTicketsPackLunchBoxWithRefills','2018-07-06 23:11:09',0,3),(13,1,'AutomatedTicketsFeedCatsWetFood','2018-07-06 23:11:52',0,3),(14,1,'AutomatedTicketsCleanPorches','2018-07-06 23:12:36',0,3),(15,1,'AutomatedTicketsCleanGutters','2018-07-06 23:13:22',0,3),(16,1,'AutomatedTicketsCleanFridgeShelves','2018-07-06 23:14:14',0,3),(17,1,'AutomatedTicketsCleanBathroomFan','2018-07-06 23:14:55',0,3),(18,1,'AutomatedTicketsCheckWorkSupplies','2018-07-06 23:17:58',0,3),(19,1,'AutomatedTicketsCheckCatFoodFeeder','2018-07-06 23:18:49',0,3),(20,1,'AutomatedTicketsChangeCatWater','2018-07-06 23:19:27',0,3),(21,1,'AutomatedTicketsChangeCatPan','2018-07-06 23:20:11',0,3),(22,1,'AutomatedTicketsAirFilterMaintenanceOffice','2018-07-06 23:20:55',0,3),(23,1,'AutomatedTicketsAirFilterMaintenanceLivingRoom','2018-07-06 23:21:40',0,3),(24,1,'AutomatedTicketsAirFilterMaintenanceKidsBedroom','2018-07-06 23:22:24',0,3),(25,1,'AutomatedTicketsAirFilterMaintenanceCentral','2018-07-06 23:23:10',0,3),(26,1,'AutomatedTicketsAddTabletsToCentralAirTray','2018-07-06 23:24:04',0,3),(27,1,'AutomatedTicketsWashKidsBedclothes','2018-07-06 23:25:01',0,3),(28,1,'AutomatedTicketsReplaceSinusRinseBottles','2018-07-06 23:25:41',0,3),(29,1,'AutomatedTicketsPayBillWater','2018-07-06 23:26:22',0,3),(30,1,'AutomatedTicketsPayBillVehicle','2018-07-06 23:27:24',0,3),(31,1,'AutomatedTicketsAirFilterCPAP','2018-07-06 23:28:57',0,3),(32,1,'AutomatedTicketsAirFilterMaintenanceMasterBedroom','2018-07-06 23:29:51',0,3),(33,1,'AutomatedTicketsShredPaper','2018-07-06 23:35:30',0,3),(34,1,'AutomatedTicketsSystemsDryEraseCalendar','2018-07-06 23:38:03',0,3),(35,1,'Work_Area_Cleanup','2018-07-06 23:49:26',0,1),(36,1,'AutomatedTicketsWorkAreaCleanup','2018-07-06 23:49:52',0,3),(37,1,'AutomatedTicketsMailCheck','2018-07-06 23:58:19',0,3),(38,1,'AutomatedTicketsCheckStorageSupplies','2018-07-07 00:00:05',0,3),(39,1,'AutomatedTicketsManualPatching','2018-07-07 00:09:04',0,3);
/*!40000 ALTER TABLE `wiki_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_redirects`
--

DROP TABLE IF EXISTS `wiki_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wiki_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `redirects_to` varchar(255) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `redirects_to_wiki_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_redirects_wiki_id_title` (`wiki_id`,`title`),
  KEY `index_wiki_redirects_on_wiki_id` (`wiki_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_redirects`
--

LOCK TABLES `wiki_redirects` WRITE;
/*!40000 ALTER TABLE `wiki_redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_redirects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wikis`
--

DROP TABLE IF EXISTS `wikis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wikis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `start_page` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `wikis_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wikis`
--

LOCK TABLES `wikis` WRITE;
/*!40000 ALTER TABLE `wikis` DISABLE KEYS */;
INSERT INTO `wikis` VALUES (1,1,'Wiki',1);
/*!40000 ALTER TABLE `wikis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  `old_status_id` int(11) NOT NULL DEFAULT '0',
  `new_status_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  `assignee` tinyint(1) NOT NULL DEFAULT '0',
  `author` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(30) DEFAULT NULL,
  `field_name` varchar(30) DEFAULT NULL,
  `rule` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wkfs_role_tracker_old_status` (`role_id`,`tracker_id`,`old_status_id`),
  KEY `index_workflows_on_old_status_id` (`old_status_id`),
  KEY `index_workflows_on_role_id` (`role_id`),
  KEY `index_workflows_on_new_status_id` (`new_status_id`),
  KEY `index_workflows_on_tracker_id` (`tracker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflows`
--

LOCK TABLES `workflows` WRITE;
/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
INSERT INTO `workflows` VALUES (1,1,1,2,3,0,0,'WorkflowTransition',NULL,NULL),(2,1,1,3,3,0,0,'WorkflowTransition',NULL,NULL),(3,1,1,4,3,0,0,'WorkflowTransition',NULL,NULL),(4,1,1,5,3,0,0,'WorkflowTransition',NULL,NULL),(5,1,1,6,3,0,0,'WorkflowTransition',NULL,NULL),(6,1,2,1,3,0,0,'WorkflowTransition',NULL,NULL),(7,1,2,3,3,0,0,'WorkflowTransition',NULL,NULL),(8,1,2,4,3,0,0,'WorkflowTransition',NULL,NULL),(9,1,2,5,3,0,0,'WorkflowTransition',NULL,NULL),(10,1,2,6,3,0,0,'WorkflowTransition',NULL,NULL),(11,1,3,1,3,0,0,'WorkflowTransition',NULL,NULL),(12,1,3,2,3,0,0,'WorkflowTransition',NULL,NULL),(13,1,3,4,3,0,0,'WorkflowTransition',NULL,NULL),(14,1,3,5,3,0,0,'WorkflowTransition',NULL,NULL),(15,1,3,6,3,0,0,'WorkflowTransition',NULL,NULL),(16,1,4,1,3,0,0,'WorkflowTransition',NULL,NULL),(17,1,4,2,3,0,0,'WorkflowTransition',NULL,NULL),(18,1,4,3,3,0,0,'WorkflowTransition',NULL,NULL),(19,1,4,5,3,0,0,'WorkflowTransition',NULL,NULL),(20,1,4,6,3,0,0,'WorkflowTransition',NULL,NULL),(21,1,5,1,3,0,0,'WorkflowTransition',NULL,NULL),(22,1,5,2,3,0,0,'WorkflowTransition',NULL,NULL),(23,1,5,3,3,0,0,'WorkflowTransition',NULL,NULL),(24,1,5,4,3,0,0,'WorkflowTransition',NULL,NULL),(25,1,5,6,3,0,0,'WorkflowTransition',NULL,NULL),(26,1,6,1,3,0,0,'WorkflowTransition',NULL,NULL),(27,1,6,2,3,0,0,'WorkflowTransition',NULL,NULL),(28,1,6,3,3,0,0,'WorkflowTransition',NULL,NULL),(29,1,6,4,3,0,0,'WorkflowTransition',NULL,NULL),(30,1,6,5,3,0,0,'WorkflowTransition',NULL,NULL),(31,2,1,2,3,0,0,'WorkflowTransition',NULL,NULL),(32,2,1,3,3,0,0,'WorkflowTransition',NULL,NULL),(33,2,1,4,3,0,0,'WorkflowTransition',NULL,NULL),(34,2,1,5,3,0,0,'WorkflowTransition',NULL,NULL),(35,2,1,6,3,0,0,'WorkflowTransition',NULL,NULL),(36,2,2,1,3,0,0,'WorkflowTransition',NULL,NULL),(37,2,2,3,3,0,0,'WorkflowTransition',NULL,NULL),(38,2,2,4,3,0,0,'WorkflowTransition',NULL,NULL),(39,2,2,5,3,0,0,'WorkflowTransition',NULL,NULL),(40,2,2,6,3,0,0,'WorkflowTransition',NULL,NULL),(41,2,3,1,3,0,0,'WorkflowTransition',NULL,NULL),(42,2,3,2,3,0,0,'WorkflowTransition',NULL,NULL),(43,2,3,4,3,0,0,'WorkflowTransition',NULL,NULL),(44,2,3,5,3,0,0,'WorkflowTransition',NULL,NULL),(45,2,3,6,3,0,0,'WorkflowTransition',NULL,NULL),(46,2,4,1,3,0,0,'WorkflowTransition',NULL,NULL),(47,2,4,2,3,0,0,'WorkflowTransition',NULL,NULL),(48,2,4,3,3,0,0,'WorkflowTransition',NULL,NULL),(49,2,4,5,3,0,0,'WorkflowTransition',NULL,NULL),(50,2,4,6,3,0,0,'WorkflowTransition',NULL,NULL),(51,2,5,1,3,0,0,'WorkflowTransition',NULL,NULL),(52,2,5,2,3,0,0,'WorkflowTransition',NULL,NULL),(53,2,5,3,3,0,0,'WorkflowTransition',NULL,NULL),(54,2,5,4,3,0,0,'WorkflowTransition',NULL,NULL),(55,2,5,6,3,0,0,'WorkflowTransition',NULL,NULL),(56,2,6,1,3,0,0,'WorkflowTransition',NULL,NULL),(57,2,6,2,3,0,0,'WorkflowTransition',NULL,NULL),(58,2,6,3,3,0,0,'WorkflowTransition',NULL,NULL),(59,2,6,4,3,0,0,'WorkflowTransition',NULL,NULL),(60,2,6,5,3,0,0,'WorkflowTransition',NULL,NULL),(61,3,1,2,3,0,0,'WorkflowTransition',NULL,NULL),(62,3,1,3,3,0,0,'WorkflowTransition',NULL,NULL),(63,3,1,4,3,0,0,'WorkflowTransition',NULL,NULL),(64,3,1,5,3,0,0,'WorkflowTransition',NULL,NULL),(65,3,1,6,3,0,0,'WorkflowTransition',NULL,NULL),(66,3,2,1,3,0,0,'WorkflowTransition',NULL,NULL),(67,3,2,3,3,0,0,'WorkflowTransition',NULL,NULL),(68,3,2,4,3,0,0,'WorkflowTransition',NULL,NULL),(69,3,2,5,3,0,0,'WorkflowTransition',NULL,NULL),(70,3,2,6,3,0,0,'WorkflowTransition',NULL,NULL),(71,3,3,1,3,0,0,'WorkflowTransition',NULL,NULL),(72,3,3,2,3,0,0,'WorkflowTransition',NULL,NULL),(73,3,3,4,3,0,0,'WorkflowTransition',NULL,NULL),(74,3,3,5,3,0,0,'WorkflowTransition',NULL,NULL),(75,3,3,6,3,0,0,'WorkflowTransition',NULL,NULL),(76,3,4,1,3,0,0,'WorkflowTransition',NULL,NULL),(77,3,4,2,3,0,0,'WorkflowTransition',NULL,NULL),(78,3,4,3,3,0,0,'WorkflowTransition',NULL,NULL),(79,3,4,5,3,0,0,'WorkflowTransition',NULL,NULL),(80,3,4,6,3,0,0,'WorkflowTransition',NULL,NULL),(81,3,5,1,3,0,0,'WorkflowTransition',NULL,NULL),(82,3,5,2,3,0,0,'WorkflowTransition',NULL,NULL),(83,3,5,3,3,0,0,'WorkflowTransition',NULL,NULL),(84,3,5,4,3,0,0,'WorkflowTransition',NULL,NULL),(85,3,5,6,3,0,0,'WorkflowTransition',NULL,NULL),(86,3,6,1,3,0,0,'WorkflowTransition',NULL,NULL),(87,3,6,2,3,0,0,'WorkflowTransition',NULL,NULL),(88,3,6,3,3,0,0,'WorkflowTransition',NULL,NULL),(89,3,6,4,3,0,0,'WorkflowTransition',NULL,NULL),(90,3,6,5,3,0,0,'WorkflowTransition',NULL,NULL),(91,1,1,2,4,0,0,'WorkflowTransition',NULL,NULL),(92,1,1,3,4,0,0,'WorkflowTransition',NULL,NULL),(93,1,1,4,4,0,0,'WorkflowTransition',NULL,NULL),(94,1,1,5,4,0,0,'WorkflowTransition',NULL,NULL),(95,1,2,3,4,0,0,'WorkflowTransition',NULL,NULL),(96,1,2,4,4,0,0,'WorkflowTransition',NULL,NULL),(97,1,2,5,4,0,0,'WorkflowTransition',NULL,NULL),(98,1,3,2,4,0,0,'WorkflowTransition',NULL,NULL),(99,1,3,4,4,0,0,'WorkflowTransition',NULL,NULL),(100,1,3,5,4,0,0,'WorkflowTransition',NULL,NULL),(101,1,4,2,4,0,0,'WorkflowTransition',NULL,NULL),(102,1,4,3,4,0,0,'WorkflowTransition',NULL,NULL),(103,1,4,5,4,0,0,'WorkflowTransition',NULL,NULL),(104,2,1,2,4,0,0,'WorkflowTransition',NULL,NULL),(105,2,1,3,4,0,0,'WorkflowTransition',NULL,NULL),(106,2,1,4,4,0,0,'WorkflowTransition',NULL,NULL),(107,2,1,5,4,0,0,'WorkflowTransition',NULL,NULL),(108,2,2,3,4,0,0,'WorkflowTransition',NULL,NULL),(109,2,2,4,4,0,0,'WorkflowTransition',NULL,NULL),(110,2,2,5,4,0,0,'WorkflowTransition',NULL,NULL),(111,2,3,2,4,0,0,'WorkflowTransition',NULL,NULL),(112,2,3,4,4,0,0,'WorkflowTransition',NULL,NULL),(113,2,3,5,4,0,0,'WorkflowTransition',NULL,NULL),(114,2,4,2,4,0,0,'WorkflowTransition',NULL,NULL),(115,2,4,3,4,0,0,'WorkflowTransition',NULL,NULL),(116,2,4,5,4,0,0,'WorkflowTransition',NULL,NULL),(117,3,1,2,4,0,0,'WorkflowTransition',NULL,NULL),(118,3,1,3,4,0,0,'WorkflowTransition',NULL,NULL),(119,3,1,4,4,0,0,'WorkflowTransition',NULL,NULL),(120,3,1,5,4,0,0,'WorkflowTransition',NULL,NULL),(121,3,2,3,4,0,0,'WorkflowTransition',NULL,NULL),(122,3,2,4,4,0,0,'WorkflowTransition',NULL,NULL),(123,3,2,5,4,0,0,'WorkflowTransition',NULL,NULL),(124,3,3,2,4,0,0,'WorkflowTransition',NULL,NULL),(125,3,3,4,4,0,0,'WorkflowTransition',NULL,NULL),(126,3,3,5,4,0,0,'WorkflowTransition',NULL,NULL),(127,3,4,2,4,0,0,'WorkflowTransition',NULL,NULL),(128,3,4,3,4,0,0,'WorkflowTransition',NULL,NULL),(129,3,4,5,4,0,0,'WorkflowTransition',NULL,NULL),(130,1,1,5,5,0,0,'WorkflowTransition',NULL,NULL),(131,1,2,5,5,0,0,'WorkflowTransition',NULL,NULL),(132,1,3,5,5,0,0,'WorkflowTransition',NULL,NULL),(133,1,4,5,5,0,0,'WorkflowTransition',NULL,NULL),(134,1,3,4,5,0,0,'WorkflowTransition',NULL,NULL),(135,2,1,5,5,0,0,'WorkflowTransition',NULL,NULL),(136,2,2,5,5,0,0,'WorkflowTransition',NULL,NULL),(137,2,3,5,5,0,0,'WorkflowTransition',NULL,NULL),(138,2,4,5,5,0,0,'WorkflowTransition',NULL,NULL),(139,2,3,4,5,0,0,'WorkflowTransition',NULL,NULL),(140,3,1,5,5,0,0,'WorkflowTransition',NULL,NULL),(141,3,2,5,5,0,0,'WorkflowTransition',NULL,NULL),(142,3,3,5,5,0,0,'WorkflowTransition',NULL,NULL),(143,3,4,5,5,0,0,'WorkflowTransition',NULL,NULL),(144,3,3,4,5,0,0,'WorkflowTransition',NULL,NULL);
/*!40000 ALTER TABLE `workflows` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-07 22:05:56
