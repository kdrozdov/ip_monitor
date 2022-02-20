# frozen_string_literal: true

require 'webmock/rspec'

ENV['APP_ENV'] = 'test'

require File.expand_path('../config/boot', __dir__)

require 'rspec'
require 'rack/test'
require 'rspec/json_expectations'
require 'database_cleaner'
require 'faker'

Dir['./spec/shared/**/*.rb'].sort.each { |f| require f }
Dir['./spec/*/factories/**/*.rb'].sort.each { |f| require f }

module RSpecMixin
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use Rack::PostBodyContentTypeParser
      run UrlMap
    end
  end
end

db_cleaner = DatabaseCleaner[:sequel, connection: DB]

RSpec.configure do |config|
  config.include RSpec::JsonExpectations::Matchers

  config.color     = true
  config.formatter = :documentation

  config.mock_with   :rspec
  config.expect_with :rspec

  config.raise_errors_for_deprecations!
  config.include RSpecMixin

  # Factory bot
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) { FactoryBot.find_definitions }

  # Database cleaner
  config.before(:suite) { db_cleaner.clean_with :truncation }

  config.before do
    db_cleaner.strategy = self.class.metadata[:clean_with] || :transaction
  end

  config.before { db_cleaner.start }
  config.after  { db_cleaner.clean }
  config.after(:suite) { db_cleaner.clean_with :truncation }
end
