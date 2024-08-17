module Api
  class BooksController < ApplicationController
    before_action :set_book, only: [ :show, :update, :destroy ]

    def index
      books = Book.all
      render json: books, include: [ :authors, :publisher ]
    end

    def show
      render json: @book, include: [ :authors, :publisher ]
    end

    def create
      book = Book.new(book_params)
      if book.save
        if params[:author_ids]
          authors = Author.find(params[:author_ids])
          book.authors << authors
        end
        render json: book, status: :created
      else
        Rails.logger.info("Book creation failed: #{book.errors.full_messages}")
        render json: book.errors, status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        if params[:author_ids]
          @book.authors = Author.find(params[:author_ids])
        end
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy
      head :no_content
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :isbn_13, :isbn_10, :price, :year, :publisher_id, author_ids: [])
    end
  end
end
