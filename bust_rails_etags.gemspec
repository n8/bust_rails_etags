# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bust_rails_etags/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["nate"]
  gem.email         = ["nate@cityposh.com"]
  gem.description   = %q{Helps you bust your rails etags on new deploys.}
  gem.summary       = %q{Allows you to set ENV["ETAG_VERSION_ID"] in an initializer to that deploys will create new versions of your etags.}
  gem.homepage      = "https://github.com/n8/bust_rails_etags"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bust_rails_etags"
  gem.require_paths = ["lib"]
  gem.version       = BustRailsEtags::VERSION
end
