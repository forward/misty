module Misty
  module Config
    def credentials
      {
        :aws_access_key_id => ENV["AWS_ACCESS_KEY_ID"],
        :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
      }
    end
  
    def ec2_client
      Fog::Compute.new(credentials.merge(:provider => 'AWS'))
    end
    
    def cloud_formation_client
      Fog::AWS::CloudFormation.new credentials
    end
  end
end