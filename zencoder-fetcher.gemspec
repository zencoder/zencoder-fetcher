# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'zencoder_fetcher_version'

Gem::Specification.new do |s|
  s.name          = "zencoder-fetcher"
  s.version       = ZencoderFetcher.version
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Chris Warren", "Brandon Arbini"]
  s.email         = ["chris@zencoder.com", "b@zencoder.com"]
  s.homepage      = "http://github.com/zencoder/zencoder-fetcher"
  s.summary       = "Fetches notifications from Zencoder for local development."
  s.description   = "Fetches notifications from Zencoder for local development where Zencoder is unable to communicate to the server, usually because it's localhost."
  s.requirements  = "A Zencoder Account - http://zencoder.com"
  s.executables   << "zencoder_fetcher"
  s.add_dependency "trollop"
  s.add_dependency "httparty"
  s.add_dependency "json"
  s.add_dependency "activesupport"
  s.add_dependency "i18n"
  s.files         = Dir.glob("bin/**/*") + Dir.glob("lib/**/*") + %w(LICENSE README.rdoc)
  s.require_path  = 'lib'
end
