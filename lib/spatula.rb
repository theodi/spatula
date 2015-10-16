require 'yaml'

require 'spatula/version'

module Spatula
  def self.load_yaml path
    YAML.load File.read path
  end

  def self.databases path
    y = load_yaml path
    y['suites'].map { |s| s['attributes']['mysql'] }
  end

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
  end
end
