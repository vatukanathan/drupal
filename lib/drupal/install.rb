
require 'open-uri'

class Drupal
  class Install
    
    # Attempt to download core installation or module.
    def run(arguments)
      @project = arguments[0]
      @dest = arguments[1] || '.'
      abort 'Project name required (core | <project>).' if arguments.empty?
      print "Destination '#{@dest}' is not empty, are you sure you want continue installation? (yes|no): " unless destination_empty?
      confirmation = STDIN.gets unless destination_empty?
      abort 'Installation aborted.' unless confirmation =~ /y|yes/ 
      check_core
      install_project if project_exists?
    end
    
    def debug(message)
      puts '... ' + message
    end
    
    # Check if the destination is empty.
    def destination_empty?
      Dir['*'].length == 0 
    end
    
    # Allow users to type 'core' instead of 'drupal install drupal'
    def check_core
      @project = 'drupal' if @project =~ /^core|drupal$/
    end
    
    # Determine if the project passed actually exists as a module.
    def project_exists?
      debug 'Locating project page'
      if !uri_available?("http://drupal.org/project/#{@project}")
        abort "Failed to find #{@project}."
      end
    end
    
    # Check if a uri is available.
    def uri_available?(uri)
      open(uri) rescue false
    end
    
    # Install project.
    def install_project
      debug "Located #{@project} page"
      @markup = open("http://drupal.org/project/#{@project}") { |f| f.read } 
      @markup.match /#{@project}-6\.x-[\d]\.[\d](?:\.\d)?(?:-\w+)?\.tar\.gz/
      # TODO: make sure markup works..
      # TODO: make sure match works..
    end
  end
end