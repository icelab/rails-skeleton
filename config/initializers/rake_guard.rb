require 'rake_guard'

RakeGuard.configure do |config|
  config.tasks_to_guard = [
    'db:drop',
    'db:migrate:reset',
    'db:sample_data',
    'db:schema:load',
    'db:seed',
    'db:reset'
  ]

  config.enabled = Rails.env.production?
end
