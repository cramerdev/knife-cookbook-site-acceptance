require 'erb'

module FixtureHelpers

  def cookbook_name
    RSpec.configuration.cookbook_name
  end

  def fixture(name)
    ERB.new(File.read("spec/fixtures/#{name}.erb").strip).result(binding)
  end

  def expected_signature(name)
    signature_of(fixture(name))
  end

  def signature_of(output)
    output.lines.reject do |line|
      line.match /^created_at|updated_at|file|tarball_file_size/
    end.join("\n")
  end

end
