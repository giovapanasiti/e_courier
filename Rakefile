require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/testtask'

Rake::TestTask.new do |t|
	t.pattern = 'test/**/*_test.rb'
	t.libs << 'test'
end


# RSpec::Core::RakeTask.new(:spec)

# task :default => :spec
task default: :test
