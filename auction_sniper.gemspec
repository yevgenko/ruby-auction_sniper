
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "auction_sniper/version"

Gem::Specification.new do |spec|
  spec.name          = "auction_sniper"
  spec.version       = AuctionSniper::VERSION
  spec.authors       = ["Yevhen V."]
  spec.email         = ["wik@bdhr.co"]

  spec.summary       = %q{An application that automatically bids in auctions}

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'xmpp4r', '~> 0.5.6'
  spec.add_dependency 'faye-websocket', '~> 0.10.7'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'capybara', '~> 2.18'
  spec.add_development_dependency 'byebug', '~> 10.0'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'chromedriver-helper'
  spec.add_development_dependency 'thin', '~> 1.7', '>= 1.7.2'
  spec.add_development_dependency 'simplecov'
end
