
require 'zlib'
require 'net/http'

class Drupal
  class Install
    
    # Attempt to download core installation or module.
    def run(arguments)
      @project = arguments[0]
      @dest = arguments[1] || '.' 
      abort "Destination #{@dest} is not a directory." unless File.directory?(@dest)
      abort 'Project name required (core | <project>).' if arguments.empty?
      install_projects
    end
    
    def debug(message)
      puts '... ' + message
    end
    
    # Install single project or iterate lists.
    def install_projects
      if @project.include? ','
        projects = @project.split ','
        projects.each do |p|
          @project = p
          check_core
          install_project 
          puts
        end   
      else
        check_core
        install_project
      end
    end
    
    # Check if the destination is empty.
    def destination_empty?
      Dir['*'].length == 0 
    end
    
    # Allow users to type 'core' instead of 'drupal install drupal'
    def check_core
      @project = 'drupal' if @project =~ /^core|drupal$/
    end
    
    # Check if a uri is available.
    def uri_available?(uri)
      open(uri) rescue false
    end
    
    # Install project.
    def install_project
      debug "Locating #{@project} page"
      # Locate tarball from project page
      begin 
        response = Net::HTTP.get_response(URI.parse("http://drupal.org/project/#{@project}"))
        @markup = response.body
        # TODO: check 404
        debug 'Located the project page'
      rescue
        puts 'Failed to request page'
      end
      @markup.match /(#{@project}-6(?:.*?)\.gz)/
      @tarball = $1
      @tarpath = File.expand_path("#{@dest}/#{@tarball}")
      abort "Failed to find Drupal 6 tar of #{@project}" if @tarball.nil?
      debug "Found tarball #{@tarball}"
      
      # Fetch tarball
      begin
        response = Net::HTTP.get_response(URI.parse("http://ftp.drupal.org/files/projects/#{@tarball}"))
        File.open(@tarpath, 'w') do |f|
          f.write response.body
        end
        debug "Copied tarball to #{@tarpath}"
      rescue
        abort "Failed to copy remote tarball #{@tarball}"
      end
      
      # Extract tarball
      @pwd = Dir.getwd
      Dir.chdir File.dirname(@tarpath) and debug "Changed cwd to #{File.dirname(@tarpath)}" unless @dest == '.'
      Kernel.system "tar -xf #{@tarpath}" rescue abort "Failed to extract #{@tarpath}"
      Dir.chdir @pwd and debug "Reverted cwd back to #{@pwd}" unless @dest == '.'
      
      # Remove tarball
      Kernel.system "rm #{@tarpath}" rescue abort "Failed to remove #{@tarpath}"
      
      # Installation complete
      debug "Project installed to #{File.dirname(@tarpath)}" unless @dest == '.'
      debug 'Installation complete'
    end
  end
end