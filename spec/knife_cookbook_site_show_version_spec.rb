require 'spec_helper'

describe 'knife cookbook site show COOKBOOK VERSION' do

  it "can display the latest version of a cookbook" do
    command = run "knife cookbook site show #{cookbook_name} latest"

    expect(signature_of(command.stdout.strip)).
      to eql(expected_signature("supermarket-test_latest"))
  end

  it "can display a specific version of a cookbook" do
    command = run "knife cookbook site show #{cookbook_name} 0.1.0"

    expect(signature_of(command.stdout.strip)).
      to eql(expected_signature("supermarket-test_latest"))
  end

  it "fails if given a missing version" do
    command = run "knife cookbook site show #{cookbook_name} dorfle"

    expect do
      command.error!
    end.to raise_error(Mixlib::ShellOut::ShellCommandFailed)
  end

end
