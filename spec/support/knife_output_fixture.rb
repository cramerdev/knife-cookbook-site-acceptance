require 'support/volatile_attribute_scrubber'

class KnifeOutputFixture
  def self.variables_module(variables)
    Module.new do
      variables.each do |key, val|
        define_method(key) { val }
      end
    end
  end

  def initialize(name, variables = {})
    @name = name
    @scrubber = VolatileAttributeScrubber.new
    extend self.class.variables_module(variables)
  end

  def signature
    @scrubber.scrub(content)
  end

  private

  def content
    ERB.new(File.read(fixture_path)).result(binding)
  end

  def fixture_path
    File.expand_path(File.join('./spec/fixtures/knife', "#{@name}.erb"))
  end
end
