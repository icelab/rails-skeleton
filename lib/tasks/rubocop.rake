begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  warn "rubocop not found"
end
