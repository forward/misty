require 'test/unit'

require File.dirname(__FILE__) + "/../../lib/misty"

class SimpleTest < Test::Unit::TestCase
  
  def test_simple
    simple = %q(
    project "badger_wars"
    key_pair "my_key_pair"
    region "eu-west-1"
    )
    
    defintition = Misty::Definition.new simple
    project = defintition.evaluate
    
    assert_equal "badger_wars", project.instance_variable_get(:@name)
    assert_equal "my_key_pair", project.instance_variable_get(:@key_pair)
    assert_equal "eu-west-1", project.instance_variable_get(:@region)
  end
  
end
