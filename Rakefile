# -*- ruby -*-

require 'rubygems'
require File.dirname(__FILE__) + '/lib/drupal'

desc 'Build and install ruby gem.'
task :build do
  sh "sudo gem build ./drupal.gemspec"
  sh "sudo gem install drupal-#{Drupal::VERSION}.gem"
end

desc 'Remove ruby gem build data.'
task :remove do
  sh "sudo gem uninstall drupal"
  sh "sudo rm drupal-#{Drupal::VERSION}.gem"
end

desc 'Run tests.'
task :test do
  sh "ruby " + File.dirname(__FILE__) + '/test/test_drupal.rb' + ' -r tk'
end