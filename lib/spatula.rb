require 'yaml'
require 'erb'
require 'mysql2'

require 'spatula/version'
require 'spatula/database'

module Spatula
  # this magic is due to @pkqk
  def self.hashish
    Hash.new { |h, k| h[k] = hashish }
  end

  def self.load_yaml path
    YAML.load ERB.new(File.read path).result
  end

  def self.read_attributes path
    default = hashish

    File.readlines(path).each do |line|
      eval line
    end

    return nil if default['mysql'] == {}
    default['mysql']
  end

  def self.gather_data yaml:, attributes:
  #  require 'pry' ; binding.pry
    y = load_yaml yaml
    a = read_attributes attributes

    r = []
    y['suites'].each do |suite|
      r << (suite['attributes']['mysql'].merge a)
    end

    r
  end

  def self.databases path
    y = load_yaml path
    return [] unless y['suites'].any? { |s| s['attributes'] }
    return [] unless y['suites'].any? { |s| s['attributes']['mysql'] }
    y['suites'].map { |s| Database.new s['attributes']['mysql'] }
  end

  def self.any_dbs? path
    databases(path).any?
  end

  def self.create path
    databases(path).each do |db|
      db.create
    end
  end

  def self.drop path
    databases(path).each do |db|
      db.drop
    end
  end

  def self.start_mysql
    system 'mysql.server start' do |ok, res|
      if ! ok
        STDERR.puts '********************************************************'
        STDERR.puts 'FAIL!'
        STDERR.puts 'Are you sure MySQL is installed?'
        STDERR.puts 'Make sure `mysql.server start` works before trying again'
        STDERR.puts '********************************************************'
        exit
      else
        sleep 5
      end
    end
  end
end
