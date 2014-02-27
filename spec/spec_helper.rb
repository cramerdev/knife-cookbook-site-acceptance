require 'support/command_line_helpers'
require 'support/command_output'
require 'support/knife_output_fixture'
require 'support/test_cook'

RSpec.configure do |config|
  config.include CommandLineHelpers

  config.add_setting :starting_time, default: Time.now.to_i.to_s

  config.after(:suite) do
    TestCook.cleanup
    TestCookbook.reset
  end

end
