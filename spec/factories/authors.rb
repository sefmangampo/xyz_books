# spec/factories/authors.rb
FactoryBot.define do
  factory :author do
    first_name { "John" }
    last_name { "Doe" }
    middle_name { "A." }
  end
end
