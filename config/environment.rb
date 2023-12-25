# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Load the app's custom environment variables here, before environments/*.rb
app_env_vars = File.join(Rails.root, 'config', 'initializers', 'env_variables.rb')
load(app_env_vars) if File.exist?(app_env_vars)
# Initialize the Rails application.
Rails.application.initialize!
