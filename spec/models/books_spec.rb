require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validations' do
    it 'validates presence of title' do
      book = Book.new(title: nil)
      expect(book.valid?).to be_falsey
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'validates uniqueness of isbn_10' do
      existing_book = create(:book, isbn_10: '0471958697')
      new_book = build(:book, isbn_10: '0471958697')
      expect(new_book.valid?).to be_falsey
      expect(new_book.errors[:isbn_10]).to include('has already been taken')
    end
  end

  context 'associations' do
    it 'has and belongs to many authors' do
      association = Book.reflect_on_association(:authors)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'belongs to a publisher' do
      association = Book.reflect_on_association(:publisher)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
