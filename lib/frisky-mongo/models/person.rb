module Frisky
  module Model
    class Person < ProxyBase
      include MongoMapper::Document

      primary_fetch do |args|
        p = Person.where(login: args[:login]).first if args[:login]
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
    end
  end
end