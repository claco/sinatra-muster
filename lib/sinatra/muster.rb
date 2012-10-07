require 'muster'
require 'sinatra/base'

module Sinatra
  module Muster

    # Sinatra helpers for working with Muster query string parsing strategies
    #
    # @example
    #
    #   require 'sinatra/base'
    #   require 'sinatra/muster'
    #
    #   class MyApp < Sinatra::Base
    #     register Sinatra::Muster
    #
    #     use Muster::Rack, Muster::Strategies::Hash
    #
    #     #  GET /?select=id,name,password
    #     get '/' do
    #       query_filter :select, :only => ['id', 'name', 'email']
    #       
    #       selected = query[:select]  #=> ['id', 'name']
    #
    #       Users.all(:fields => selected)
    #     end
    #   end
    module Helpers

      # Add a filter to be applied to the data in {#query} results
      #
      # @param key [String,Symbol] the key of the values in {#query} to filter
      # @param [optional, Hash] options the options available for this filter
      # @option options [optional] :only when specified, only return the matching values
      #   If you specify a single value, a single value will be returned
      #   If you specify an Array of values, an Array will be returned, even if only one value matches
      # @option options [optional] :except return all values except the ones given here
      #   If the raw data value is a single value, a single value will be returned
      #   If the raw data value is an Array, and array will be returned, even if all values are excluded
      #   If nothing was excluded, the raw value is returned as-is
      #
      # If you pass a scalar value instead of a Hash into options, it will be treated as the default, just like
      # Hash#fetch does.
      #
      # If you pass nothing into the options argument, it will return all values if the key exists or raise
      # a KeyError like Hash#fetch.
      #
      # @return [void]
      #
      # @example
      #
      #   results.add_filter(:select, :only => [:id, :name])
      #   results.add_filter(:select, :except => [:id])
      #   results.add_filter(:page, 1)
      def query_filter( key, *options )
        muster_query.add_filter( key, *options )
      end

      # Returns the parsed and filtered query options from Muster::Rack
      #
      # @return [Muster::Results]
      #
      # @example
      #
      #     #  GET /?select=id,name,password
      #     get '/' do
      #       query_filter :select, :only => ['id', 'name', 'email']
      #       
      #       selected = query[:select]  #=> ['id', 'name']
      #
      #       Users.all(:fields => selected)
      #     end
      def query
        muster_query.filtered
      end

      private 

      def muster_query
        request.env['muster.query']
      end

    end

    # Registers the helpers with the current Sinatra application
    #
    # @param app [Sinatra::Base] The Sinatra application instance
    #
    # @return [void]
    def self.registered(app)
      app.helpers Sinatra::Muster::Helpers
    end
  end

  helpers Sinatra::Muster::Helpers
end
