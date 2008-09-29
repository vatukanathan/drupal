# -*- ruby -*-

require 'rubygems'
require './lib/drupal.rb'

desc 'Build and install the gem for testing.'
task :build do
  sh %(gem build drupal.gemspec)
  sh %(gem install drupal-#{Drupal::VERSION}.gem)
end

desc 'Remove gem build.'
task :unbuild do
  sh %(gem uninstall drupal)
  sh %(rm drupal-#{Drupal::VERSION}.gem)
end