require 'spec_helper'

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

    context 'create databases' do
      it 'creates a DB' do
        db = described_class.new({
          'database' => 'pipefish'
        })
        db.create
        expect(`mysql -u pipefish -ppipefish pipefish -e 'show tables'`).to eq 0
      end
    end
  end
end
