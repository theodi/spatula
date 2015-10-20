require 'yaml'
require 'mysql2'

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
