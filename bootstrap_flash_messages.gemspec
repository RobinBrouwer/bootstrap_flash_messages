# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bootstrap_flash_messages/version"

Gem::Specification.new do |s|
  s.name        = "bootstrap_flash_messages"
  s.version     = BootstrapFlashMessages::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robin Brouwer"]
  s.email       = ["robin@sparkforce.nl"]
  s.homepage    = "http://www.sparkforce.nl"
  s.summary     = %q{Bootstrap alerts and Rails flash messages combined in one easy-to-use gem.}
  s.description = %q{Bootstrap alerts and Rails flash messages combined in one easy-to-use gem.}
  
  s.rubyforge_project = "nowarning"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
