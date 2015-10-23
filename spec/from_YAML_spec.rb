require 'spec_helper'

describe Spatula do
  before(:all) do
    Spatula::start_mysql
  end

  let(:stubbed_env) { create_stubbed_env }

  context 'create databases from YAML' do
    it 'handles the simple case' do
      Spatula::create 'spec/support/fixtures/simple.yml'

      stdout, stderr, status = stubbed_env.execute(
        'mysql -u shark -pshark shark -e "show tables"',
      )
      expect(status.exitstatus).to eq 0

      Spatula::drop 'spec/support/fixtures/simple.yml'
    end

    it 'handles a more complicated case' do
      Spatula::create 'spec/support/fixtures/multi-dbs.yml'

      stdout, stderr, status = stubbed_env.execute(
        'mysql -u catfish -pcatfish catfish -e "show tables"',
      )
      expect(status.exitstatus).to eq 0

      stdout, stderr, status = stubbed_env.execute(
        'mysql -u starfish -phsifrats starfish -e "show tables"',
      )
      expect(status.exitstatus).to eq 0

      Spatula::drop 'spec/support/fixtures/multi-dbs.yml'
    end
  end

  it 'creates databases from YAML and attributes' do
    Spatula::create 'spec/support/fixtures/directory.yml', 'spec/support/fixtures/attributes/directory.rb'
    stdout, stderr, status = stubbed_env.execute(
      'mysql -u member_directory -pdirectory member_directory_production -e "show tables"',
    )

    expect(status.exitstatus).to eq 0

    Spatula::drop 'spec/support/fixtures/directory.yml', 'spec/support/fixtures/attributes/directory.rb'
  end
end
