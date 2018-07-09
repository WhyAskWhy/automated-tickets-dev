#!/bin/bash

# https://github.com/WhyAskWhy/automated-tickets-dev

# Purpose:
#
#   Run primary automated_tickets.py script in order to generate full set
#   of automated tickets from test import data

MAIN_PROJECT_GIT_REPO_BASENAME="automated-tickets"


########################################################
# Generate initial test emails
########################################################

# MySQL/MariaDB
#echo "Testing against literal 'automated-tickets@localhost alias'" | mail -s "Test email number 1" automated-tickets@localhost
#echo "Testing against literal 'automated-tickets' bare alias" | mail -s "Test email number 2" automated-tickets
#echo "Testing against literal 'automated-tickets-mysql@localhost alias'" | mail -s "Test email number 3" automated-tickets-mysql@localhost
#echo "Testing against literal 'automated-tickets-mysql' bare alias" | mail -s "Test email number 4" automated-tickets-mysql

# SQLite
#echo "Testing against alias for SQLite database using literal alias 'automated-tickets-sqlite@localhost alias'" | mail -s "Test email number 1" automated-tickets-sqlite@localhost
#echo "Testing against literal 'automated-tickets-sqlite' bare alias" | mail -s "Test email number 2" automated-tickets-sqlite


# Check for required modules (needed now and upcoming issue #20)
if ! python3 -c "import mysql.connector; import pendulum"
then
    # Looks like we're missing some modules: install them
    pip3 install mysql-connector-python --user
    pip3 install pendulum --user
fi


# Get updated repo contents
if [[ ! -d /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME} ]]; then
    cd /tmp
    git clone https://github.com/deoren/automated-tickets
else
    cd /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}
    git reset HEAD --hard
    git pull --ff-only
fi

# Turn off test mode since we have a test environment setup and ready to accept
# test emails by this point.
sudo sed -i 's/testing_mode \= true/testing_mode = false/' /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}/automated_tickets.ini

# Disable verbose logging to console since the verbose output is not needed
# by default (can be enabled later as needed)
sudo sed -i 's/display_debug_messages \= true/display_debug_messages = false/' /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}/automated_tickets.ini
sudo sed -i 's/display_info_messages \= true/display_info_messages = false/' /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}/automated_tickets.ini

# Exercise known static keywords
for frequency in \
    daily \
    twice_week \
    weekly \
    weekly_monday \
    weekly_tuesday \
    weekly_wednesday \
    weekly_thursday \
    weekly_friday \
    weekly_saturday \
    weekly_sunday \
    twice_month \
    monthly \
    twice_year \
    quarterly \
    yearly
do
    python3 /tmp/${MAIN_PROJECT_GIT_REPO_BASENAME}/automated_tickets.py --event_schedule $frequency
done

echo "Finished generating Automated Tickets emails."

echo "NOTE: It may take some time for Postfix to finish submitting them via the HTTP API. Force with sudo postqueue -f"
