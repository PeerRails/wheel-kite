require 'rubygems'

ENV['RACK_ENV'] ||= 'test'
ENV['DATABASE_URL'] ||= 'postgres://test:test@localhost/wheelkite-test'

require 'rack/test'
require_relative '../server/app'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation, {:only => %w[cars]}

RSpec.configure do |config|
  config.color = true

  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!

end
