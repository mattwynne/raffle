task :default => [:specs, 'cukes:fast', 'cukes:slow']

desc "Run unit tests"
task :specs do
  sh "rspec spec"
end

namespace :cukes do
  desc "Run end-to-end tests"
  task :slow do
    ENV['SLOW'] = 'true'
    sh "cucumber"
  end

  desc "Run end-to-end tests with stubbed out file system for speed"
  task :fast do
    ENV['SLOW'] = nil
    sh "cucumber"
  end
end
