require 'spatula'

desc 'Create database'
task :crebas do
  Spatula::create '.kitchen.yml', 'attributes/default.rb'
end

desc 'Start local MySQL server'
task :start_mysql do
  if Spatula::any_dbs? '.kitchen.yml', 'attributes/default.rb'
    Spatula::start_mysql
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
