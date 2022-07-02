# frozen_string_literal: true

require_relative 'lib/version.rb'

Gem::Specification.new do |s|
  s.name                  = 'hash-merkle-tree'
  s.version               = Merkle::VERSION
  s.authors               = ['tavrelkate']
  s.email                 = ['tavrelkate@gmail.com']
  s.summary               = 'Implementation of Hash Merkle Tree, audit and consistensy proofs'
  s.description           = 'Implementation of Hash Merkle Tree, audit and consistensy proofs'
  s.homepage              = 'https://github.com/tavrelkate/hash-merkle-tree'
  s.platform              = Gem::Platform::RUBY
  s.extra_rdoc_files      = ['README.md']
  s.license               = 'MIT'
  s.required_ruby_version = '>= 2.5.0'

  s.files = Dir[ 'lib/**/*.rb', 'README.md', 'hash-mekle-tree.gemspec' ]

  s.add_development_dependency 'rspec'
end
