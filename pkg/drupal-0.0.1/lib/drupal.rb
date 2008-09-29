#!/usr/bin/env ruby

# == DRUPAL:
#
#   Drupal is an open source Ruby development tool allowing developers 
#   to quickly generate and manage Drupal modules. 
#
# == SYNOPSIS:
#
#   drupal [options] [arguments]
#
# == ARGUMENTS:
# 
#   create module        Generates a module skeleton from an interactive wizard.
#   todo list [total]    Displays list of todo items or a total.
# 
# == OPTIONS:
# 
#   -h, --help       Display this help information.
#   -V, --version    Display version of the Drupal development tool.
#
# == EXAMPLES:
#
#   Create a new module in the current directory.
#     drupal create module my_module
# 
#   Create a new module in a specific directory.
#      drupal create module my_module ./sites/all/modules
#
#   View todo list for current directory.
#      drupal todo list
# 
#   View todo list for multiple files or directories.
#      drupal todo list ./sites/all/modules/mymodule 
#
#   View total todo items only.
#     drupal todo list total ./sites/all/modules
#
class Drupal
  
  VERSION = '0.0.1'
  
  require 'optparse'
  require 'rdoc/usage'
  
  # Run the drupal development tool.
  def run(arguments) 
    @arguments, @handler, @handler_filepath, @handler_arguments = arguments, '', '', []
    if @arguments.empty?
      puts 'Use --help for usage information.'
      exit 1
    end    
    self.parse_options
    self.determine_handler
    self.require_handler
    self.execute_handler
  end
  
  # Determine which handler class should be used
  def determine_handler
    depth = 1
    until File.file?(@handler_filepath) do 
      @handler = 'Drupal::' + @arguments[0, depth].collect{ |a| a.capitalize }.join('_')
      @handler_filepath = './drupal.' + @arguments[0, depth].join('.') + '.rb'
      @handler_arguments = @arguments[depth, @arguments.length]
      if depth >= 5
        puts 'Invalid arguments; Use --help for usage information.'
        exit 2
      end
      depth += 1
    end
  end
  
  # Require files for handler, passing it arguments
  def require_handler
    require @handler_filepath
  end
  
  # Execute handler class.
  def execute_handler
    # TODO pass options
    eval(@handler << '.new.run(@handler_arguments)')
  end
  
  # Parse options and report on invalid ones.
  def parse_options
    # TODO allow handler to register options
    # TODO how should gems handle this? readme.txt?
    opts = OptionParser.new
    opts.on('-h', '--help'){ RDoc.usage(0) }
    opts.on('-v', '--version'){ self.output_version }
    begin
      opts.parse!(@arguments)
    rescue => e
      puts e
      exit 1
    end
  end
  
  # Output version information.
  def output_version
    puts "Version #{Drupal::VERSION}"
    exit 0
  end
end



