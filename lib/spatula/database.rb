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

    def create
    end
  end
end
