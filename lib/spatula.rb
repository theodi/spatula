require 'yaml'

require 'spatula/version'
require 'spatula/database'

module Spatula
  def self.load_yaml path
    YAML.load File.read path
  end

  def self.databases path
    y = load_yaml path
    y['suites'].map { |s| Database.new s['attributes']['mysql'] }
  end
end
