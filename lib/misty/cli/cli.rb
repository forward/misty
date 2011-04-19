module Misty
  module CLI
    def self.command_for(comm)
      unless (Misty::CLI::Commands.const_defined?(comm.capitalize))
        raise Misty::CLI::Error.new("No command named #{comm} exists. Run 'misty help' for valid commands.".red)
      end
      Misty::CLI::Commands.const_get(comm.capitalize).new(Misty::Definition.load_project) 
    end
        
    class Error < Exception
      attr_reader :message
      def initialize(msg)
        @message = msg
      end
    end
  end
end