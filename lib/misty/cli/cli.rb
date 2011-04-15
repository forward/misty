module Misty
  module CLI
    def self.command_for(comm)
      Misty::CLI.const_get(comm.capitalize).new
    end
  end
  
  module Config
    def config
      {
        :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
        :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
      }
    end
    
    def load_project
      mistfile = File.read(File.join(Dir.pwd, "Mistfile"))
      
      Misty::Definition.new(mistfile).evaluate
    end
    
    def stack_name(project, formation)
      "#{project._name}-#{project._formations[formation.to_sym]._name}-stack"
    end
    
    def client
      Fog::AWS::CloudFormation.new(
       :aws_access_key_id => config[:aws_access_key_id],
       :aws_secret_access_key => config[:aws_secret_access_key]
      )
    end
  end
end