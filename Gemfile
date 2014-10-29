source "https://rubygems.org"
source "https://rails-assets.org"

# Heroku uses the ruby version to configure your application's runtime.
ruby "2.0.0"

# Rails
gem "rails", "~> 4.1.0"

# Database drivers
gem "pg"

# Background worker
gem "que"

# Web server
gem "unicorn"

# Rack middleware
gem "rack-canonical-host"

# App
gem "adequate_exposure"
gem "interactor"
gem "kaminari"
gem "responders"
# ... add your main app dependencies here (if they don't fit in the sections below)

# Views
gem "jbuilder", "~> 2.0"
gem "slim-rails"

# Integrations
gem "bugsnag"

# Frontend
gem "asset_sync"
gem "autoprefixer-rails"
gem "coffee-rails", "~> 4.0.0"
gem "meta-tags"
gem "react-rails", github: "reactjs/react-rails"
gem "redcarpet"
gem "sass-rails", "~> 4.0.2"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

# Rails assets
gem "rails-assets-jquery"
gem "rails-assets-jquery-ujs-standalone"
gem "rails-assets-viewloader"

group :production do
  gem "rails_12factor"
end

group :test do
  gem "capybara", github: "jnicklas/capybara" # RSpec 3 deprecations, waiting for the next gem release.
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "fuubar", "~> 2.0.0.beta1"
  gem "poltergeist"
  gem "minitest" # Remove this after https://github.com/thoughtbot/shoulda-matchers/issues/408 is fixed.
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", "~> 0.7.1" # https://github.com/colszowka/simplecov/issues/281
end

group :test, :development do
  gem "dotenv-rails"
  gem "rspec-rails", "~> 3.0.0.beta2"
end

# Development tools
group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "foreman"
  gem "launchy"
  gem "quiet_assets"
  gem "spring"
  gem "spring-commands-rspec"

  # Guard et al
  gem "guard", "~> 2"
  gem "guard-rspec"
  gem "guard-livereload"
end

# Mac-specific development tools
group :darwin do
  gem "rb-fsevent"
end
