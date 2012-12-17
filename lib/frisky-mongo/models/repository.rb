module Frisky
  module Model
    class Repository < ProxyBase
      include MongoMapper::Document

      primary_fetch do |args|
        p = Repository.where(args).first if args.any?
        p or raise NotFound
      end

      key :homepage, String
      key :watchers_count, Integer
      key :html_url, String
      key :owner_id, ObjectId
      key :master_branch, String
      key :forks_count, Integer
      key :git_url, String
      key :full_name, String
      key :name, String
      key :url, String

      timestamps!

      belongs_to :owner, class_name: 'Frisky::Model::Person'
    end
  end
end