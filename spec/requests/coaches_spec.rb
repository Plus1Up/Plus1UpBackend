require 'rails_helper'


RSpec.describe 'Coaches API', type: :request do

  let(:coach_id) {Coach.first.id}

  # Test suite for simple GET /clients
  describe 'GET /api/coaches' do
    # make HTTP get request before each example
    before {
      get '/api/coaches'
    }

    it 'returns coaches' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /clients
  describe 'POST /api/coaches/' do
    let(:valid_attributes) {
      {mail_address: 'test@coach.com', password: 'tEsTPasswrod', name: 'John', last_name: 'Smith'}
    }

    context 'when request attributes are valid' do
      before {post '/api/coaches/', params: valid_attributes}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before {post '/api/coaches', params: {}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /coaches/:id
  describe 'PUT /coaches/:id' do
    let(:valid_attributes) {
      {mail_address: 'test@coach.com', password: 'tEsTPasswrod', name: 'John', last_name: 'Smith'}
    }

    before {
      put "/api/coaches/#{coach_id}", params: valid_attributes
    }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_coach = Coach.find(coach_id)
        expect(updated_coach.mail_address).to eq('test@coach.com')
        expect(updated_coach.password).to eq('tEsTPasswrod')
        expect(updated_coach.name).to eq('John')
        expect(updated_coach.last_name).to eq('Smith')
      end
    end

    context 'when the item does not exist' do
      let(:coach_id) {-1}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


  # Test suite for DELETE /coaches/:id
  describe 'DELETE /api/client/:id' do
    before {
      delete "/api/coaches/#{coach_id}"
    }

    context 'when the record exists' do
      it 'removes the coach' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(Coach.all.size).to eq(4)
      end

      it 'removes all coach\'s clients' do
        expect(Client.where(coach_id: coach_id)).to be_empty
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end