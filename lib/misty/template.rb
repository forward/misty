module Misty
  class Template
    def initialize(project)
      @project = project
    end
    
    def generate(formation_name)
      hash = {
        "AWSTemplateFormatVersion" => "2010-09-09",
        "Description" => "Misty generated template for #{@project._name}",
        "Resources" => resources(@project._formations[formation_name]),
      }
    end
    
    private
    def resources(formation)
      res = {}
      
      formation._server_groups.each do |name, server_group|
        security_groups = server_group._security_groups.is_a?(Array) ? server_group._security_groups.map{|sg| sg.to_s} : [server_group._security_groups.to_s]
        
        server_group._instances.times do |i|
          res["#{name}ServerGroupInstance#{i}"] = {
            "Type" => "AWS::EC2::Instance",
            "Properties" => {
              "KeyName" => @project._key_pair,
              "ImageId" => server_group._ami,
              "InstanceType" => server_group._size,
              "SecurityGroups" => security_groups
            }
          }
        end
      end
      res
    end
  end
  
  module AttributeAccessor
    def method_missing(m, *args)
      instance_variable_get("@#{m.to_s.sub(/_/, '')}".to_sym) if (m.to_s =~ /^_/)
    end
  end
  
  class Dsl::Project; include AttributeAccessor; end
  class Dsl::Formation; include AttributeAccessor; end
  class Dsl::ServerGroup; include AttributeAccessor; end
end