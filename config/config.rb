# frozen_string_literal: true

require 'openssl'
require 'dotenv/load'
require_relative '../lib/env_configuration'
require_relative '../lib/app_environment'

ENV['RACK_ENV'] = ENV['APP_ENV']

envfile = ENV['RACK_ENV'] || 'development'
Dotenv.load(".env.#{envfile}", '.env', ".env.#{envfile}.default", '.env.default')

CONFIG = EnvConfiguration.new(check_required: ENV['STRICT_CONFIG'] == 'true') do
  required(:project_name, 'PROJECT_NAME')
  required(:app_env,      'APP_ENV') { |v| AppEnvironment.new(v, allowed: %w[production development test]) }
  required(:default_severity, 'DEFAULT_SEVERITY', &:to_sym)

  namespace(:puma) do
    required(:pid,         'PUMA_PID')
    required(:state,       'PUMA_STATE')
    required(:bind,        'PUMA_BIND')
    required(:workers,     'PUMA_WORKERS')     { |v| Integer(v) }
    required(:max_threads, 'PUMA_MAX_THREADS') { |v| Integer(v) }
  end

  namespace(:db) do
    required(:adapter,  'DB_ADAPTER')
    required(:encoding, 'DB_ENCODING')
    optional(:database, 'DB_NAME')
    required(:username, 'DB_USER')
    required(:password, 'DB_PASSWORD')
    required(:host,     'DB_HOST')
    required(:port,     'DB_PORT')
    required(:max_connections, 'PUMA_MAX_THREADS')
  end
end.freeze
