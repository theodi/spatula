require 'spec_helper'

describe Spatula do
  it 'has a version number' do
    expect(Spatula::VERSION).not_to be nil
  end

  context 'extract DB details' do
    it 'reads a file' do
      expect(Spatula::load_yaml('spec/support/fixtures/simple.yml')).to be_a Hash
    end

    it 'gets test suites' do
      expect(Spatula::load_yaml('spec/support/fixtures/simple.yml')['suites']).to be_an Array
    end

    it 'gets sensible data' do
      expect(Spatula::load_yaml('spec/support/fixtures/simple.yml')['suites'].first).to be_a Hash
    end
  end
end
