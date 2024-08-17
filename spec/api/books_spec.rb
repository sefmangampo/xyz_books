require 'rails_helper'

RSpec.describe "Books", type: :request do
  let!(:publisher) { create(:publisher) }
  let!(:book) { create(:book, publisher: publisher) }
  let(:book_id) { book.id }

  describe "GET /api/books" do
    it "returns a list of books" do
      get "/api/books"
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /api/books/:id" do
    it "returns a single book" do
      get "/api/books/#{book_id}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "POST /api/books" do
    let(:valid_attributes) do
      {
        title: "New Book",
        isbn_13: "9781234567891",
        isbn_10: "0471958697",
        price: 1500,
        year: 2022,
        edition: "Second Edition",
        publisher_id: publisher.id
      }
    end

    it "creates a new book" do
      post "/api/books", params: { book: valid_attributes }
      expect(response).to have_http_status(:created)
      expect(response.body).to include("New Book")
    end
  end

  describe "PUT /api/books/:id" do
    let(:updated_attributes) do
      { title: "Updated Book Title" }
    end

    it "updates an existing book" do
      put "/api/books/#{book_id}", params: { book: updated_attributes }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Updated Book Title")
    end
  end

  describe "DELETE /api/books/:id" do
    it "deletes a book" do
      delete "/api/books/#{book_id}"
      expect(response).to have_http_status(:no_content)
      expect(Book.exists?(book_id)).to be_falsey
    end
  end
end
