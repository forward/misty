# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lib/version"

Gem::Specification.new do |s|
  s.name        = "misty"
  s.version     = Misty::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Spalding, Noah Cantor"]
  s.email       = ["jon.spalding@forward.co.uk"]
  s.homepage    = "http://github.com/forward/misty"
  s.summary     = %q{DSL for managing Amazon Cloud Formations}
  s.description = %q{DSL for managing Amazon Cloud Formations}

  s.add_dependency("fog", "~> 0.7.2")
  s.add_dependency("json", "~> 1.5.1")
  s.add_dependency("colored", "~> 1.2")
  
  # s.rubyforge_project = "."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
