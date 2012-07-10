task :default => [:specs, 'cukes:fast', 'cukes:slow']

desc "Run unit tests"
task :specs do
  sh "rspec spec"
end

namespace :cukes do
  desc "Run end-to-end tests"
  task :slow do
    sh "SLOW=1 cucumber"
  end

  desc "Run end-to-end tests with stubbed out file system for speed"
  task :fast do
    sh "cucumber"
  end
end
