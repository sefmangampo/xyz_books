module Api
  class BooksController < ApplicationController
    before_action :set_book, only: [ :show, :update, :destroy ]

    def index
      books = Book.all
      render json: books.map { |book| formatted_book(book) }
    end

    def show
      if @book
        render json: formatted_book(@book)
      else
        render json: { error: "Book not found" }, status: :not_found
      end
    end

    def create
      book = Book.new(book_params)
      if book.save
        if params[:author_ids]
          authors = Author.find(params[:author_ids])
          book.authors << authors
        end
        render json: formatted_book(book), status: :created
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
        render json: formatted_book(@book)
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy
      head :no_content
    end

    def search
      cleaned_isbn = Book.clean_isbn(params[:isbn])
      unless Book.valid_isbn?(cleaned_isbn)
        return render json: { error: "Invalid ISBN format" }, status: :bad_request
      end

      book = Book.find_by(isbn_13: cleaned_isbn) || Book.find_by(isbn_10: cleaned_isbn)
      if book
        render json: formatted_book(book)
      else
        render json: { error: "Book not found" }, status: :not_found
      end
    end

    def convert
      cleaned_isbn = Book.clean_isbn(params[:isbn])
      return render json: { error: "Invalid ISBN format" }, status: :bad_request if cleaned_isbn.blank?

      isbn_format = if cleaned_isbn.length == 10
          "ISBN-10"
      elsif cleaned_isbn.length == 13
          "ISBN-13"
      else
          "Unknown"
      end

      converted_isbn = case isbn_format
      when "ISBN-10"
        Book.isbn_10_to_isbn_13(cleaned_isbn)
      when "ISBN-13"
        Book.isbn_13_to_isbn_10(cleaned_isbn)
      else
        nil
      end

      render json: {
        original: params[:isbn],
        format: isbn_format,
        converted: converted_isbn,
        dashed_format: format_as_dashed(converted_isbn)
      }
    end

    private

    def set_book
      @book = Book.find_by(id: params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :isbn_13, :isbn_10, :price, :year, :publisher_id, author_ids: [])
    end

    def formatted_book(book)
      {
        id: book.id,
        title: book.title,
        isbn_13: book.isbn_13,
        isbn_10: book.isbn_10,
        price: book.price,
        year: book.year,
        edition: book.edition,
        image: book.image,
        publisher: {
          id: book.publisher.id,
          name: book.publisher.name
        },
        authors: book.authors.map(&:full_name).join(", ")
      }
    end

    def format_as_dashed(isbn)
      return nil if isbn.nil?
      case isbn.length
      when 10
        "#{isbn[0..0]}-#{isbn[1..3]}-#{isbn[4..8]}-#{isbn[9..9]}"
      when 13
        "#{isbn[0..2]}-#{isbn[3]}-#{isbn[4..8]}-#{isbn[9..11]}-#{isbn[12..12]}"
      else
        isbn
      end
    end
  end
end
