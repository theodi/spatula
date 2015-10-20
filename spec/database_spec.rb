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
      before(:context) do
        system 'mysql.server start'
      end

      let(:stubbed_env) { create_stubbed_env }

      it 'creates a DB' do
        db = described_class.new({
          'database' => 'pipefish'
        })
        db.create

        stdout, stderr, status = stubbed_env.execute(
          'mysql -u pipefish -ppipefish pipefish -e "show tables"',
        )
        expect(status.exitstatus).to eq 0
        db.drop
      end

      it 'drops a DB' do
        db = described_class.new({
          'database' => 'triggerfish'
        })
        db.create
        stdout, stderr, status = stubbed_env.execute(
          'mysql -u triggerfish -ptriggerfish triggerfish -e "show tables"',
        )
        expect(status.exitstatus).to eq 0

        db.drop
        stdout, stderr, status = stubbed_env.execute(
          'mysql -u triggerfish -ptriggerfish triggerfish -e "show tables"',
        )
        expect(status.exitstatus).to eq 1
      end
    end
  end
end
