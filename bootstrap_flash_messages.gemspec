# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bootstrap_flash_messages/version"

Gem::Specification.new do |s|
  s.name        = "bootstrap_flash_messages"
  s.version     = BootstrapFlashMessages::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robin Brouwer"]
  s.email       = ["robin@sparkforce.nl"]
  s.homepage    = "https://github.com/RobinBrouwer/bootstrap_flash_messages"
  s.summary     = "Bootstrap alerts for Rails flash messages."
  s.description = "Bootstrap alerts and Rails flash messages combined in one easy-to-use gem."
  s.license     = "MIT"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 3.0"
end
