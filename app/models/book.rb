
class Book < ApplicationRecord
  belongs_to :publisher
  has_and_belongs_to_many :authors

  validates :title, :isbn_13, :price, :year, presence: true
  validates :isbn_13, length: { is: 13 }, uniqueness: true, format: { with: /\A\d{13}\z/, message: "must be a 13-digit number" }
  validates :isbn_10, length: { is: 10 }, allow_blank: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def formatted_details
    "#{title} by #{authors.map(&:full_name).join(', ')}"
  end

  # Validates an ISBN number (either ISBN-10 or ISBN-13)
  def self.valid_isbn?(isbn)
    cleaned_isbn = clean_isbn(isbn)
    return false if cleaned_isbn.blank?

    case cleaned_isbn.length
    when 10
      isbn_10_valid_format?(cleaned_isbn)
    when 13
      isbn_13_valid_format?(cleaned_isbn)
    else
      false
    end
  end

  # Cleans an ISBN by removing non-numeric characters and converting to uppercase
  def self.clean_isbn(isbn)
    isbn.to_s.upcase.gsub(/[^0-9X]/, "")
  end

  # Validates ISBN-10 format
  def self.isbn_10_valid_format?(isbn)
    return false unless isbn.length == 10

    isbn_digits = isbn.chars.first(9)  # The first 9 characters
    isbn_check_digit = isbn.chars.last  # The last character (check digit)

    # Calculate the total sum based on index starting from 10 down to 2
    total_sum = isbn_digits.each_with_index.sum do |char, index|
      digit = char.to_i
      digit * (10 - index)
    end

    # Calculate the check digit value
    remainder = total_sum % 11
    calculated_check_digit = remainder.zero? ? "0" : (11 - remainder).to_s
    calculated_check_digit = "X" if calculated_check_digit == "10"

    # Compare with the last digit
    isbn_check_digit.upcase == calculated_check_digit
  end

  # Validates ISBN-13 format
  def self.isbn_13_valid_format?(isbn)
    return false unless isbn.length == 13
    return false unless isbn =~ /\A\d{13}\z/

    puts "------here-----#{isbn}"

    # Convert to array of digits
    digits = isbn.chars.map(&:to_i)

    # Calculate the sum with weights 1 and 3
    total_sum = digits[0...12].each_with_index.sum do |digit, index|
      weight = index.even? ? 1 : 3
      digit * weight
    end

    # Calculate the expected check digit
    expected_check_digit = (10 - (total_sum % 10)) % 10
    puts "----#{digits.last}------#{expected_check_digit}"
    # Compare the expected check digit with the actual check digit
    digits.last == expected_check_digit
  end

  # Converts ISBN-10 to ISBN-13
  def self.isbn_10_to_isbn_13(isbn_10)
    return nil unless isbn_10.length == 10
    return nil unless isbn_10 =~ /\A\d{9}[0-9X]\z/  # Validate format

    # Remove the check digit
    isbn_10_digits = isbn_10[0...-1]

    # Add the '978' prefix
    isbn_13_base = "978" + isbn_10_digits

    # Calculate the new check digit
    total_sum = isbn_13_base.chars.each_with_index.sum do |digit, index|
      weight = index.even? ? 1 : 3
      digit.to_i * weight
    end

    remainder = total_sum % 10
    check_digit = (10 - remainder) % 10

    # Append the new check digit
    isbn_13_base + check_digit.to_s
  end

  # Converts ISBN-13 to ISBN-10
  def self.isbn_13_to_isbn_10(isbn_13)
    return nil unless isbn_13.length == 13
    return nil unless isbn_13.start_with?("978")

    # Remove the '978' prefix and the check digit
    isbn_10_base = isbn_13[3...-1]

    # Calculate the ISBN-10 check digit
    total_sum = isbn_10_base.chars.each_with_index.sum do |digit, index|
      digit.to_i * (index + 1)
    end

    remainder = total_sum % 11
    check_digit = (11 - remainder) % 11

    check_digit_str = check_digit == 10 ? "X" : check_digit.to_s

    # Combine to form the ISBN-10
    isbn_10_base + check_digit_str
  end
end
