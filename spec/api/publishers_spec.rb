require 'rails_helper'

RSpec.describe 'Publishers API', type: :request do
  let!(:publishers) { create_list(:publisher, 3) }
  let(:publisher_id) { publishers.first.id }

  describe 'GET /api/publishers' do
    before { get '/api/publishers' }

    it 'returns publishers' do
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(3)
    end
  end

  describe 'GET /api/publishers/:id' do
    before { get "/api/publishers/#{publisher_id}" }

    it 'returns the publisher' do
      expect(response).to have_http_status(:success)
      expect(json['id']).to eq(publisher_id)
    end
  end

  describe 'POST /api/publishers' do
    let(:valid_attributes) { { publisher: { name: 'New Publisher' } } }
    let(:invalid_attributes) { { publisher: { name: '' } } }

    context 'when the request is valid' do
      before { post '/api/publishers', params: valid_attributes, as: :json }

      it 'creates a publisher' do
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('New Publisher')
      end
    end

    context 'when the request is invalid' do
      before { post '/api/publishers', params: invalid_attributes, as: :json }

      it 'returns unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/publishers/:id' do
    let(:valid_attributes) { { publisher: { name: 'Updated Publisher' } } }

    before { put "/api/publishers/#{publisher_id}", params: valid_attributes, as: :json }

    it 'updates the publisher' do
      expect(response).to have_http_status(:ok)
      expect(json['name']).to eq('Updated Publisher')
    end
  end

  describe 'DELETE /api/publishers/:id' do
    before { delete "/api/publishers/#{publisher_id}", as: :json }

    it 'deletes the publisher' do
      expect(response).to have_http_status(:no_content)
    end
  end

  def json
    JSON.parse(response.body)
  end
end
