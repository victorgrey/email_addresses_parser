# -*- encoding: utf-8 -*-
require File.expand_path('../lib/email_addresses_parser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Victor Grey"]
  gem.email         = ["victor@metacnx.com"]
  gem.description   = %q{Parse a list of emails pasted into a web form.}
  gem.summary       = %q{Parse a list of emails pasted into a web form, returning a hash with valid emails as keys and associated data (i.e. names) as values.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "email_addresses_parser"
  gem.require_paths = ["lib"]
  gem.version       = EmailAddressesParser::VERSION
end
