require 'spec_helper'

describe Sinatra::Muster::Helpers do
  include Rack::Test::Methods

  subject(:app) do
    modular_app(&action)
  end

  context 'with no filters' do
    let(:action) do
      lambda do 
        query.inspect
      end
    end

    it 'returns all parsed values' do
      get '/?select=id,name,password'

      last_response.body.should == '{"select"=>["id", "name", "password"]}'
    end
  end

  context 'with :only filtering' do
    context 'with no matching values' do
      context 'and a scalar filter' do
        let(:action) do
          lambda do
            query_filter :select, :only => 'name'
            query.inspect
          end
        end

        it 'returns a nil' do
          get '/?select=id,password'

          last_response.body.should == '{"select"=>nil}'
        end
      end

      context 'and an Array filter' do
        let(:action) do
          lambda do
            query_filter :select, :only => ['name']
            query.inspect
          end
        end

        it 'returns an empty Array' do
          get '/?select=id,password'

          last_response.body.should == '{"select"=>[]}'
        end
      end
    end

    context 'with a matching value' do
      context 'with a scalar filter' do
        let(:action) do
          lambda do
            query_filter :select, :only => 'name'
            query.inspect
          end
        end

        it 'returns filtered scalar value' do
          get '/?select=id,name,password'

          last_response.body.should == '{"select"=>"name"}'
        end
      end

      context 'with an Array filter' do
        let(:action) do
          lambda do
            query_filter :select, :only => ['name']
            query.inspect
          end
        end

        it 'returns filtered scalar value' do
          get '/?select=id,name,password'

          last_response.body.should == '{"select"=>["name"]}'
        end
      end
    end
  end

  context 'with :except filtering' do
    context 'with no remaining values' do
      context 'and a scalar query' do
        let(:action) do
          lambda do
            query_filter :select, :except => 'name'
            query.inspect
          end
        end

        it 'returns a nil' do
          get '/?select=name'

          last_response.body.should == '{"select"=>nil}'
        end
      end

      context 'and an Array query' do
        let(:action) do
          lambda do
            query_filter :select, :except => ['id','name']
            query.inspect
          end
        end

        it 'returns an empty nil' do
          get '/?select=id,name'

          last_response.body.should == '{"select"=>[]}'
        end
      end
    end

    context 'with remaining values' do
      context 'with a scalar query value' do
        let(:action) do
          lambda do
            query_filter :select, :except => 'id'
            query.inspect
          end
        end

        it 'returns filtered scalar value' do
          get '/?select=name'

          last_response.body.should == '{"select"=>"name"}'
        end
      end

      context 'with an Array query value' do
        let(:action) do
          lambda do
            query_filter :select, :except => ['password']
            query.inspect
          end
        end

        it 'returns filtered Arrau value' do
          get '/?select=id,name,password'

          last_response.body.should == '{"select"=>["id", "name"]}'
        end
      end
    end
  end
end
