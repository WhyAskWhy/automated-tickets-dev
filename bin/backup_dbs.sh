#!/bin/bash

# https://github.com/WhyAskWhy/automated-tickets-dev

# Purpose: Dump current state of databases

echo "* Backing up SQLite3 database ..."
echo ".dump" | sudo sqlite3 /opt/redmine/sqlite/db/redmine.db > redmine-sqlite-export.sql

echo "* Backing up MariaDB database ..."
sudo mysqldump --no-defaults -u root --databases redmine > redmine-mysql-export.sql
