TASKS_TO_GUARD = [
  'db:drop',
  'db:migrate:reset',
  'db:sample_data',
  'db:schema:load',
  'db:seed'
]

namespace :db do
  desc 'Disable task in production environment'
  task :production_guard do
    if Rails.env.production?
      unless ENV['force']
        puts 'This task has been disabled in production'
        puts 'If you really want to run it, call it again with `force=true`'
        exit
      end
    end
  end
end

# For each task in our list, run db:production_guard as a prerequisite
# http://ruby-doc.org/stdlib-2.0.0/libdoc/rake/rdoc/Rake/Task.html#method-i-enhance
TASKS_TO_GUARD.each do |task_name|
  Rake::Task[task_name].enhance ['db:production_guard']
end
