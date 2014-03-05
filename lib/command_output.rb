require 'volatile_attribute_scrubber'

class CommandOutput

  def initialize(output)
    @output = output
    @scrubber = VolatileAttributeScrubber.new
  end

  def signature
    @scrubber.scrub(@output)
  end

end
