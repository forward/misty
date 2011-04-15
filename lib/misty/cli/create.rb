module Misty
  module CLI    
    class Create
      def run(args)
        mistfile = File.read(File.join(Dir.pwd, "Mistfile"))
        
        project = Misty::Definition.new(mistfile).evaluate
        template = Misty::Template.new(project)
        
        template_body = template.generate(args[0].to_sym).to_json
        
        cf = Fog::AWS::CloudFormation.new(
         :aws_access_key_id => config[:aws_access_key_id],
         :aws_secret_access_key => config[:aws_secret_access_key]
        )
        
        p config
        
        res = cf.create_stack("#{project._name}Stack", "TemplateBody" => template_body)
        p res
      end
      
      def config
        @config ||= YAML.load(File.read(File.join(Dir.pwd, "ec2.yml")))
      end
    end
  end
end