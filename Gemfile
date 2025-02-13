source "https://rubygems.org"

ruby "3.4.1"

# Rails core
gem "rails", "~> 8.0.1"
gem "sprockets-rails"
gem "sqlite3"
gem "puma"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "redis"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# AI Integration
gem "deepseek-ruby"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
