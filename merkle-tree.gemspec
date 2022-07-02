# frozen_string_literal: true

require_relative 'lib/version.rb'

Gem::Specification.new do |s|
  s.name = 'merkle-tree'
  s.version               = Merkle::VERSION
  s.authors               = ['tavrelkate']
  s.email                 = ['tavrelkate@gmail.com']
  s.summary               = 'Implementation of Merkle Hash Tree, audit and consistensy proofs'
  s.description           = 'Implementation of Merkle Hash Tree, audit and consistensy proofs'
  s.homepage              = 'https://github.com/tavrelkate/merkle-tree'
  s.platform              = Gem::Platform::RUBY
  s.extra_rdoc_files      = ['README.md']
  s.license               = 'MIT'
  s.required_ruby_version = '>= 2.5.0'

  s.files = Dir[ 'lib/**/*.rb',
    'README.md', 'mekle-tree.gemspec'
  ]

  s.add_development_dependency 'rspec'
end
