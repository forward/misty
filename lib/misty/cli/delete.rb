module Misty
  module CLI    
    class Delete
      include Config
      
      def run(args)        
        project = load_project

        res = client.delete_stack(stack_name(project, args[0]))
        p res
      end
    end
  end
end