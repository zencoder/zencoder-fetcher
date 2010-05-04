require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "zencoder-fetcher"
    gem.summary = %Q{Fetches notifications from Zencoder for local development.}
    gem.description = %Q{Fetches notifications from Zencoder for local development where Zencoder is unable to communicate to the server, usually because it's localhost.}
    gem.email = "chris@zencoder.com"
    gem.homepage = "http://github.com/zencoder/zencoder-fetcher"
    gem.authors = ["chriswarren"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_dependency 'httparty'
    gem.add_dependency 'json'
    gem.executables = %w( zencoder_fetcher)
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "zencoder-notifier #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
