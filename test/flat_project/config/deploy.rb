require 'misty/capistrano'
require 'capistrano/ext/multistage'

set :application, "myapp"
set :repository, "."
set :scm, :none
set :deploy_via, :copy

set :stages, %w(foo prod)
set :default_stage, "foo"
