# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
require "csv"
require "yaml"

MAP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/map_dashboard.yml")
