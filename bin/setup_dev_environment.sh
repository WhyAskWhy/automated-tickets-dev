#!/bin/bash

# https://github.com/WhyAskWhy/automated-tickets
# https://github.com/WhyAskWhy/automated-tickets-dev
# Enable MySQL APT repo in order to install MySQL Workbench
# https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.10-1ubuntu16.04-amd64.deb


# Purpose: Help setup new Ubuntu 16.04 VM for testing automated-tickets project


# Do not allow use of unitilized variables
set -u

# errtrace
#         Same as -E.
#
# -E      If set, any trap on ERR is inherited by shell functions,
#         command substitutions, and commands executed in a sub‐
#         shell environment.  The ERR trap is normally not inher‐
#         ited in such cases.
set -o errtrace

# Exit if any statement returns a non-true value
# http://mywiki.wooledge.org/BashFAQ/105
# set -e

# Exit if ANY command in a pipeline fails instead of allowing the exit code
# of later commands in the pipeline to determine overall success
set -o pipefail

trap 'echo "Error occurred on line $LINENO."' ERR


if [[ "$UID" -eq 0 ]]; then
  echo "Run this script without sudo or as root, sudo will be called as needed."
  exit 1
fi

REDMINE_SVN_URL="http://svn.redmine.org/redmine/tags/3.4.6"
#REDMINE_SVN_URL="http://svn.redmine.org/redmine/branches/3.4-stable/"

MAIN_PROJECT_GIT_REPO_URL="https://github.com/deoren/automated-tickets"
MAIN_PROJECT_GIT_REPO_BASENAME="$(basename ${MAIN_PROJECT_GIT_REPO_URL})"

THIS_DEV_ENV_GIT_REPO_URL="https://github.com/deoren/automated-tickets-dev"
THIS_DEV_ENV_GIT_REPO_BASENAME="$(basename ${THIS_DEV_ENV_GIT_REPO_URL})"

BASE_REDMINE_INSTALL_DIR="/opt/redmine"

SETUP_LOG_FILE="$HOME/automated-tickets_dev_env_setup_output.txt"

# Create empty log file so that later tee commands can append to it
touch ${SETUP_LOG_FILE}

echo "* Performing initial refresh of package lists ..."
sudo apt-get update ||
    { echo "Another apt operation is probably in progress. Try again."; exit 1; }

echo "* Installing git in order to fetch repos ..."
sudo apt-get install -y git ||
    { echo "Failed to install git packages. Aborting!"; exit 1; }


cd /tmp

echo "* Removing old clone of ${THIS_DEV_ENV_GIT_REPO_URL} ..."
sudo rm -rf ${THIS_DEV_ENV_GIT_REPO_BASENAME}

echo "* Removing old clone of ${MAIN_PROJECT_GIT_REPO_URL} ..."
sudo rm -rf ${MAIN_PROJECT_GIT_REPO_BASENAME}

echo "* Cloning ${THIS_DEV_ENV_GIT_REPO_URL} ..."
git clone ${THIS_DEV_ENV_GIT_REPO_URL} ||
    { echo "Failed to clone ${THIS_DEV_ENV_GIT_REPO_URL}. Aborting!"; exit 1; }

# TODO: Fix this once ready to merge (use 'master' by default?)
cd ${THIS_DEV_ENV_GIT_REPO_BASENAME}
git checkout initial-dev-env-files
cd /tmp

echo "* Cloning ${MAIN_PROJECT_GIT_REPO_URL} ..."
git clone ${MAIN_PROJECT_GIT_REPO_URL} ||
    { echo "Failed to clone ${MAIN_PROJECT_GIT_REPO_URL}. Aborting!"; exit 1; }

######################################################
# Setup upstream apt repos
######################################################

echo "* Deploying apt preference files ..."

# Override conflict between nginx and Phusion Passenger repos by boosting
# precedence of the upstream nginx repo packages
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/apt/preferences.d/nginx /etc/apt/preferences.d/ ||
    { echo "Failed to deploy apt preference file. Aborting!"; exit 1; }

echo "* Deploying apt repo config files ..."

# Repo conf files
for apt_repo_conf_file in phusion-passenger.list mariadb-server.list nginx.list
do
    sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/apt/sources.list.d/${apt_repo_conf_file} /etc/apt/sources.list.d/ ||
        { echo "[!] Failed to deploy ${apt_repo_conf_file} ... aborting"; exit 1; }
done

######################################################
# Install package signing keys
######################################################

echo "* Installing apt repo package signing keys ..."

# MariaDB
if [[ ! -f /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/keys/mariadb_signing.key ]]; then
    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 ||
        { echo "[!] Failed to retrieve MariaDB signing key ... aborting"; exit 1; }
else
    sudo apt-key add /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/keys/mariadb_signing.key ||
        { echo "[!] Failed to install local repo copy of MariaDB signing key ... aborting"; exit 1; }
fi

# Nginx
if [[ ! -f /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/keys/nginx_signing.key ]]; then
wget https://nginx.org/keys/nginx_signing.key -O - | sudo apt-key add - ||
    { echo "Failed to retrieve nginx package signing key. Aborting!"; exit 1; }
else
    sudo apt-key add /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/keys/nginx_signing.key ||
        { echo "[!] Failed to install local repo copy of nginx signing key ... aborting"; exit 1; }
fi

# Phusion Passenger
if [[ ! -f /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/keys/phusion_signing.key ]]; then
    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 561F9B9CAC40B2F7 ||
        { echo "[!] Failed to retrieve Phusion Passenger signing key ... aborting"; exit 1; }
else
    sudo apt-key add /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/keys/phusion_signing.key ||
        { echo "[!] Failed to install local repo copy of Phusion signing key ... aborting"; exit 1; }

fi

######################################################
# Install packages
######################################################


echo "* Refreshing package lists ..."
sudo apt-get update ||
    { echo "Another apt operation is probably in progress. Try again."; exit 1; }

echo "* Installing primary packages ..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    nginx \
    ruby \
    ruby-dev \
    ruby-bundler \
    libsqlite3-dev \
    imagemagick \
    libmagickwand-dev \
    passenger \
    subversion \
    sqlite3 \
    python3-pip \
    sqlitebrowser \
    ||
        { echo "Failed to install required pacakges. Try again."; exit 1; }

# Install MariaDB without prompts, relying on default behavior of no password
echo "* Installing MariaDB ..."
sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y install mariadb-server libmariadbclient-dev ||
    { echo "Failed to install MariaDB packages. Aborting!"; exit 1; }


# Install this AFTER MariaDB in an attempt to prevent a conflict between
# the MariaDB packages and the Ubuntu-provied MySQL-related package deps for
# MySQL Workbench
sudo apt-get install -y \
    mysql-workbench

# Install Postfix without prompts
# https://serverfault.com/questions/143968/automate-the-installation-of-postfix-on-ubuntu
# http://blog.delgurth.com/2009/01/19/pre-loading-debconf-values-for-easy-installation/
echo "* Installing Postfix ..."
sudo bash -c "echo 'postfix postfix/mailname string localhost' | debconf-set-selections"
sudo bash -c "echo 'postfix postfix/main_mailer_type select No configuration' | debconf-set-selections"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq -y postfix mailutils ||
    { echo "Failed to install Postfix package. Aborting!"; exit 1; }

echo "* Deploying Postfix main config file ..."
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/postfix/main.cf /etc/postfix/ ||
    { echo "Failed to deploy Postfix main config file. Aborting!"; exit 1; }

echo "* Deploying Postfix aliases file ..."
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/postfix/aliases.conf /etc/postfix/aliases.conf ||
    { echo "Failed to deploy Postfix aliases file. Aborting!"; exit 1; }

echo "* Deploying Postfix header check file ..."
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/postfix/header_checks.conf /etc/postfix/ ||
    { echo "Failed to deploy Postfix aliases file. Aborting!"; exit 1; }

echo "* Running newaliases to update Postfix aliases db ..."
sudo newaliases ||
    { echo "Failed to update Postfix aliases db. Aborting!"; exit 1; }

sudo systemctl enable postfix ||
    { echo "Failed to enable Postfix unit. Aborting!"; exit 1; }

sudo systemctl restart postfix ||
    { echo "Failed to start Postfix. Aborting!"; exit 1; }


######################################################
# Setup databases
######################################################

# Use SQL file to setup database, create account and grant permissions to db
echo "* Setting up 'redmine' database, user, access ..."
mysql -u root < /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/sql/setup_redmine_database.sql ||
    { echo "Failed to setup 'redmine' database. Aborting!"; exit 1; }

# TODO: Setup event_reminders SQLite database


cd ${THIS_DEV_ENV_GIT_REPO_BASENAME}

sudo rm -rf ${BASE_REDMINE_INSTALL_DIR}
sudo mkdir -vp ${BASE_REDMINE_INSTALL_DIR}

for BACKEND_TYPE in sqlite mysql
do

    SERVICE_ACCOUNT="redmine-${BACKEND_TYPE}"

    echo "* Checking out Redmine via SVN ... "
    sudo svn co ${REDMINE_SVN_URL} ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE} ||
        { echo "Failed to checkout ${REDMINE_SVN_URL}. Aborting!"; exit 1; }

    cd ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}
    sudo mkdir -vp \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/tmp \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/tmp/pdf \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/public/plugin_assets

    echo "* Deploying Redmine configuration files for ${SERVICE_ACCOUNT} ... "
    sudo cp -fv \
        /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/opt/redmine/${BACKEND_TYPE}/config/* \
        /opt/redmine/${BACKEND_TYPE}/config/

    sudo cp -fv \
        /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/opt/redmine/${BACKEND_TYPE}/Passengerfile.json \
        /opt/redmine/${BACKEND_TYPE}/

    # Install dependencies locally instead of system-wide
    echo "* Installing required gems via bundler ... "
    sudo bundle install --without development test  --path vendor/bundle ||
        { echo "Failed to install required gems via bundler. Aborting!"; exit 1; }

    echo "* Setting up database for use (NOTE: this takes a while) ..."
    sudo bundle exec rake generate_secret_token ||
        { echo "Failed to generate secret token. Aborting!"; exit 1; }

    for environment in production development
    do
        sudo RAILS_ENV=${environment} bundle exec rake db:migrate ||
            { echo "Failed to run database migrations. Aborting!"; exit 1; }

        sudo RAILS_ENV=${environment} REDMINE_LANG=en bundle exec rake redmine:load_default_data ||
            { echo "Failed to load default data into database. Aborting!"; exit 1; }
    done



    echo "* Creating service account: ${SERVICE_ACCOUNT} ..."
    sudo useradd \
        --system \
        --user-group \
        --create-home \
        --shell /bin/bash \
        ${SERVICE_ACCOUNT} ||
            { echo "Failed to create service account ${SERVICE_ACCOUNT}. Aborting!"; exit 1; }

    echo "* Adjusting permissions to grant ${SERVICE_ACCOUNT} service account required access ..."
    sudo chown -Rv ${SERVICE_ACCOUNT}: \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/tmp \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/log \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/files \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/public/plugin_assets

    sudo chmod -Rv 755 \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/tmp \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/log \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/files \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/public/plugin_assets


    echo "* Add execute bit to Redmine HTTP API submission script ..."
    sudo chmod -v +x ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/extra/mail_handler/rdm-mailhandler.rb ||
        { echo "Failed to add execute bit to Redmine HTTP API submission script. Aborting!"; exit 1; }

    # Even though the SQLite3 backend doesn't use a username/password scheme, we
    # should still stay in the habit of blocking non-service/non-root accounts
    # from being able to read the contents (which ordinarily has user/pass pairs).

    echo "* Adjusting permissions on database config file ..."
    sudo chown -v root:${SERVICE_ACCOUNT} \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/config/database.yml

    sudo chmod -v 0640 \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/config/database.yml

    # Allow application service account to write to database directory
    # Note: Required for SQLite3, completely optional for MariaDB/MySQL
    sudo chown -vR root:${SERVICE_ACCOUNT} \
        ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/db ||
        { echo "Failed to set ownership on db directory. Aborting!"; exit 1; }

    sudo chmod -vR u+rwX,g+rwX,o= ${BASE_REDMINE_INSTALL_DIR}/${BACKEND_TYPE}/db ||
        { echo "Failed to set permissions on db directory. Aborting!"; exit 1; }

    if [ $? -eq 0 ]; then

        echo "* Deploying Phusion Passenger:Redmine (${BACKEND_TYPE}) systemd unit ..."
        sudo cp -fv /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/systemd/system/passenger-redmine-${BACKEND_TYPE}.service /etc/systemd/system/ ||
            { echo "Failed to deploy Phusion Passenger:Redmine (${BACKEND_TYPE}) systemd unit. Aborting!"; exit 1; }

        # Force systemd to see the new unit file
        sudo systemctl daemon-reload
    fi

    if [ $? -eq 0 ]; then

        echo "* Setting Phusion Passenger:Redmine (${BACKEND_TYPE}) systemd unit to start at boot ..."
        sudo systemctl enable passenger-redmine-${BACKEND_TYPE}.service ||
            { echo "Failed to enable Phusion Passenger:Redmine (${BACKEND_TYPE}) systemd unit. Aborting!"; exit 1; }

        echo "* Launching Phusion Passenger:Redmine (${BACKEND_TYPE}) systemd unit ..."
        sudo systemctl start passenger-redmine-${BACKEND_TYPE}.service ||
            { echo "Failed to start Phusion Passenger:Redmine (${BACKEND_TYPE}) systemd unit. Aborting!"; exit 1; }

    fi

done

echo "* Copying nginx conf files ..."
sudo mkdir -vp /etc/nginx /etc/nginx/sites-available
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/nginx/*.conf /etc/nginx/
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/etc/nginx/sites-available/*.conf /etc/nginx/sites-available/

echo "* Enabling/Restarting nginx ..."
sudo systemctl enable nginx ||
    { echo "Failed to enable nginx systemd unit. Aborting!"; exit 1; }

sudo systemctl restart nginx ||
    { echo "Failed to restart nginx systemd unit. Aborting!"; exit 1; }

echo "* Copying over template index page ..."
sudo mkdir -vp /var/www/html
sudo cp -vf /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/var/www/html/* /var/www/html/


# Import backup MySQL/MariaDB Redmine database export
sudo mysql -u root < /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/sql/redmine-mysql-export.sql ||
    { echo "Failed to import redmine-mysql-export.sql. Aborting!"; exit 1; }

# TODO: Add toggle for using backup export (vs going with a fresh db as created earlier in this script)
echo "* Recreating SQLite3 Redmine database using database export ..."
sudo rm -vf /opt/redmine/sqlite/db/redmine.db ||
    { echo "Failed to remove old SQLite database. Aborting!"; exit 1; }

sudo touch /opt/redmine/sqlite/db/redmine.db ||
    { echo "Failed to create new SQLite database. Aborting!"; exit 1; }

sudo sqlite3 /opt/redmine/sqlite/db/redmine.db < /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/sql/redmine-sqlite-export.sql ||
    { echo "Failed to import redmine-sqlite-export.sql. Aborting!"; exit 1; }

sudo chown root:redmine-sqlite /opt/redmine/sqlite/db/redmine.db ||
    { echo "Failed to set ownership on SQLite database. Aborting!"; exit 1; }

sudo chmod -v u+rw,g+rw,o= /opt/redmine/sqlite/db/redmine.db ||
    { echo "Failed to set permissions on SQLite database. Aborting!"; exit 1; }

echo "* Restarting Redmine/SQLite Phusion Passenger systemd unit to pick up new database ..."
sudo systemctl restart passenger-redmine-sqlite ||
    { echo "Failed to restart Redmine/SQLite Phusion Passenger systemd unit. Aborting!"; exit 1; }

# Create automated-tickets "event_reminders" database, user, permissions
echo "* Creating 'event_reminders' database, users, etc ..."
mysql -u root < /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}/sql/database_schema.sql ||
    { echo "Failed to import database schema for 'event_reminders' database. Aborting!"; exit 1; }

mysql -u root < /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}/sql/create_users.sql ||
    { echo "Failed to create database users for 'event_reminders' database. Aborting!"; exit 1; }

# Import sample data into event_reminders MySQL/MariaDB database
mysql -u root < /tmp/${THIS_DEV_ENV_GIT_REPO_BASENAME}/sql/automated_tickets_import.sql ||
    { echo "Failed to import automated_tickets_import.sql. Aborting!"; exit 1; }

# TODO: Import event_reminders SQLite database

# Install Python modules needed for main project
# TODO: Setup requirements.txt file in main project and reference that here
pip3 install mysql-connector-python pendulum --user
