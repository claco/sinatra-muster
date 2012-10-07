# Sinatra::Muster

Sinatra helpers for working with Muster query string parsing strategies

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-muster'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-muster

## Usage

    require 'sinatra/base'
    require 'sinatra/muster'
    
    class MyApp < Sinatra::Base
      register Sinatra::Muster
    
      use Muster::Rack, Muster::Strategies::Hash
    
      #  GET /?select=id,name,password
      get '/' do
        query_filter :select, :only => ['id', 'name', 'email']
    
        selected = query[:select]  #=> ['id', 'name']
    
        Users.all(:fields => selected)
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
