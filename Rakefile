#
# hello
#

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

task :clean do |t|
  sh "find . -name \*~ -exec rm {} \\;"
end
