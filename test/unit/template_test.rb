require 'rubygems'
require 'test/unit'
require 'json'

require File.dirname(__FILE__) + "/../../lib/misty"

class TemplateTest < Test::Unit::TestCase

  def test_template
    simple = %q(
    project "badger_wars"
    key_pair "ih-key"
    region "us-east-1"
    
    formation :dev do
      server_group :web do 
        instances 1
        size "m1.small"
        ami "ami-ccf405a5"
        security_groups :default
      end
    end
    )
    
    defintition = Misty::Definition.new simple
    project = defintition.evaluate
    
    template = Misty::Template.new project
    hash = template.generate(:dev)
    
    File.open("test_template.json", "w") do |f|
      f.write hash.to_json
    end
    
    assert_equal "Misty generated template for badger_wars", hash["Description"]
    assert_equal "ih-key", hash["Resources"]["Ec2Instance"]["Properties"]["KeyName"]
    assert_equal "ami-ccf405a5", hash["Resources"]["Ec2Instance"]["Properties"]["ImageId"]
    
  end

end