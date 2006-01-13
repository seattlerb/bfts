# -*- ruby -*-

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc "Run all the tests on a fresh test database"
task :default => [ :test ]

desc "Run unit tests"
Rake::TestTask.new("test") { |t|
  t.libs << "."
  t.pattern = '**/test_*.rb'
  t.verbose = true
}

task :audit do
  puts Dir.pwd
  Dir["test*.rb"].each do |test|
    puts test
    ruby "-I. /usr/local/bin/ZenTest #{test}"
  end
end

task :clean do |t|
  sh "find . -name \*~ -exec rm {} \\;"
end
