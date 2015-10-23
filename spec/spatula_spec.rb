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

    it 'is cool if there are no DBs' do
      expect(Spatula::any_dbs?('spec/support/fixtures/no-dbs.yml')).to eq false
    end

    it 'knows how to deal with ERB' do
      expect(Spatula::load_yaml('spec/support/fixtures/with-erb.yml')['suites'].first['attributes']['mysql']['host']).to_not match /ipconfig/
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

  context 'start MySQL server' do
    let(:stubbed_env) { create_stubbed_env }

    it 'starts MySQL', :mysql do
      system 'mysql.server stop'
      Spatula::start_mysql
      stdout, stderr, status = stubbed_env.execute(
        'mysql -u root -e "show databases"',
      )
      expect(status.exitstatus).to eq 0
    end
  end
end
