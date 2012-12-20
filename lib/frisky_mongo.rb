require 'frisky-mongo/version'
require 'frisky-mongo/config'

module Frisky
  module Model
    EXTENSIONS ||= []
    EXTENSIONS << 'frisky-mongo/models/event'
    EXTENSIONS << 'frisky-mongo/models/person'
    EXTENSIONS << 'frisky-mongo/models/commit'
    EXTENSIONS << 'frisky-mongo/models/file_commit'
    EXTENSIONS << 'frisky-mongo/models/repository'
  end
end
