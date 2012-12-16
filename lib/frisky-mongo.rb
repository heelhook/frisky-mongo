require 'frisky-mongo/version'
require 'frisky-mongo/config'

module Frisky
  module Model
    EXTENSIONS ||= []
    EXTENSIONS << 'frisky-mongo/models/event'
    EXTENSIONS << 'frisky-mongo/models/person'
  end
end
