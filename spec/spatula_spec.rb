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
    end
  end
end
