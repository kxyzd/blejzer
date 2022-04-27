# frozen_string_literal: true

require 'rake'

require_relative 'lib/blejzer/version'

Gem::Specification.new do |s|
  s.name        = 'blejzer'
  s.version     = Blejzer::VERSION
  s.licenses    = ['MIT']
  s.summary     = 'Gem for easy and compact serialization of objects.'
  s.description = 'A gem for simple and compact serialization of Ruby objects into binary format. Toy implementation.'
  s.authors     = ['kxyzd']
  s.email       = 'kxyzd@vk.com'
  s.files       = FileList['lib/**/*.rb']
  s.homepage    = 'https://github.com/kxyzd/blejzer'
  s.metadata    = { 'source_code_uri' => 'https://github.com/kxyzd/blejzer',
                    'rubygems_mfa_required' => 'true' }
end
