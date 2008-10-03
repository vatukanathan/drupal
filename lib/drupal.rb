#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'
require 'rdoc/usage'
#require 'drupal/create_module'
#require 'drupal/todo_list'

class Drupal
  
  MAJOR = 0
  MINOR = 0
  TINY = 2
  VERSION = [MAJOR, MINOR, TINY].join('.')
  
  # Run the drupal development tool.
  def run(arguments) 
    @arguments = arguments || [] 
    @options = OpenStruct.new
    abort 'Arguments required.' if @arguments.empty?
    parse_options
    determine_handler
    execute_handler
  end
  
  # Parse stdin for options.
  def parse_options
    opts = OptionParser.new
    opts.on('-v', '--verbose') { @options.verbose = true }
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
    eval("#{@handler}.run(@arguments)")
  end
  
  # Check existance of a handler.
  def is_handler(klass)
    Module.const_defined?(klass)
  end
  
  # Output version information.
  def output_version
    puts "Version #{Drupal::VERSION}"
    exit 0
  end
end



