# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rql/version"

Gem::Specification.new do |s|
  s.name        = "rql"
  s.version     = Rql::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Heimbuch"]
  s.email       = ["rheimbuch@gmail.com"]
  s.homepage    = "https://github.com/rheimbuch/rql-ruby"
  s.summary     = %q{RQL Parsing and Querying}
  s.description = %q{Allows querying of ruby data-structures/source using RQL (Resource Query Language).}

  s.rubyforge_project = "rql"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("execjs", "~> 0.1.1")
end
