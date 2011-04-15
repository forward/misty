module Misty
  module CLI    
    class Ssh < Command
      include Config
      
      def run(args)
        res = client.describe_stack_resources("StackName" => stack_name(args[0]))
        
        compute = Fog::Compute.new(
          :provider           => 'AWS',
          :aws_access_key_id => config[:aws_access_key_id],
          :aws_secret_access_key => config[:aws_secret_access_key]
        )
                
        instance_id = res.body["StackResources"][args[0].to_i]["PhysicalResourceId"]
        dns_name = compute.describe_instances('instance-id' => instance_id).body["reservationSet"][0]["instancesSet"][0]["dnsName"]
        
        exec "ssh ubuntu@#{dns_name}"
      end
    end
  end
end