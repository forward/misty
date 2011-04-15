module Misty
  module CLI    
    class Status < Command
      include Config
      
      def run(args)
        res = client.describe_stack_resources("StackName" => stack_name(args[0]))
        
        compute = Fog::Compute.new(
          :provider           => 'AWS',
          :aws_access_key_id => config[:aws_access_key_id],
          :aws_secret_access_key => config[:aws_secret_access_key]
        )
                
        res.body["StackResources"].each_with_index do |instance, i| 
          details = compute.describe_instances('instance-id' => instance["PhysicalResourceId"]).body["reservationSet"][0]["instancesSet"][0]
          
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
    end
  end
end