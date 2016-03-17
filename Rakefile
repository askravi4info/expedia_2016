require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'




namespace :features do
  Cucumber::Rake::Task.new(:fast) do |t|
    t.profile = 'fast'
  end
  Cucumber::Rake::Task.new(:slow) do |t|
    t.profile = 'slow'
  end
  task :ci => [:fast, :slow]
end

task :default => :fast
