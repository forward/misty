module Misty
  module CLI::Commands    
    class Delete < Misty::CLI::Command
      
      def run(args)        
        res = cloud_formation_client.delete_stack(@project.stack_name(args[0]))
        p res
      end
      
      def self.description
        "Usage 'misty delete FORMATION_NAME'"
      end
      
    end
  end
end