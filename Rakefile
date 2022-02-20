# frozen_string_literal: true

require 'rake'
require_relative 'config/root'

# tasks from lib directory
Dir[File.expand_path('../lib/tasks/**/*.rake', __FILE__)].each do |entity|
  load entity
end

task default: %i[spec rubocop]

task app_env: :config do
  puts APP_ENV
end

task :instance do
  require './config/instance.rb'
  puts INSTANCE
end

task :boot do
  require './config/boot.rb'
end

task :config do
  require './config/config.rb'
end
