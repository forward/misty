module Misty
  module CLI    
    class Create < Command
      include Config
      
      def run(args)
        template = Misty::Template.new(@project)
        
        template_body = template.generate(args[0].to_sym).to_json
                
        res = client.create_stack(stack_name(args[0]), "TemplateBody" => template_body)
        p res
      end
    end
  end
end