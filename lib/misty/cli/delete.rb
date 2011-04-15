module Misty
  module CLI    
    class Delete < Command
      include Config
      
      def run(args)        
        res = client.delete_stack(stack_name(args[0]))
        p res
      end
    end
  end
end