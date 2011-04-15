module Misty
  module CLI
    def self.command_for(comm)
      command = Misty::Command.const_get(comm.capitalize).new
      command.load_config
      command
    end
  end
end