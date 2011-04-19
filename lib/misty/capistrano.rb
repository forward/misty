require 'misty'

module Capistrano
  class Configuration
    module MistyRoles
      include Misty::Config

      def misty_role(formation, role_name, tag=role_name)        
        project = Misty::Definition.load_project
        
        res = cloud_formation_client.describe_stack_resources("StackName" => project.stack_name(formation.to_s))
        
        dns_names = []
        res.body["StackResources"].each do |instance| 
          details = ec2_client.describe_instances('instance-id' => instance["PhysicalResourceId"]).body["reservationSet"][0]["instancesSet"][0]
          
          dns_names << details["dnsName"] if details["tagSet"]["Roles"].split(/\s*,\s*/).include?(tag.to_s)
        end
        
        puts "WARNING: No instances found for project with tag 'ServerGroup' => '#{tag}'." if dns_names.empty?
        
        role role_name, *dns_names
      end
    end
    
    # def matches?(instance, role, project)
    #       instance[:aws_state] == "running" && 
    #       instance[:tags]["Project"] && 
    #       instance[:tags]["Project"] == project && 
    #       instance[:tags]["Roles"] && 
    #       instance[:tags]["Roles"].split(/\s*,\s*/).include?(role.to_s)
    #     end
    
    include MistyRoles
  end
end