# -*- ruby -*-

require 'rubygems'
require File.dirname(__FILE__) + '/lib/drupal'

desc 'Build and install ruby gem.'
task :build do
  sh "sudo gem build ./drupal.gemspec"
  sh "sudo gem install drupal-#{Drupal::VERSION}.gem"
end

desc 'Remove ruby gem build data.'
task :remove_build do
  sh "sudo gem uninstall drupal"
  sh "sudo rm drupal-#{Drupal::VERSION}.gem"
end