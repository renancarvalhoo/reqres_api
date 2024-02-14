source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.3"

gem "sprockets-rails"

gem "sqlite3", "~> 1.4"

gem "puma", ">= 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem "redis", ">= 4.0.1"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

gem "faraday", "~> 2.9"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails', '~> 6.1.0'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem "web-console"
end

group :test do
  gem 'vcr', github: "vcr/vcr"
  gem 'webmock'
  gem "capybara"
  gem "selenium-webdriver"
end
