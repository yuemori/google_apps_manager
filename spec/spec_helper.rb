$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'google_apps_manager'
require 'vcr'
require 'faker'
require 'simplecov'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

SimpleCov.start
