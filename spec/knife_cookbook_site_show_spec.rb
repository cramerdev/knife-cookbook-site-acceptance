require 'spec_helper'

describe 'knife cookbook site show COOKBOOK' do

  it 'displays a summary of the cookbook information' do
    cookbook = TestCook.create_cookbook

    command = run "knife cookbook site show #{cookbook.name}"

    command_output = CommandOutput.new(command.stdout)
    output_fixture = KnifeOutputFixture.new('show', cookbook: cookbook)

    expect(command_output.signature).to eql(output_fixture.signature)
  end

  it 'displays all versions of a published cookbook', focus: true do
    name = "multi-version"
    cookbook = TestCook.create_cookbook(name)
    TestCook.publish_new_version(name, '0.2.0')

    command = run "knife cookbook site show #{cookbook.name}"

    command_output = CommandOutput.new(command.stdout)
    output_fixture = KnifeOutputFixture.new('show_versions', cookbook: cookbook)

    expect(command_output.signature).to eql(output_fixture.signature)
  end

  it 'exits with an error when attempting to view a nonexistent cookbook' do
    cookbook_name = "dorfle-#{Time.now.to_i}"

    expect do
      run! "knife cookbook site show #{cookbook_name}"
    end.to raise_error(Mixlib::ShellOut::ShellCommandFailed)
  end

end
