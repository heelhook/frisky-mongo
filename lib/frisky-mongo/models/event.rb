module Frisky
  module Model
    class Event
      include MongoMapper::Document

      key :type, String
      key :public, Boolean
      key :payload, Hash
      key :repository_id, ObjectId
      key :actor_id, ObjectId
      key :commit_ids, Array, default: nil
      key :ref, String
      key :head, String
      key :created_at, String

      belongs_to :actor, class_name: 'Frisky::Model::Person'
      belongs_to :repository, class_name: 'Frisky::Model::Repository'

      many :commits, in: :commit_ids, class_name: 'Frisky::Model::Commit'

      def self.load_from_hashie(hashie)
        e = Event.find(hashie.id)
        e.actor = Person.find(e.actor_id)
        e.repository = Repository.find(e.repository_id)
        e.commits = e.commit_ids.map {|id| Commit.find(id) }
        e
      end

      def serialize
        # Save all related
        self.actor.save!
        self.repository.save!
        self.commit_ids ||= []
        self.commits.each {|c| c.save!; self.commit_ids << c._id unless self.commit_ids.include? c._id }

        self.actor_id = self.actor.id
        self.repository_id = self.repository.id

        self.save!

        self.to_json
      end

      def self.exists?(raw)
        self.collection.find_one(type: raw.type, _id: raw.id) != nil
      end
    end
  end
end