require 'spec_helper'

describe 'knife cookbook site search TERM' do
  it 'lists cookbooks' do
    search_cookbooks = run "knife cookbook site search a*"

    found_cookbooks = search_cookbooks.stdout.strip.scan(/^[^\s]+:/)

    expect(found_cookbooks.any?).to be_true
  end
end
