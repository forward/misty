module Misty
  module CLI::Commands    
    class Create < Misty::CLI::Command
      
      def run(args)
        template = Misty::Template.new(@project)
        
        template_body = template.generate(args[0].to_sym).to_json
                
        res = cloud_formation_client.create_stack(@project.stack_name(args[0]), "TemplateBody" => template_body)
        p res
      end
      
      def self.description
        "Usage 'misty create FORMATION_NAME'"
      end
    end
  end
end