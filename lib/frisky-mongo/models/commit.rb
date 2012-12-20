module Frisky
  module Model
    class Commit < ProxyBase
      include MongoMapper::Document

      primary_fetch do |args|
        c = Commit.find(args[:id]) if args[:id]
        c ||= Commit.where(args).first if args.any?
        c or raise NotFound
      end

      key :author_id, ObjectId
      key :message, String
      key :parent_ids, Array
      key :repository_id, ObjectId
      key :stats, Hash
      key :committer_id, ObjectId
      key :file_ids, Array
      key :tree, String
      key :date, Time
      key :sha, String

      belongs_to :author, class_name: 'Frisky::Model::Person'
      belongs_to :committer, class_name: 'Frisky::Model::Person'
      belongs_to :repository, class_name: 'Frisky::Model::Repository'

      many :parents, in: :parent_ids, class_name: 'Frisky::Model::Commit'
      many :files, in: :file_ids, class_name: 'Frisky::Model::FileCommit'

      proxy_methods author: lambda { Person.find(author_id) or raise NotFound }
      proxy_methods committer: lambda { Person.find(committer_id) or raise NotFound }
      proxy_methods repository: lambda { Repository.find(repository_id) }

      def save(*args)
        self.author.save if self.author
        self.repository.save if self.repository
        self.committer.save if self.committer

        self.author_id        ||= self.author.id if self.author
        self.repository_id    ||= self.repository.id
        self.committer_id     ||= self.committer.id if self.committer
        self.parent_ids        |= self.parents.map(&:id) if self.no_proxy_parents
        self.file_ids          |= self.files.map(&:id) if self.no_proxy_files
        super(*args)
      end
    end
  end
end