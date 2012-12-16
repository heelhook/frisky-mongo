module Frisky
  module Model
    class Event
      include MongoMapper::Document

      key :type, String

      def self.exists?(raw)
        self.collection.find_one(type: raw.type, _id: raw.id) != nil
      end
    end
  end
end