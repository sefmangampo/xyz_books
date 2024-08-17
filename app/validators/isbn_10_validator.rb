class Isbn10Validator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless valid_isbn_10?(value)
      record.errors.add(attribute, "is invalid")
    end
  end

  private

  def valid_isbn_10?(isbn)
    isbn = isbn.delete("-").upcase
    return false unless isbn.length == 10

    sum = isbn.chars.each_with_index.reduce(0) do |acc, (char, index)|
      digit = char == "X" && index == 9 ? 10 : char.to_i
      return false if index < 9 && (digit < 0 || digit > 9)
      acc + digit * (10 - index)
    end

    sum % 11 == 0
  end
end
