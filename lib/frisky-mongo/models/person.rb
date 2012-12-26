module Frisky
  module Model
    class Person < ProxyBase
      include MongoMapper::Document

      fetch_key :id

      primary_fetch do |args|
        p = Person.where(_id: args[:id]).first if args[:id]
        p ||= Person.where(login: args[:login]).first if args[:login]
        p ||= Person.where(email: args[:email]).first if args[:email]
        p or raise NotFound
      end

      key :name, String
      key :login, String
      key :email, String
      key :bio, String
      key :location, String
      key :blog, String
      key :company, String
      key :followers, Integer
      key :gravatar_id, String
      key :avatar_url, String
      key :html_url, String

      def self.load_from_raw(raw)
        model = super(raw)
        model.save if model.new?
        model
      end
    end
  end
end