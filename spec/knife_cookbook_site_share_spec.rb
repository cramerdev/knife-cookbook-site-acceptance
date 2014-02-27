require 'spec_helper'

describe 'knife cookbook site share' do
  it 'exits with status 0 when it succeeds' do
    cookbook = TestCookbook.new(Time.now.to_i)
    cookbook.create

    share = run "knife cookbook site share #{cookbook.name} Other"

    expect(share.exitstatus).to eql(0)
  end

  context 'when sharing the same version of an existing cookbook' do
    it 'shows an error' do
      cookbook = TestCook.create_cookbook

      share = run "knife cookbook site share #{cookbook.name} Other"

      command_output = CommandOutput.new(share.stderr)
      output_fixture = KnifeOutputFixture.new('share_error')

      expect(command_output.signature).to eql(output_fixture.signature)
    end

    it 'exits with status 1' do
      cookbook = TestCook.create_cookbook

      share = run "knife cookbook site share #{cookbook.name} Other"

      expect(share.exitstatus).to eql(1)
    end
  end
end
