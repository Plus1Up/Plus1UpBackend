require 'rails_helper'


RSpec.describe 'Coaches API', type: :request do

  let(:client_id) {Client.first.id}

  # Test suite for simple GET /clients
  describe 'GET /api/clients' do
    # make HTTP get request before each example
    before {
      get '/api/clients'
    }

    it 'returns clients' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      expect(JSON.parse(response.body)['data'].size).to eq(30)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for filtered on pending GET /clients
  describe 'GET /api/clients?is_pending=true' do
    before {
      get '/api/clients?is_pending=true'
    }

    it 'returns only pending clients' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      expect(JSON.parse(response.body)['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for filtered on pending GET /clients
  describe 'GET /api/clients?is_active=true&is_pending=false' do
    before {
      get '/api/clients?is_active=true&is_pending=false'
    }

    it 'returns only active clients' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      expect(JSON.parse(response.body)['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /clients/:id
  describe 'GET /api/clients/:id' do
    before {
      get "/api/clients/#{client_id}"
    }

    context 'when the record exists' do
      it 'returns the client' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['data']['id']).to eq(client_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end


    context 'when the record does not exist' do
      let(:client_id) {-1}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /clients
  describe 'POST /api/client/' do
    let(:valid_attributes) {
      {coach_id: Coach.first['id'], mail_address: 'test@client.com', password: 'tEsTPasswrod', name: 'John', last_name: 'Smith'}
    }

    context 'when request attributes are valid' do
      before {post '/api/clients/', params: valid_attributes}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before {post '/api/clients', params: {}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /clients/:id
  describe 'PUT /clients/:id' do
    let(:valid_attributes) {
      # Both parameters nil because we haven't got such scenario in seed so we're sure it has been updated
      {is_active: nil, is_pending: nil}
    }

    before {
      put "/api/clients/#{client_id}", params: valid_attributes
    }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_client = Client.find(client_id)
        expect(updated_client.is_active).to eq(nil)
        expect(updated_client.is_pending).to eq(nil)
      end
    end

    context 'when the item does not exist' do
      let(:client_id) {-1}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


  # Test suite for DELETE /clients/:id
  describe 'DELETE /api/client/:id' do
    before {
      delete "/api/clients/#{client_id}"
    }

    context 'when the record exists' do
      it 'removes the client' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(Client.all.size).to eq(29)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end