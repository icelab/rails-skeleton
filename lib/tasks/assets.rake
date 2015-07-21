namespace :assets do
  desc "Build the public assets with node"
  task :build do
    system "npm run build-production"
  end
end

Rake::Task["assets:precompile"].enhance ["assets:clobber"] do
  Rake::Task["assets:build"].invoke
end
