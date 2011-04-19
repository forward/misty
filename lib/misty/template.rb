require 'erb'

module Misty
  class Template
    attr_accessor :hostname
    
    def initialize(project)
      @project = project
    end
    
    def generate(formation_name)
      hash = {
        "AWSTemplateFormatVersion" => "2010-09-09",
        "Description" => "Misty generated template for #{@project.name}",
        "Resources" => resources(@project.formations[formation_name]),
      }
    end
    
    private
    def resources(formation)
      res = {}
      
      formation.server_groups.each do |name, server_group|
        security_groups = server_group.security_groups.is_a?(Array) ? server_group.security_groups.map{|sg| sg.to_s} : [server_group.security_groups.to_s]
        
        server_group.instances.times do |i|
          hostname = "#{@project.name}-#{formation.name}-#{name}-#{i}-#{Time.now.to_i}"
          
          res["#{name}ServerGroupInstance#{i}"] = {
            "Type" => "AWS::EC2::Instance",
            "Properties" => {
              "KeyName" => @project.key_pair,
              "ImageId" => server_group.ami,
              "InstanceType" => server_group.size,
              "SecurityGroups" => security_groups,
              "Tags" => [
                {"Key" => "Name", "Value" => hostname},
                {"Key" => "Project", "Value" => @project.name},
                {"Key" => "Formation", "Value" => formation.name},
                {"Key" => "ServerGroup", "Value" => name},
                {"Key" => "Index", "Value" => i}
              ]
            }            
          }
          
          user_data_file = File.join(Dir.pwd, "config", "instance", "user-data.erb")
          if (File.exists?(user_data_file))
            template = ERB.new(File.read(user_data_file))
            
            res["#{name}ServerGroupInstance#{i}"]["Properties"]["UserData"] = {              
              "Fn::Base64" => template.result(binding)
            }
          end
          
        end
      end
      res
    end
  end
end