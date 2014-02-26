require 'mixlib/shellout'

module CommandLineHelpers

  def run(command)
    Mixlib::ShellOut.new(command).tap(&:run_command)
  end

  def run!(command)
    run(command).error!
  end

end
