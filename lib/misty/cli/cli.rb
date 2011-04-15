module Misty
  module CLI
    def self.command_for(comm)
      Misty::CLI.const_get(comm.capitalize).new
    end
  end
end