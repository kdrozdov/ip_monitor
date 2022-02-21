# frozen_string_literal: true

source 'https://rubygems.org'

# Webserver
gem 'puma', '~> 5.5.1'
gem 'rack'
gem 'rack-contrib' # For convert request body to params see ./config.ru

# Framework
gem 'luna_park', '~> 0.11.1'
gem 'sinatra'
gem 'zeitwerk', '2.4.2' # For autoload path see ./config/boot.rb

# Validators
gem 'dry-validation'

# Db
gem 'pg', '~> 0.18'
gem 'sequel'

# Views
gem 'jsonapi-serializers'

# System
gem 'dotenv'
gem 'racksh'
gem 'rake'

# gem 'rest-client'

gem 'concurrent-ruby'
gem 'net-ping'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'factory_bot'
  gem 'overcommit'
  gem 'rack-test'
  gem 'rerun' # Code autoreload after change files in dev mode
  gem 'rspec'
  gem 'rubocop'
  gem 'rubocop-rake',   require: false
  gem 'rubocop-rspec',  require: false
  gem 'rubocop-sequel', require: false
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'faker'
  gem 'rspec-json_expectations'
  gem 'webmock'
end
