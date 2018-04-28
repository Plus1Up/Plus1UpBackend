require 'rails_helper'

RSpec.describe 'Exercises API', type: :request do

  let(:exercise_id) {Exercise.first.id}

  # Test suite for simple GET /exercises
  describe 'GET /api/exercises' do
    # make HTTP get request before each example
    before {
      get '/api/exercises'
    }

    it 'returns exercises' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /exercises/:id
  describe 'GET /api/exercises/:id' do
    before {
      get "/api/exercises/#{exercise_id}"
    }

    context 'when the record exists' do
      it 'returns the client' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['data']['id']).to eq(exercise_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end


    context 'when the record does not exist' do
      let(:exercise_id) {-1}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /exercises
  describe 'POST /api/exercises/' do
    let(:valid_attributes) {
      {coach_id: Coach.first['id'], name: 'New exercise test', category: :abs}
    }

    context 'when request attributes are valid' do
      before {post '/api/exercises/', params: valid_attributes}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before {post '/api/exercises', params: {}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /exercises/:id
  describe 'PUT /exercises/:id' do
    let(:valid_attributes) {
      {name: 'Updated name', category: "biceps"}
    }

    before {
      put "/api/exercises/#{exercise_id}", params: valid_attributes
    }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_coach = Exercise.find(exercise_id)
        expect(updated_coach.name).to eq('Updated name')
        expect(updated_coach.category).to eq('biceps')
      end
    end

    context 'when the item does not exist' do
      let(:exercise_id) {-1}
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end


  # Test suite for DELETE /coaches/:id
  describe 'DELETE /api/exercises/:id' do
    before {
      delete "/api/exercises/#{exercise_id}"
    }

    context 'when the record exists' do
      it 'removes the coach' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(Exercise.all.size).to eq(4)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end