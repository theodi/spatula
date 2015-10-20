$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'spatula'

require 'rspec/shell/expectations'

RSpec.configure do |c|
  c.include Rspec::Shell::Expectations
end
