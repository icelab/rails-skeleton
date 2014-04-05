source "https://rubygems.org"
source "https://rails-assets.org"

# Heroku uses the ruby version to configure your application's runtime.
ruby "2.0.0"

# Rails
gem "rails", "~> 4.1.0.rc2"

# Database drivers
gem "pg"

# Web server
gem "unicorn"

# # Rack middleware
gem "rack-canonical-host"

# Views
gem "jbuilder", "~> 2.0"
gem "slim-rails"

# Frontend
gem "coffee-rails", "~> 4.0.0"
gem "sass-rails", "~> 4.0.2"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

# Rails assets
gem "rails-assets-jquery"
gem "rails-assets-jquery-ujs-standalone"

group :production do
  gem "rails_12factor"
end

group :test do
  gem "capybara", github: "jnicklas/capybara" # Rspec 3 deprecations, waiting for the next gem release.
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "fuubar", "~> 2.0.0.beta1"
  gem "poltergeist"
  gem "simplecov", "~> 0.7.1" # https://github.com/colszowka/simplecov/issues/281
end

group :test, :development do
  gem "rspec-rails", "~> 3.0.0.beta2"
end

# Development tools
group :development do
  gem "foreman"
  gem "spring"
end

# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use debugger
# gem "debugger", group: [:development, :test]

