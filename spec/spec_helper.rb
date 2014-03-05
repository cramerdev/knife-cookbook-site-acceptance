require 'command_line_helpers'
require 'command_output'
require 'knife_output_fixture'
require 'test_cook'

RSpec.configure do |config|
  config.include CommandLineHelpers

  config.add_setting :starting_time, default: Time.now.to_i.to_s

  config.after(:suite) do
    TestCook.cleanup
    TestCookbook.reset
  end

end
