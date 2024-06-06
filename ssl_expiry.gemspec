
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ssl_expiry/version"

Gem::Specification.new do |spec|
  spec.name          = "ssl_expiry"
  spec.version       = SSLExpiry::VERSION
  spec.authors       = ['Tim Gurney aka Wolf']
  spec.email         = ['wolf@tgwolf.com']

  spec.summary       = %q{A simple gem checking for ssl expiry.}
  spec.description   = %q{A simple gem checking for ssl expiry.}
  spec.homepage      = 'https://github.com/AntiPhotonltd/ssl_expiry'
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.17", "< 3.0"
  spec.add_development_dependency "rake", "~> 13.2"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency 'openssl', '~> 3'
  spec.add_development_dependency 'net-http-persistent', '~> 4'

  spec.add_runtime_dependency 'openssl', '~> 3'
  spec.add_runtime_dependency 'net-http-persistent', '~> 4'
end
