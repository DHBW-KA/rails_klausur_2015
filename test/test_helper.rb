require 'simplecov'
SimpleCov.start

$LOAD_PATH << File.expand_path('../', __FILE__)

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

Minitest.after_run do
  SimpleCov.result.format!
  $test_result ||= 0.0
  result = (SimpleCov.result.covered_percent * $test_result)
  File.open(Rails.root + "log/klausur.log", 'a'){|f| f.write "['#{Time.now}',#{SimpleCov.result.covered_percent},#{$test_result},#{result}]\n" }
  puts "\n" + "=" * 34
  puts " Klausurergebnis: %.2f%% von 100%" % [result]
  puts "=" * 34
end


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end