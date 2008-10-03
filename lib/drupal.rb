#!/usr/bin/env ruby

# == SYNOPSIS:
#
#	  drupal [options] [arguments]
#
# == ARGUMENTS:
# 
#   create module <module_name> [dir]  Generates a module skeleton from an interactive wizard. Current directory unless [dir] is specified.
#   todo list [total]                  Displays list of todo items or a total.   
#   install <core | project> [dir]  	 Install a Drupal project or core itself to [dir]
#
# == OPTIONS:
# 
#  	-h, --help       Display this help information.
#	 	-V, --version    Display version of the Drupal development tool.
#
# == EXAMPLES:
# 
#   Create a new module in the current directory.
#	    drupal create module my_module
#
#   Create a new module in a specific directory.
#      drupal create module my_module ./sites/all/modules
#
#	  View todo list for current directory.
#      drupal todo list
#  
#   View todo list for multiple files or directories.
#	     drupal todo list ./sites/all/modules/mymodule 
#
#   View total todo items only.
#     drupal todo list total ./sites/all/modules
#    
#   Install a module to the modules folder in my new installation (from drupal root)
#     drupal install devel ./sites/all/modules
#  
#   Install a module when in the 'modules directory
#     drupal install devel
#  
   
require 'optparse'
require 'ostruct'
require File.dirname(__FILE__) + '/drupal/create_module'
require File.dirname(__FILE__)  + '/drupal/todo_list'
require File.dirname(__FILE__)  + '/drupal/install'

class Drupal
  
  MAJOR = 0
  MINOR = 0
  TINY = 3
  VERSION = [MAJOR, MINOR, TINY].join('.')
  
  # Run the drupal development tool.
  def run(arguments) 
    @arguments = arguments || [] 
    @options = OpenStruct.new
    abort 'Arguments required. Use --help for additional information.' if @arguments.empty?
    parse_options
    determine_handler
    execute_handler
  end
  
  # Parse stdin for options.
  def parse_options
    opts = OptionParser.new
    opts.on('-h', '--help') { output_help }
    opts.on('-V', '--version') { output_version }
    opts.parse!(@arguments)
  end
  
  # Determine handler based on the current arguments.
  def determine_handler
    @handler = @arguments.shift.capitalize
    while !@arguments.empty? && !is_handler(@handler) do
      @handler << '_' + @arguments.shift.capitalize
    end
  end
  
  # Execute the handler if it was found.
  def execute_handler
    abort 'Invalid command.' if !is_handler(@handler)
    eval("Drupal::#{@handler}.new.run(@arguments)")
  end
  
  # Check existance of a handler.
  def is_handler(klass)
    Drupal.const_defined?(klass) 
  end
  
  # Output help information.
  def output_help
    # TODO: utilize RDoc
    puts <<-USAGE
    
  SYNOPSIS:
 
    drupal [options] [arguments]
 
  ARGUMENTS:
 
    create module <module_name> [dir]  Generates a module skeleton from an interactive wizard. Current directory unless [dir] is specified.
    todo list [total]                  Displays list of todo items or a total.   
    install <core | project> [dir]  	 Install a Drupal project or core itself to [dir]    
    
  EXAMPLES:
  
    Create a new module in the current directory.
      drupal create module my_module

    Create a new module in a specific directory.
      drupal create module my_module ./sites/all/modules

    View todo list for current directory.
      drupal todo list
  
    View todo list for multiple files or directories.
      drupal todo list ./sites/all/modules/mymodule 

    View total todo items only.
      drupal todo list total ./sites/all/modules   
      
    Install drupal core to the current directory.
      drupal install core
      
    Install a module to the modules folder in my new installation (from drupal root)
      drupal install devel ./sites/all/modules
      
    Install a module when in the 'modules directory
      drupal install devel
       
USAGE
  exit
  end
  
  # Output version information.
  def output_version
    puts "Version #{Drupal::VERSION}"
    exit
  end
end



