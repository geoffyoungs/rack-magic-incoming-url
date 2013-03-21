# -*- encoding: utf-8 -*-
#
Gem::Specification.new do |gem|
  gem.authors       = ["Geoff Youngs"]
  gem.email         = ["git@intersect-uk.co.uk"]
  gem.description   = <<-EOD
A simple piece of rack middleware to redirect certain URLs when they are
navigated to directly.

Designed for use with sites where the same site is served across several domain names
that each highlight different specialities.
EOD
  gem.summary       = %q{Redirect incoming visitors based on domain / url}
  gem.homepage      = "http://github.com/geoffyoungs/rack-magic-incoming-url"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rack-magic-incoming-url"
  gem.require_paths = ["lib"]
  gem.version       = '0.0.1'
  gem.add_dependency("rack")
  gem.add_development_dependency("rack-test")
end
