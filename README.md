# automated-tickets-dev

Development environment for
[automated-tickets](https://github.com/WhyAskWhy/automated-tickets) work.

## Requirements

In order to reduce setup requirments on the part of the developer, the scripts
used by this project make multiple assumptions that the main project does not:

- Ubuntu 16.04
    - clean, without any packages already installed aside from OS and
      integration tools (e.g., Hyper-V, VirtualBox, VMware Tools)
- Internet access (needed for installation and setup of packages)
- `ubuntu` user account with sudo access
    - alternative: adjust `/etc/postfix/aliases.conf` to replace 'ubuntu'
      with an account that you prefer to use for interactive login dev work

## Repo layout

File/Path | Purpose | Notes
--------- | ------- | -----
`bin` | Scripts meant to be used directly by developer| Most are used directly within the guest/VM, but some from Host system
`bin/backup_dbs.sh` | Create quick backup copies of current Redmine databases | Useful for exporting settings to include in repo for the next dev env rebuild
`bin/create_tickets.sh` | Run after the `bin/setup_dev_environment.sh` script in order to inject test automated tickets entries | Usually run once
`bin/setup_dev_environment.sh` | Main setup script to kickstart a new dev environment | Usually run just once per new dev env
`bin/sync_files.ps1` | Copy files from Hyper-V Host to Hyper-V guest | Alternative to first cloning this repo to get access to `bin/setup_dev_environment.sh` script
`doc` | Documentation specific to this project | Thin, but should be mostly complete
`etc` | Configuration files for various dependencies/tools used within dev environment | Deployed as part of running the `bin/setup_dev_environment.sh` script
`keys` | Local cache of package signing keys for upstream MariaDB, Nginx and Phusion repos | Added via `apt-key` as part of running the `bin/setup_dev_environment.sh` script
`opt` | Configuration files used by Redmine and Phusion Passenger Standalone | Deployed as part of running the `bin/setup_dev_environment.sh` script
`sql` | Import files used to setup Redmine instances and `event_reminders` database used by automated-tickets project | Imported as part of running the `bin/setup_dev_environment.sh` script
`var` | Contains small index.html file for Redmine instances | Served up on http://localhost/
`LICENSE` | License for this collection of content | Intended to match the license used for automated-tickets project
`README.md` | Main doc file for this project | Please submit a PR or bug report for any missing or incorrect coverage

## Dependencies

### Redmine

Two instances of a semi-current and stable Redmine version are installed:

| Instance | URL | Username | Password |
| -------- | --- | -------- | -------- |
MySQL/MariaDB backend | http://localhost/redmine-mysql/ | admin | qwerty
SQLite backend | http://localhost/redmine-sqlite/ | admin | qwerty

Both instances are installed and setup identically (aside from the
backend) in order to facilitate testing against both backends with
the automated-tickets project. As of this writing the SQLite database type
is not supported by the automated-tickets project, but it is a likely target
in the future. Because of this, we're going ahead and providing a test Redmine
environment ahead of time to make adding that future support easier.

Aside from the direct links provided above, there is a simple list of both
links available from https://localhost/ in the guest/VM.

### Postfix

As part of the setup work Postfix is installed and configured to route
mail from the `automated-tickets@localhost` alias to both Redmine instances
via the Redmine-provided HTTP API submission script.

To help prevent duplicate ticket creation (behavior observed during testing),
Postfix has been heavily throttled back to only deliver one email every X
seconds (see the `/etc/postfix/main.cf` file for current setting) and only
one at a time. This is usually not a problem per se, but it is worth
emphasizing.

Feel free to adjust the settings if your test rig is sufficiently powerful.

Listens on localhost only.

### Phusion Passenger: Standalone

The "Standalone" version of Phusion Passenger is installed from the official
upstream repo and configured to serve up two Redmine instances:

- Redmine with MySQL/MariaDB backend
- Redmine with SQLite backend

See the `Passengerfile.json` files within `/opt/redmine/BACKEND/` for specific
configuration details. As of this writing both instances are configured in
`development` mode in order to provide verbose feedback if an error is
encountered wioth their configuration or use.

Listens on localhost only.

### Nginx

The upstream "stable" version of Nginx is installed and configured as a reverse
proxy for two Phusion Passenger Standalone instances. A connections between
Nginx and each instance of Phusion Passenger Standalone is provided by way of
a local UNIX socket specific to that instance of Passenger.

Listens on localhost only.

### MariaDB

The upstream version of MariaDB 10.0.x is installed and configured in an
insecure manner for production purposes, but sufficient for our local testing
needs. No password is set for the `root` account.

Listens on localhost only.

## References

- https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-manual-setup
- https://stackoverflow.com/questions/40189084/what-is-ipv6-for-localhost-and-0-0-0-0
