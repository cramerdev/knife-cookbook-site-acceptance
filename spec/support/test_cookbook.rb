require 'erb'

class TestCookbook
  attr_reader :name, :version
  attr_writer :version

  def initialize(unique_fragment)
    @base_name = 'supermarket-test'
    @name = [@base_name, unique_fragment].join('-')
    @version = '0.1.0'
    @cookbooks_home = File.expand_path('./spec/fixtures/cookbooks')
  end

  def destroy
    File.unlink(home)
  end

  def create
    File.symlink(origin, home)
    save
  end

  def save
    File.write(metadata_location, metadata)
  end

  def exists?
    File.exists?(home)
  end

  private

  def metadata
    cookbook = self

    ERB.new(metadata_template).result(binding)
  end

  def metadata_location
    File.join(home, 'metadata.rb')
  end

  def home
    File.join(@cookbooks_home, @name)
  end

  def origin
    File.join(@cookbooks_home, @base_name)
  end

  def metadata_template
    File.read(File.expand_path(File.join(origin, 'metadata.rb.erb')))
  end
end
