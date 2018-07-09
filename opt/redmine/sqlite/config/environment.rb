# https://github.com/WhyAskWhy/automated-tickets
# https://github.com/WhyAskWhy/automated-tickets-dev

# Load the Rails application
require File.expand_path('../application', __FILE__)

# Make sure there's no plugin in vendor/plugin before starting
vendor_plugins_dir = File.join(Rails.root, "vendor", "plugins")
if Dir.glob(File.join(vendor_plugins_dir, "*")).any?
  $stderr.puts "Plugins in vendor/plugins (#{vendor_plugins_dir}) are no longer allowed. " +
    "Please, put your Redmine plugins in the `plugins` directory at the root of your " +
    "Redmine directory (#{File.join(Rails.root, "plugins")})"
  exit 1
end

# http://www.redmine.org/projects/redmine/wiki/HowTo_Install_Redmine_in_a_sub-URI
# http://www.redmine.org/issues/11881#note-5
# https://github.com/phusion/passenger/issues/763
#
# This setting appears to be needed for dynamic URLs, whereas the setting
# in additional_environment.rb appears to be needed for static content.
RedmineApp::Application.routes.default_scope = "/redmine-sqlite"

# Initialize the Rails application
Rails.application.initialize!
