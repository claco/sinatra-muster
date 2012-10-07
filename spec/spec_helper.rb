if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'rack/test'
require 'sinatra/muster'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def mock_app(base=Sinatra::Base, &block)
  Sinatra.new(base, &block)
end

def modular_app(&block)
  mock_app do
    register Sinatra::Muster

    use Muster::Rack, Muster::Strategies::Hash

    get '/', &block
  end
end
