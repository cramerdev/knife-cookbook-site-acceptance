require 'spec_helper'

describe 'knife cookbook site list' do
  it 'lists all cookbooks' do
    cookbook = TestCook.create_cookbook

    list_cookbooks = run 'knife cookbook site list'
    all_cookbooks = list_cookbooks.stdout.strip.lines.map do |line|
      line.strip.split(/\s+/).map(&:strip)
    end.flatten

    expect(all_cookbooks.size >= 1).to be_true
    expect(all_cookbooks.include?(cookbook.name)).to be_true
  end
end
