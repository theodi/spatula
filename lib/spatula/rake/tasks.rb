def databases
  require 'yaml'
  YAML.load(File.read('.kitchen.yml'))['suites'].
    map { |s| begin s['attributes']['mysql']['password'] rescue nil end }.compact
end

def there_are_databases
  databases.any?
end

desc 'Create database'
task :crebas do
  databases.each do |database|
    puts 'Creating database... '
    sh "mysql -u root -e 'create database if not exists #{database}';"
    sh "mysql -u root -e 'grant all on #{database}.* to \"#{database}\" identified by \"#{database}\";'"
    sh "mysql -u root -e 'flush privileges;'"
  end
end

desc 'Start local MySQL server'
task :start_mysql do
  if there_are_databases
    print 'Starting MySQL... '
    sh 'mysql.server start' do |ok, res|
      if ! ok
        puts '********************************************************'
        puts 'FAIL!'
        puts 'Are you sure MySQL is installed?'
        puts 'Make sure `mysql.server start` works before trying again'
        puts '********************************************************'
      end
    end
  end
end

desc 'Prepare MySQL for an attack run'
task prepare_database: [:start_mysql, :crebas]

desc 'Destroy test instance'
task :destroy do
  sh 'bundle exec kitchen destroy'
end

desc 'Converge test instance'
task :converge do
  sh 'bundle exec kitchen converge'
end

desc 'Verify test instance'
task :verify do
  sh 'bundle exec kitchen verify'
end

desc 'Run tests from scratch'
task scratch: [
  :destroy,
  :verify
]

desc 'Do everything from a cold start'
task test: [
  :prepare_database,
  :scratch
]

task default: :test
