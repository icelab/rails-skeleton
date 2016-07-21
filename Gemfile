source "https://rubygems.org"

# Heroku uses the ruby version to configure your application's runtime.
ruby "2.2.3"

# Rails
gem "rails", "~> 5.0.0"

# Database drivers
gem "pg"

# Background worker
gem "que"

# Web server
gem "unicorn"

# Rack middleware
gem "rack-canonical-host"

# App
gem "interactor"
gem "intercity_express"
gem "kaminari"
gem "memoit" # easy memoization
# ... add your main app dependencies here (if they don't fit in the sections below)

# Views
gem "jbuilder"
gem "meta-tags"
gem "slim-rails"

# Integrations
gem "bugsnag"

group :production do
  gem "rails_12factor"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "factory_girl_rails", "~> 4.5.0"
  gem "poltergeist"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov"
end

group :test, :development do
  gem "dotenv-rails"
  gem "rspec-rails", "~> 3.5.0"

  # Code quality checkers
  gem "bundler-audit", require: false
  gem "rubocop", require: false
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "foreman"
  gem "launchy"
  gem "pry-byebug"
  gem "pry-rails"
  gem "spring"
  gem "spring-commands-rspec"
end
