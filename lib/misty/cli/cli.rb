module Misty
  module CLI
    def self.command_for(comm)
      unless (Misty::CLI::Commands.const_defined?(comm.capitalize))
        raise Misty::CLI::Error.new("No command named #{comm} exists. Run 'misty help' for valid commands.".red)
      end
      Misty::CLI::Commands.const_get(comm.capitalize).new(load_project) 
    end
    
    def self.load_project
      project_file = File.join(Dir.pwd, "Mistfile")
      return nil unless (File.exists?(project_file))
        
      mistfile = File.read(project_file)
      Misty::Definition.new(mistfile).evaluate
    end
    
    class Command
      def initialize(project)
        @project = project
      end
    end
    
    class Error < Exception
      attr_reader :message
      def initialize(msg)
        @message = msg
      end
    end
  end
  
  module Config
    def config
      {
        :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
        :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
      }
    end
    
    def stack_name(formation)
      "#{@project._name}-#{@project._formations[formation.to_sym]._name}-stack"
    end
    
    def client
      Fog::AWS::CloudFormation.new(
       :aws_access_key_id => config[:aws_access_key_id],
       :aws_secret_access_key => config[:aws_secret_access_key]
      )
    end
  end
end