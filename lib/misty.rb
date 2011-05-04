require "rubygems"
require 'json'
require 'fog'
require 'colored'

dirname = File.dirname(__FILE__) + "/misty"

require "#{dirname}/project"
require "#{dirname}/definition"
require "#{dirname}/config"
require "#{dirname}/dsl"
require "#{dirname}/template"
require "#{dirname}/cli/command"
require "#{dirname}/cli/create"
require "#{dirname}/cli/delete"
require "#{dirname}/cli/status"
require "#{dirname}/cli/ssh"
require "#{dirname}/cli/help"
require "#{dirname}/cli/cli"
