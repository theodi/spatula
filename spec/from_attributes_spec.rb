require 'spec_helper'

describe Spatula do
  it 'reads attributes' do
    expect(Spatula::read_attributes('spec/support/fixtures/attributes/default.rb')).to be_a Hash
    expect(Spatula::read_attributes('spec/support/fixtures/attributes/default.rb')['database']).to eq 'lobster'
  end

  it 'is cool with a less-useful attributes file' do
    expect(Spatula::read_attributes('spec/support/fixtures/attributes/no-mysql.rb')).to be nil
  end
end
