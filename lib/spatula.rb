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
end
