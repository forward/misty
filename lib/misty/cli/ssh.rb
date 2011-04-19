module Misty
  module CLI::Commands    
    class Ssh < Misty::CLI::Command
      include Config
      
      def run(args)
        res = cloud_formation_client.describe_stack_resources("StackName" => @project.stack_name(args[0]))
                
        instance_id = res.body["StackResources"][args[0].to_i]["PhysicalResourceId"]
        dns_name = ec2_client.describe_instances('instance-id' => instance_id).body["reservationSet"][0]["instancesSet"][0]["dnsName"]
        
        exec "ssh ubuntu@#{dns_name}"
      end
      
      def self.description
        "Usage 'misty ssh FORMATION_NAME INSTANCE_INDEX'. N.B. The INSTANCE_INDEX is returned by the 'status' command"
      end
    end
  end
end