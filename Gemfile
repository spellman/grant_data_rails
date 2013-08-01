source "https://rubygems.org"
ruby "2.0.0"

gem "grant_data",              git: "git://github.com/spellman/grant_data"
gem "grant_data_persistence",  git: "git://github.com/spellman/grant_data_persistence"

gem "rails",                   "4.0.0"
gem "turbolinks"

gem "jquery-rails"
gem "uglifier",                ">= 1.3.0"
#gem "sass-rails", "~> 4.0.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem "jbuilder", "~> 1.2"

gem "pg",                      "~> 0.16"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc",                  require: false
end

group :development do
  gem "bundler",               "~> 1.3"
end

group :test do
  gem "capybara-webkit",       "~> 1.0.0"
  gem "capybara",              "~> 2.1"
end

group :development, :test do
  gem "rspec-rails",           "~> 2.13"
  gem "rb-inotify",            "~> 0.9"
end

group :production do
  gem "rails_12factor",        "0.0.2"
end

# Use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.0.0"

# Use unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano", group: :development

# Use debugger
# gem "debugger", group: [:development, :test]
