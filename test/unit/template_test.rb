require 'rubygems'
require 'test/unit'
require 'json'

require File.dirname(__FILE__) + "/../../lib/misty"

class TemplateTest < Test::Unit::TestCase

  def test_single_server_group
    simple = %q(
    project "badger_wars"
    key_pair "ih-key"
    region "us-east-1"
    
    formation :dev do
      server_group :web do 
        instances 2
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
    assert_equal "ih-key", hash["Resources"]["webServerGroupInstance0"]["Properties"]["KeyName"]
    assert_equal "ih-key", hash["Resources"]["webServerGroupInstance1"]["Properties"]["KeyName"]
    assert_equal "ami-ccf405a5", hash["Resources"]["webServerGroupInstance0"]["Properties"]["ImageId"]
    assert_equal "ami-ccf405a5", hash["Resources"]["webServerGroupInstance1"]["Properties"]["ImageId"]
    assert_equal "m1.small", hash["Resources"]["webServerGroupInstance0"]["Properties"]["InstanceType"]
    assert_equal "m1.small", hash["Resources"]["webServerGroupInstance1"]["Properties"]["InstanceType"]
    assert_equal ["default"], hash["Resources"]["webServerGroupInstance0"]["Properties"]["SecurityGroups"]
    assert_equal ["default"], hash["Resources"]["webServerGroupInstance1"]["Properties"]["SecurityGroups"]
    
  end

end