# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'
require 'codeclimate-test-reporter'
require 'juknife'

dir = File.join(ENV['CIRCLE_ARTIFACTS'] || 'build', 'coverage')
SimpleCov.coverage_dir(dir)

SimpleCov.start do
  add_filter '/vendor/'
  add_filter '/spec/'

  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
