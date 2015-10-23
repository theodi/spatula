require 'spec_helper'

describe Spatula do
  it 'reads attributes' do
    expect(Spatula::read_attributes('spec/support/fixtures/attributes/default.rb')).to be_a Hash
    expect(Spatula::read_attributes('spec/support/fixtures/attributes/default.rb')['database']).to eq 'lobster'
  end

  it 'is cool with a less-useful attributes file' do
    expect(Spatula::read_attributes('spec/support/fixtures/attributes/no-mysql.rb')).to be nil
  end

  context 'sensibly combine attributes and kitchen.yml data' do
    it 'handles a simple case' do
      datas = Spatula::gather_data(
        yaml: 'spec/support/fixtures/directory.yml',
        attributes: 'spec/support/fixtures/attributes/directory.rb'
      )

      expect(datas).to be_an Array
      expect(datas.first['password']).to eq 'directory'
    end

    it 'handles a more complex case' do
      datas = Spatula::gather_data(
        yaml: 'spec/support/fixtures/multi-dbs.yml',
        attributes: 'spec/support/fixtures/attributes/directory.rb'
      )

      expect(datas[1]['database']).to eq 'member_directory_production'
    end
  end
end
