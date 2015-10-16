require 'spec_helper'

describe Spatula do
  it 'has a version number' do
    expect(Spatula::VERSION).not_to be nil
  end

  context 'read YAML' do
    it 'reads a file' do
      expect(Spatula::load_yaml('spec/support/fixtures/simple.yml')).to be_a Hash
    end

    it 'gets test suites' do
      expect(Spatula::load_yaml('spec/support/fixtures/simple.yml')['suites']).to be_an Array
    end

    it 'gets sensible data' do
      expect(Spatula::load_yaml('spec/support/fixtures/simple.yml')['suites'].first['name']).to eq 'production'
    end
  end

  context 'assemble DB details' do
    it 'gives correct defaults' do
      expect(Spatula::databases('spec/support/fixtures/simple.yml').first['database']).to eq 'shark'
      expect(Spatula::databases('spec/support/fixtures/simple.yml').first['username']).to eq 'shark'
    end

    it 'gives data that reflects the YAML' do
      expect(Spatula::databases('spec/support/fixtures/db-and-user.yml').first['database']).to eq 'jellyfish'
      expect(Spatula::databases('spec/support/fixtures/db-and-user.yml').first['username']).to eq 'bert'
      expect(Spatula::databases('spec/support/fixtures/db-and-user.yml').first['password']).to eq 'jellyfish'
    end

    it 'understands when there is more than one DB' do
      expect(Spatula::databases('spec/support/fixtures/multi-dbs.yml')[1]['database']).to eq 'starfish'
      expect(Spatula::databases('spec/support/fixtures/multi-dbs.yml')[1]['password']).to eq 'hsifrats'
    end
  end
end

module Spatula
  describe Database do
    it 'has a database name' do
      expect(described_class.new({
        'database' => 'octopus'
      })['database']).to eq 'octopus'
    end

    it 'generates sensible defaults' do
      expect(described_class.new({
        'database' => 'stingray'
      })['username']).to eq 'stingray'
    end

    it 'populates the fields we give it' do
      db = described_class.new({
        'database' => 'barracuda',
        'username' => 'nemo'
      })

      expect(db['username']).to eq 'nemo'
      expect(db['password']).to eq 'barracuda'
    end
  end
end
