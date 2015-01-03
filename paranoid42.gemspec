# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paranoid42/version'

Gem::Specification.new do |gem|
  gem.name          = "paranoid42"
  gem.version       = Paranoid42::VERSION
  gem.authors       = ["effektz", "nitsujw", "yury"]
  gem.email         = ["alexweidmann@gmail.com", "nitsujweidmann@gmail.com", "yury.korolev@gmail.com"]
  gem.description   = %q{paranoid models for rails 4.2}
  gem.summary       = %q{paranoid models for rails 4.2}
  gem.homepage      = "https://github.com/effektz/paranoid42"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord', '>= 4.2.0'

  gem.add_development_dependency "rake"
  gem.add_development_dependency "sqlite3"
end
