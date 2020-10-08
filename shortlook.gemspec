# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'shortlook/version'

Gem::Specification.new do |spec|
  spec.name          = 'shortlook'
  spec.license       = 'MIT'
  spec.version       = Shortlook::VERSION
  spec.authors       = ['Marco Roth']
  spec.email         = ['marco.roth@intergga.ch']
  spec.summary       = 'ShortLook CLI for scaffoling a ShortLook Provider'
  spec.description   = 'ShortLook CLI for scaffoling a ShortLook Provider'
  spec.homepage      = 'https://github.com/marcoroth/shortlook-cli'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'lhc', '>= 13.0'
  spec.add_dependency 'pastel', '~> 0.7.2'
  spec.add_dependency 'thor', '>= 0.20', '< 1.1'
  spec.add_dependency 'tty-command', '>= 0.8', '< 0.10'
  spec.add_dependency 'tty-config', '>= 0.3', '< 0.5'
  spec.add_dependency 'tty-prompt', '>= 0.18', '< 0.22'
  spec.add_dependency 'tty-spinner', '~> 0.9.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.92.0'
end
