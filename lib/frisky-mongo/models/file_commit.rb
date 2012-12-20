module Frisky
  module Model
    class FileCommit < ProxyBase
      include MongoMapper::Document

      primary_fetch do |args|
        FileCommit.where(repository_id: args[:repository].id,
                         commit_id: args[:commit].id,
                         path: args[:path]).first or raise NotFound
      end

      key :changes, Integer
      key :path, String
      key :deletions, Integer
      key :status, String
      key :patch, String
      key :additions, Integer
      key :sha, String
      key :type, String
      key :repository_id, ObjectId
      key :commit_id, ObjectId

      belongs_to :commit, class_name: 'Frisky::Model::Commit'
      belongs_to :repository, class_name: 'Frisky::Model::Repository'

      proxy_methods commit: lambda { Commit.find(commit_id) }
      proxy_methods repository: lambda { Repository.find(repository_id) }

      def save(*args)
        self.repository.save if self.repository
        self.commit.save if self.commit

        self.repository_id    ||= self.repository.id
        self.commit_id        ||= self.commit.id if self.commit

        super(*args)
      end
    end
  end
end