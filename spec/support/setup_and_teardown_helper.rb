require 'erb'
require 'support/command_line_helpers'

class SetupAndTeardownHelper
  include CommandLineHelpers

  attr_reader :cookbook_name

  def initialize(cookbook_name)
    @cookbook_name = cookbook_name
  end

  def setup!
    build_metadata!
    stage_cookbook!
    ensure_cookbook_is_shared!
  end

  def teardown!
    begin
      run! "knife cookbook site unshare #{cookbook_name} -y"
    ensure
      File.unlink(fixture_cookbook(cookbook_name))
    end
  end

  def build_metadata!
    metadata_template = File.read("spec/fixtures/cookbooks/supermarket-test/metadata.rb.erb")
    metadata_content = ERB.new(metadata_template).result(binding)

    File.write("spec/fixtures/cookbooks/supermarket-test/metadata.rb", metadata_content)
  end

  def stage_cookbook!
    File.symlink(
      fixture_cookbook('supermarket-test'),
      fixture_cookbook(cookbook_name)
    )
  end

  def ensure_cookbook_is_shared!
    run "knife cookbook site unshare #{cookbook_name} -y 2>&1 > /dev/null"
    run! "knife cookbook site share #{cookbook_name} Other"
  end

  def fixture_cookbook(name)
    File.expand_path("./spec/fixtures/cookbooks/#{name}")
  end

end
