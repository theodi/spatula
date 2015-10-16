require 'yaml'

require 'spatula/version'

module Spatula
  def self.load_yaml path
    y = YAML.load File.read path
#    require 'pry' ; binding.pry
    y
  end
end
