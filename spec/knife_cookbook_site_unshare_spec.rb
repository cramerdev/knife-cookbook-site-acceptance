require 'spec_helper'

describe 'knife cookbook site unshare' do
  it 'exits with status 0 when it succeeds' do
    cookbook = TestCook.create_cookbook

    unshare = run "knife cookbook site unshare #{cookbook.name} -y"
    cookbook.destroy

    expect(unshare.exitstatus).to eql(0)
  end

  it 'exits with status 100 when trying to unshare a non-existent cookbook' do
    cookbook = TestCookbook.new('non-existent')
    cookbook.create

    unshare = run "knife cookbook site unshare #{cookbook.name} -y"

    expect(unshare.exitstatus).to eql(100)
  end

  it 'shows an error when trying to unshare a non-existent cookbook' do
    cookbook = TestCookbook.new('non-existent-round-two')
    cookbook.create

    unshare = run "knife cookbook site unshare #{cookbook.name} -y"

    command_output = CommandOutput.new(unshare.stderr)
    output_fixture = KnifeOutputFixture.new('unshare_error')

    expect(command_output.signature).to eql(output_fixture.signature)
  end
end
