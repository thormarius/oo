require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the open_id_authentication plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the open_id_authentication plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'OpenIdAuthentication'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'open_id_authentication'
    gem.author = "David Heinemeier Hansson"
    gem.email = 'david@loudthinking.com'
    gem.homepage = 'http://www.rubyonrails.org'
    gem.summary = 'Provides a thin wrapper around the excellent ruby-openid gem from JanRan.'
    gem.extra_rdoc_files = ["MIT-LICENSE", "README", "CHANGELOG"]
    gem.add_dependency('pelle-ruby-openid', '>= 2.1.8')
    
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
