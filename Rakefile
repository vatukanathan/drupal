# -*- ruby -*-

require 'rubygems'
require File.dirname(__FILE__) + '/lib/drupal'

desc 'Build and install ruby gem.'
task :build do
  sh "gem build ./drupal.gemspec"
  sh "gem install drupal-#{Drupal::VERSION}.gem"
end

desc 'Remove ruby gem build data.'
task :remove_build do
  sh "gem uninstall drupal"
  sh "rm drupal-#{Drupal::VERSION}.gem"
end