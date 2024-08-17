FactoryBot.define do
  factory :book do
    title { "Sample Book" }
    isbn_13 { %w[9781891830853 9781603094542 9781603090384].sample }
    isbn_10 { %w[1891830856 1603094547 160309038X 1891830023 1603093982].sample }
    price { 1000 }
    year { 2021 }
    edition { "First Edition" }
    association :publisher
  end
end
