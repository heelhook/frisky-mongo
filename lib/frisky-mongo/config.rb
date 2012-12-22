module Frisky
  @@mongo          = nil
  @@mongo_database = nil

  CONFIG_EXTENSIONS ||= []
  CONFIG_EXTENSIONS << :frisky_mongo_config=

  def self.frisky_mongo_config=(config)
    @@mongo = Mongo::Connection.from_uri(config['mongo']) if config['mongo']

    if @@mongo
      uri                    = URI.parse(config['mongo'])
      @@mongo_database        = uri.path.gsub(/^\//, '')
      MongoMapper.connection = @@mongo
      MongoMapper.database   = @@mongo_database
    end
  end

  def self.mongo; @@mongo[@@mongo_database]; end
end