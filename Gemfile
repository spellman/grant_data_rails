source "https://rubygems.org"
ruby "2.2.1"

gem "rails",                       "~> 4.0"
gem "turbolinks"
gem "sprockets-rails"
gem "jquery-rails"
gem "uglifier",                    ">= 1.3"
gem 'bootstrap-sass'
gem "sass-rails"
gem "bootstrap_form"
#gem 'unobtrusive_flash',           ">= 3"
#gem 'unobtrusive_flash',           path: "../../unobtrusive_flash"
gem 'unobtrusive_flash',           git: "https://github.com/spellman/unobtrusive_flash"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem "jbuilder", "~> 1.2"
gem "pg",                          "~> 0.16"
gem "pundit"
gem "kaminari",                    "~> 0.14"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc",                      require: false
end

group :development do
  gem "bundler",                   "~> 1.3"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
end

group :development, :test do
  gem "rspec-rails",               "~> 2.13"
  gem "rb-inotify",                "~> 0.9"
  gem "pry"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-stack_explorer"
end

group :production do
  gem "rails_12factor",            "0.0.2"
end

gem "bcrypt-ruby",                 "~> 3.1.2"
gem "unicorn"
gem "rack-timeout"

# Use Capistrano for deployment
# gem "capistrano", group: :development

# Use debugger
# gem "debugger", group: [:development, :test]
