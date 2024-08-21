source "https://rubygems.org"

gem "rails", "~> 7.2.0"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "rack-cors"


group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rubocop"
end

group :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end
