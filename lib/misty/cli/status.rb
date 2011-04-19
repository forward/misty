module Misty
  module CLI::Commands    
    class Status < Misty::CLI::Command
      include Config
      
      def run(args)
        res = cloud_formation_client.describe_stack_resources("StackName" => @project.stack_name(args[0]))     
           
        res.body["StackResources"].each_with_index do |instance, i| 
          details = ec2_client.describe_instances('instance-id' => instance["PhysicalResourceId"]).body["reservationSet"][0]["instancesSet"][0]
          
          puts sprintf "%-11s:   %-40s %-12s %-12s %-21s %-62s %-14s (%s)",
            i.to_s.magenta, 
            details["tagSet"]['Name'], 
            instance["PhysicalResourceId"], 
            details["instanceType"],
            "[#{instance_state(details)}]",
            details["dnsName"].blue, 
            details["placement"]["availabilityZone"], 
            details["tagSet"]["ServerGroup"].yellow
        end
      end
      
      def instance_state(instance)
        instance["instanceState"]["name"] == "running" ? instance["instanceState"]["name"].green : instance["instanceState"]["name"].red
      end
      
      def self.description
        "Usage 'misty status FORMATION_NAME'"
      end
      
    end
  end
end