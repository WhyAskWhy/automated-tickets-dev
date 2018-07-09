# https://github.com/WhyAskWhy/automated-tickets
# https://github.com/WhyAskWhy/automated-tickets-dev

# Copy this file to additional_environment.rb and add any statements
# that need to be passed to the Rails::Initializer.  `config` is
# available in this context.
#
# Example:
#
#   config.log_level = :debug
#   ...
#

require 'syslog/logger'

# http://www.redmine.org/issues/11881
# http://www.redmine.org/issues/12102
# http://stackoverflow.com/questions/18645070/how-to-move-redmine-to-a-sub-uri-with-nginx-as-a-proxy
# # https://github.com/phusion/passenger/issues/763
# http://guides.rubyonrails.org/v4.2/configuring.html#deploy-to-a-subdirectory-relative-url-root
# Set value that front-end nginx can easily match against in order to easily
# pick out the static content that it should serve directly instead of passing
# via proxy to the Passenger Standalone / Rails instance running Redmine.
config.relative_url_root = '/redmine-mysql/static'

# Override logger object to send log data to syslog instead of local files
config.logger       = Syslog::Logger.new 'redmine'
config.logger.level = Logger::INFO

# Explicitly disable colorized log messages (usually enabled for development,
# and disable for production)
config.colorize_logging = false
