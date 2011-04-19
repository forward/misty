module Misty
  module CLI::Commands    
    class Delete < Misty::CLI::Command
      include Config
      
      def run(args)        
        res = client.delete_stack(stack_name(args[0]))
        p res
      end
      
      def self.description
        "Usage 'misty delete FORMATION_NAME'"
      end
      
    end
  end
end