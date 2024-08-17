class Book < ApplicationRecord
  belongs_to :publisher
  has_and_belongs_to_many :authors

  validates :title, :isbn_13, :price, :year, presence: true
  validates :isbn_13, length: { is: 13 }, uniqueness: true, format: { with: /\A\d{13}\z/, message: "must be a 13-digit number" }
  validates :isbn_10, length: { is: 10 }, allow_blank: true, isbn_10: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def formatted_details
    "#{title} by #{authors.map(&:full_name).join(', ')}"
  end

  def self.valid_isbn?(isbn)
    return false if isbn.blank?

    if isbn.length == 10
      isbn_10_valid_format?(isbn)
    elsif isbn.length == 13
      isbn_13_valid_format?(isbn)
    else
      false
    end
  end

  def self.isbn_10_valid_format?(isbn)
    isbn_digits = isbn.chars.first(9).map(&:to_i)
    isbn_check_digit = isbn.chars.last
    sum = isbn_digits.each_with_index.sum { |digit, index| digit * (index + 1) }
    check_digit = (sum % 11).zero? ? "0" : (11 - (sum % 11)).to_s
    check_digit = "X" if check_digit == "10"
    isbn_check_digit == check_digit
  end

  def self.isbn_13_valid_format?(isbn)
    digits = isbn.chars.map(&:to_i)
    sum = digits.each_with_index.sum { |digit, index| (index.even? ? digit : digit * 3) }
    (sum % 10).zero?
  end
end
