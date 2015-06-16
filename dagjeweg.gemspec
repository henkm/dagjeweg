# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dagjeweg/version'

Gem::Specification.new do |spec|
  spec.name          = "dagjeweg"
  spec.version       = Dagjeweg::VERSION
  spec.authors       = ["Henk Meijer"]
  spec.email         = ["meijerhenk@gmail.com"]
  spec.description   = %q{Communiceer met de API van DagjeWeg.NL en haal informatie op over dagjes weg}
  spec.summary       = %q{Communiceer met de API van DagjeWeg.NL en haal informatie op over dagjes weg}
  spec.homepage      = "http://www.dagjeweg.nl"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "fakeweb"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet", "~> 1" # for documentation
  spec.add_development_dependency "github-markup"
end
