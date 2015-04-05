# Require all files under /lib
Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |f| require f }

# Require all spec support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Include support modules from support files
  config.include SetupMacros

  # Do not display console outputs when running tests
  config.before { allow($stdout).to receive(:write) }
end
