-- https://github.com/WhyAskWhy/automated-tickets-dev

-- NOTE: This should probably be utf8mb4 for full Unicode support
CREATE DATABASE redmine CHARACTER SET utf8;

-- Matching values set within /path/to/redmine/config/database.yml
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'redmine';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
