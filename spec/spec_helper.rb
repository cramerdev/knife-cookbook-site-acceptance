require 'support/command_line_helpers'
require 'support/setup_and_teardown_helper'
require 'support/fixture_helpers'

RSpec.configure do |config|
  config.include CommandLineHelpers
  config.include FixtureHelpers

  config.add_setting :cookbook_name, default: "supermarket-test-#{Time.now.to_i}"

  config.before(:suite) do
    helper = SetupAndTeardownHelper.new(RSpec.configuration.cookbook_name)
    helper.setup!
  end

  config.after(:suite) do
    helper = SetupAndTeardownHelper.new(RSpec.configuration.cookbook_name)
    helper.teardown!
  end

end
