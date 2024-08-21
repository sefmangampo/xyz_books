class Author < ApplicationRecord
  has_and_belongs_to_many :books

  validates :first_name, :last_name, presence: true
  validates :middle_name, length: { maximum: 50 }, allow_blank: true

  def full_name
    name_parts = [ first_name, middle_name, last_name ].reject(&:blank?)
    name_parts.join(" ")
  end
end
