$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'frisky-mongo/version'

Gem::Specification.new do |s|
  s.name         = 'frisky_mongo'
  s.version      = FriskyMongo::VERSION
  s.authors      = ['Pablo Fernandez']
  s.email        = ['heelhook@littleq.net']
  s.summary      = 'A mongodb backend for frisky'
  s.description  = 'A mongodb backend for frisky data models'

  s.add_runtime_dependency "mongo_mapper"

  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md Rakefile)
  s.require_path = 'lib'
end