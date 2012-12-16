module Frisky
  module Model
    class Person < Base
      include MongoMapper::Document
    end
  end
end