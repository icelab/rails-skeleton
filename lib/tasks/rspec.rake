if defined?(RSpec)
  task(:spec).clear

  desc "Run all specs"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--tag ~factory"
  end

  desc "Run factory specs."
  RSpec::Core::RakeTask.new(:factory_specs) do |t|
    t.pattern = "./spec/factories_spec.rb"
  end

  # Require factory specs to pass before running the rest of the suite
  task spec: :factory_specs
end
