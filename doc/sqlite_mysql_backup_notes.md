
# Scratch notes for performing backups

## Backing up SQLite database

### Manually

1. `cd /path/to/repo`
2. `sudo sqlite3 /opt/redmine/sqlite/db/redmine.db`
3. `.output redmine-sqlite-export.sql`
4. `.dump`
5. `.exit`

### Scripted

1. `cd /path/to/repo`
2. `echo ".dump" | sudo sqlite3 /opt/redmine/sqlite/db/redmine.db > redmine-sqlite-export.sql`


## Backing up MySQL/MariaDB database

1. `cd /path/to/repo`
2. `sudo mysqldump --no-defaults -u root --databases redmine > redmine-mysql-export.sql`


## References

- https://github.com/weewx/weewx/wiki/Transfer-from-sqlite-to-MySQL
- https://github.com/weewx/weewx/wiki/Transfer%20from%20MySQL%20to%20sqlite
- https://alvinalexander.com/android/sqlite-dump-backup-database-file-how
- https://stackoverflow.com/questions/2049109/how-do-i-import-sql-files-into-sqlite-3
- http://www.sqlitetutorial.net/sqlite-dump/


- https://github.com/WhyAskWhy/automated-tickets-dev
