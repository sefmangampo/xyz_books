require 'rails_helper'

RSpec.describe 'Authors API', type: :request do
  let!(:authors) { create_list(:author, 3) }
  let(:author_id) { authors.first.id }

  describe 'GET /api/authors' do
    before { get '/api/authors' }

    it 'returns authors' do
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(3)
    end
  end

  describe 'GET /api/authors/:id' do
    before { get "/api/authors/#{author_id}" }

    it 'returns the author' do
      expect(response).to have_http_status(:success)
      expect(json['id']).to eq(author_id)
    end
  end

  describe 'POST /api/authors' do
    let(:valid_attributes) { { author: { first_name: 'John', last_name: 'Doe' } } }
    let(:invalid_attributes) { { author: { last_name: 'Doe' } } }

    context 'when the request is valid' do
      before { post '/api/authors', params: valid_attributes, as: :json }

      it 'creates an author' do
        expect(response).to have_http_status(:created)
        expect(json['first_name']).to eq('John')
        expect(json['last_name']).to eq('Doe')
      end
    end

    context 'when the request is invalid' do
      before { post '/api/authors', params: invalid_attributes, as: :json }

      it 'returns unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/authors/:id' do
    let(:valid_attributes) { { author: { first_name: 'Jane' } } }

    before { put "/api/authors/#{author_id}", params: valid_attributes, as: :json }

    it 'updates the author' do
      expect(response).to have_http_status(:ok)
      expect(json['first_name']).to eq('Jane')
    end
  end

  describe 'DELETE /api/authors/:id' do
    before { delete "/api/authors/#{author_id}", as: :json }

    it 'deletes the author' do
      expect(response).to have_http_status(:no_content)
    end
  end

  def json
    JSON.parse(response.body)
  end
end
