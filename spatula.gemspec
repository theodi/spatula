# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spatula/version'

Gem::Specification.new do |spec|
  spec.name          = 'spatula'
  spec.version       = Spatula::VERSION
  spec.authors       = ['pikesley']
  spec.email         = ['sam@theodi.org']

  spec.summary       = %q{Common rake tasks for our test-kitchen stuff}
  spec.description   = %q{Prepares databases and that}
  spec.homepage      = 'http://theodi.org'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'mysql2', '~> 0.3'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'guard-rspec', '~> 4.6'
  spec.add_development_dependency 'rspec-shell-expectations', '~> 1.3'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6'
end
