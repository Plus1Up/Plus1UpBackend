require 'rails_helper'

RSpec.describe "Trainings", type: :request do

  # Initialize the test data
  let!(:client) {Client.first}
  let!(:trainings) {Client.first.trainings}
  let(:client_id) {client.id}
  let(:id) {trainings.first.id}

  # Test suite for GET /clients/:client_id/trainings
  describe 'GET /api/clients/:client_id/trainings' do
    before {get "/api/clients/#{client_id}/trainings"}

    context 'when trainings exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all trainings' do
        expect(JSON.parse(response.body)['data'].size).to eq(1)
      end
    end

    context 'when client does not exist' do
      let(:client_id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # Test suite for GET /clients/:client_id/trainings/:id
  describe 'GET /clients/:client_id/trainings/:id' do
    before {get "/api/clients/#{client_id}/trainings/#{id}"}

    context 'when training exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(JSON.parse(response.body)['data']['id']).to eq(id)
      end
    end

    context 'when training does not exist' do
      let(:id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # Test suite for POST /clients/:client_id/trainings
  describe 'POST /clients/:client_id/trainings' do
    let(:valid_attributes) {{name: 'Test training', weekday: 5}}

    context 'when request attributes are valid' do
      before {post "/api/clients/#{client_id}/trainings", params: valid_attributes}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before {post "/api/clients/#{client_id}/trainings", params: {}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /api/clients/:client_id/trainings/:id
  describe 'PUT /api/clients/:client_id/trainings/:id' do
    let(:valid_attributes) {{name: 'Edited training name'}}

    before {put "/api/clients/#{client_id}/trainings/#{id}", params: valid_attributes}

    context 'when training exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the training' do
        updated_item = Training.find(id)
        expect(updated_item.name).to match(/Edited training name/)
      end
    end

    context 'when the training does not exist' do
      let(:id) {0}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

  # Test suite for DELETE /client/:id
  describe 'DELETE /api/client/:id' do
    before {delete "/api/clients/#{client_id}/trainings/#{id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes all clients trainings' do

      expect(Training.where(client_id: client_id)).to be_empty
    end
  end

end
