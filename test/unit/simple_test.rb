require 'test/unit'

require File.dirname(__FILE__) + "/../../lib/misty"

class SimpleTest < Test::Unit::TestCase
  
  def test_simple
    simple = %q(
    project "badger_wars"
    key_pair "my_key_pair"
    region "eu-west-1"
    
    formation :dev do
      server_group :web do 
        instances 1
        size "m1.small"
        ami "ami-fb9ca98f"
        security_groups :default
      end
    end
    )
    
    defintition = Misty::Definition.new simple
    project = defintition.evaluate
    
    assert_equal "badger_wars", project.instance_variable_get(:@name)
    assert_equal "my_key_pair", project.instance_variable_get(:@key_pair)
    assert_equal "eu-west-1", project.instance_variable_get(:@region)
    
    formation = project.instance_variable_get(:@formations)[:dev]
    assert_equal :dev, formation.instance_variable_get(:@name)
    
    server_group = formation.instance_variable_get(:@server_groups)[:web]
    assert_equal 1, server_group.instance_variable_get(:@instances)
    assert_equal "m1.small", server_group.instance_variable_get(:@size)
    assert_equal "ami-fb9ca98f", server_group.instance_variable_get(:@ami)
    assert_equal [:default], server_group.instance_variable_get(:@security_groups)
  end
  
end
