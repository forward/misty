module Misty
  module InstanceMethods
    def attribute(attr_name)
      instance_variable_get(attr_name)
    end
  end
  
  class Dsl::Project; include InstanceMethods;end
  class Dsl::Formation; include InstanceMethods;end
  class Dsl::ServerGroup; include InstanceMethods;end
  
  class Template
    def initialize(project)
      @project = project
    end
    
    def generate(formation_name)
      hash = {
        "AWSTemplateFormatVersion" => "2010-09-09",
        "Description" => "Misty generated template for #{@project.attribute(:@name)}",
        "Resources" => {
          "Ec2Instance" => {
            "Type" => "AWS::EC2::Instance",
            "Properties" => {
              "KeyName" => @project.attribute(:@key_pair),
              "ImageId" => @project.attribute(:@formations)[formation_name].attribute(:@server_groups)[:web].attribute(:@ami)
            }
          }
        },
        "Outputs" => {
          "InstanceId" => {
             "Description" => "The InstanceId of the newly created EC2 instance",
             "Value" => { "Ref" => "Ec2Instance" }
           }
        }
      }
    end
  end
end

%q(
{
    "Description" : "Create an EC2 instance running the Amazon Linux 32 bit AMI.”
    "Parameters" : {
        "KeyPair" : {
            "Description" : "The EC2 Key Pair to allow SSH access to the instance",       
            "Type" : "String"
        }
    },
    "Resources" : {
        "Ec2Instance" : {
            "Type" : "AWS::EC2::Instance",
            "Properties" : {
                "KeyName" : { "Ref" : "KeyPair" },
                "ImageId" : "ami-75g0061f"
            }
        }
    },
    "Outputs" : {
        "InstanceId" : {
             "Description" : "The InstanceId of the newly created EC2 instance",
             "Value" : { "Ref" : "Ec2Instance" }
         }
    },
    "AWSTemplateFormatVersion" : "2010-09-09"
}
)