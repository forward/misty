
dirname = File.dirname(__FILE__) + "/misty"

require "#{dirname}/definition"
require "#{dirname}/dsl"
require "#{dirname}/template"
require "#{dirname}/cli/cli"
require "#{dirname}/cli/create"
require "#{dirname}/cli/delete"
require "#{dirname}/cli/status"
require "#{dirname}/cli/ssh"
require "#{dirname}/cli/help"
