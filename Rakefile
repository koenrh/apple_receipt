# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rake/testtask'

RuboCop::RakeTask.new

Rake::TestTask.new(:test) do |t|
  t.libs << 'spec'
  t.libs << 'lib'
  t.test_files = FileList['spec/**/*_spec.rb']
end

task default: %i[rubocop test]
