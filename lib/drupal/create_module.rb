
class Drupal
  class Create_Module
    
    # Create a module using the module builing wizard.
    def run(arguments)
      @arguments = arguments
      @dir = @arguments[1] || '.' # TODO remove trailing slash, check validity, and existance
      self.check_module_name
      self.run_wizard
    end
    
    # Ensure module name is supplied and that it is
    # formatted correctly as module names must be alphanumeric
    # and must begin with a letter.
    def check_module_name
      case 
        when @arguments.empty?; puts 'Module name required.'; exit 3
        when !@arguments[0].match(/^[a-z][\w]+/); puts 'Invalid module name.'; exit 4
        else @module = @arguments[0]
      end
    end
    
    # Run module generation wizard.
    def run_wizard
      # TODO create self.log() with padding to even output
      # Info
      @author = self.ask('What is your name?:')
      @link = self.ask('What is the URI to your companies website?:')
      @email = self.ask('What is your email?:')
      @module_name = self.ask('Enter a human readable name for your module:')
      @module_description = self.ask('Enter a short description of your module:')
      @module_dependencies = self.ask('Enter a list of dependencies for your module:', true)
      # Hooks
      puts self.list_templates('Hooks:', 'hooks')
      @hooks = self.ask('Which hooks would you like to implement?:', true)
      # Files
      puts self.list_templates('Files:', 'txt')
      @files = self.ask('Which additional files would you like to include?:', true)
      # Dirs
      puts "\nCommon directories:"
      puts ['js', 'images', 'css'].collect{ |d| " - " << d }
      @dirs = self.ask('Which directories would you like to create?:', true)
      # Finish
      self.create_tokens
      self.create_hook_weights
      self.create_module
    end
    
    # Create global tokens.
    def create_tokens
      @tokens = {
          :module => @module,
          :link => @link,
          :email => @email,
          :author => @author,
          :module_name => @module_name,
          :module_description => @module_description,
          :module_dependencies => @module_dependencies,
        }
    end
    
    # Register hook weights
    def create_hook_weights
      @hook_weights = [
          'perm',
          'cron',
          'boot',
          'init',
          'menu',
          'schema',
          'theme',
          'form_alter',
          'block',
        ]
    end
    
    # Create module from wizard results.
    def create_module
      puts "\n... Creating module '#{@module}' in '#{@dir}'"
      # TODO: map hooks to specific order...usort equiv
      # Base directory
      create_dir("#{@module}")
      self.create_module_dirs
      self.create_module_files
      self.create_module_file
      self.create_module_install_file
      self.create_module_info_file
      puts 'Module created :)'
    end
    
    # Create directories.
    def create_module_dirs
      @dirs.each{ |dir| create_dir("#{@module}/#{dir}") }
    end
    
    # Create file templates.
    def create_module_files
      @files.each do |file|
        filepath = "#{file.upcase}.txt"
        create_file(filepath)
        append_template(filepath, "txt/#{file}", @tokens)
      end      
    end
    
    # Create .module file.
    def create_module_file
      create_file("#{@module}.module", "<?php\n")
      append_template("#{@module}.module", 'comments/file', @tokens)
      append_template("#{@module}.module", 'comments/large', {'title' => 'Hook Implementations'})
      for hook in @hook_weights
        if @hooks.include?(hook)
          append_template("#{@module}.module", "hooks/#{hook}", @tokens) unless hook.match /^install|schema/
        end
      end      
    end
    
    # Create .install file.
    def create_module_install_file
      if @hooks.include?('schema') || @hooks.include?('schema')
        create_file("#{@module}.install", "<?php\n")
        append_template("#{@module}.install", 'comments/file', @tokens)
        @hooks.each do |hook|
          append_template("#{@module}.install", "hooks/#{hook}", @tokens) if hook.match /^install|schema/
        end
      end      
    end
    
    # Create info file.
    def create_module_info_file
      contents = '; $Id$'
      contents << "\nname = #{@module_name}"
      contents << "\ndescription = #{@module_description}"
      contents << "\ncore = 6.x"
      @module_dependencies.each do |dependency|
        contents << "\ndependencies[] = #{dependency}"
      end
      create_file("#{@module}.info", contents)
    end
    
    # Create a new directory.
    def create_dir(dir)
      dir = "#{@dir}/#{dir}"
      puts "... Creating directory '#{dir}'"
      Dir.mkdir(dir)
    end
    
    # Create a new file.
    def create_file(filepath, contents = '')
      filepath = "#{@dir}/#{@module}/#{filepath}"
      puts "... Creating file '#{filepath}'"
      File.open(filepath, 'w') do |f|
        f.write contents
      end
    end
    
    # Append a tokenized template template to a file.
    def append_template(filepath, template, tokens = {})
      # TODO: ensure template exists
      # TODO: is \n included with STDIN?
      _template = template
      filepath = "#{@dir}/#{@module}/#{filepath}"
      template = File.dirname(__FILE__) + "/templates/#{template}"
      puts "... Adding template '#{_template}' to '#{filepath}'"
      contents = File.read(template)
      tokens.each_pair do |token, value|
        if value.class == String && contents.include?("[#{token}]")
          contents.gsub!(/\[#{token}\]/, value)
        end
      end
      File.open(filepath, 'a') do |f|
        f.write contents
      end
    end
    
    # Prompt user for input
    def ask(question, list = false)
      puts "\n" << question
      # TODO: support 'all'
      # TODO: why is gets not working?
      # TODO: not catching exception when CTRL+C ?
      begin
        case list
          when true; STDIN.gets.split
          when false; STDIN.gets.gsub!(/\n/, '')
        end
      rescue => e
        puts ':)'
      end
    end
    
    # List templates available of a certain type.
    def list_templates(title, type)
      "\n" << title << self.get_templates(type).collect{ |t| "\n - " << File.basename(t) }.join
    end
    
    # Get array of templates of a certain type.
    def get_templates(type)
      Dir[File.dirname(__FILE__) + '/templates/' << type << '/*']
    end
  end
end