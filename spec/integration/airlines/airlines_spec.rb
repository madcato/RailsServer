require 'swagger_helper'

describe 'Airlines API' do

  path '/airlines' do

    post 'Creates an airline' do
      tags 'Arlines'
      consumes 'application/json', 'application/xml'
      parameter name: :airline, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'airline created' do
        let(:airline) { { name: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:airline) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/airlines/{id}' do

    get 'Retrieves an airline' do
      tags 'Airlines'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'airline found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string }
          },
          required: [ 'id', 'name' ]

        let(:id) { Airline.create(name: 'foo').id }
        run_test!
      end

      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end