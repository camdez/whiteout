# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "whiteout/version"

Gem::Specification.new do |s|
  s.name        = "whiteout"
  s.version     = Whiteout::VERSION
  s.authors     = ["Cameron Desautels"]
  s.email       = ["camdez@gmail.com"]
  s.homepage    = "http://github.com/camdez/#{s.name}"
  s.summary     = %q{Remove trailing whitespace from files.}
  s.description = <<desc
  Removes trailing whitespace from standard input or from named files.
desc

  s.rubyforge_project = s.name

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
