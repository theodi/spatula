require 'yaml'

module Spatula
  class Database
    def initialize attributes
      @attributes = attributes

      populate
    end

    def populate
      keys = [
        'username',
        'password'
      ]

      keys.each do |key|
        if not @attributes.has_key? key
          @attributes[key] = @attributes['database']
        end
      end
    end

    def [] key
      @attributes[key]
    end

    def client
      @client ||= Mysql2::Client.new(host: 'localhost', username: 'root')
    end

    def create
      queries = [
        "CREATE DATABASE IF NOT EXISTS #{self['database']}",
        "GRANT ALL ON #{self['database']}.* TO '#{self['username']}'@'%' IDENTIFIED BY '#{self['password']}'",
        "GRANT ALL ON #{self['database']}.* TO '#{self['username']}'@'localhost' IDENTIFIED BY '#{self['password']}'",
        "FLUSH PRIVILEGES"
      ]

      queries.each do |q|
        client.query q
      end
    end

    def drop
      query = "DROP DATABASE #{self['database']}"
      client.query query
    end
  end
end
