require 'spec_helper'

describe 'knife cookbook site download COOKBOOK' do

  it 'indicates the version that will be downloaded' do
    cookbook = TestCook.create_cookbook

    command = run "knife cookbook site download #{cookbook.name}"

    download_status = command.stdout.lines[0].strip

    expect(download_status).to include("version #{cookbook.version}")
  end

  it 'downloads the tarball' do
    cookbook = TestCook.create_cookbook

    command = run "knife cookbook site download #{cookbook.name}"

    filename = "#{cookbook.name}-#{cookbook.version}.tar.gz"

    expect(TestCook.downloads.include?(filename)).to eql(true)
  end

end
