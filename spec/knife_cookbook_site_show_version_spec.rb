require 'spec_helper'

describe 'knife cookbook site show COOKBOOK VERSION' do

  it "can display the latest version of a cookbook" do
    cookbook = TestCook.create_cookbook

    command = run "knife cookbook site show #{cookbook.name} latest"

    command_output = CommandOutput.new(command.stdout)
    output_fixture = KnifeOutputFixture.new('latest', cookbook: cookbook)

    expect(command_output.signature).to eql(output_fixture.signature)
  end

  it "can display a specific version of a cookbook" do
    cookbook = TestCook.create_cookbook

    command = run "knife cookbook site show #{cookbook.name} 0.1.0"

    command_output = CommandOutput.new(command.stdout)
    output_fixture = KnifeOutputFixture.new('latest', cookbook: cookbook)

    expect(command_output.signature).to eql(output_fixture.signature)
  end

  it "fails if given a missing version" do
    cookbook = TestCook.create_cookbook

    command = run "knife cookbook site show #{cookbook.name} dorfle"

    expect do
      command.error!
    end.to raise_error(Mixlib::ShellOut::ShellCommandFailed)
  end

end
