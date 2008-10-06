
class Drupal
  class Todo_List
    
    # Run todo list
    def run(arguments)
      @total = 0
      @arguments = arguments
      @total_only = true if @arguments[0] == 'total'
      @arguments.shift if @total_only == true
      parse_dir('.') if @arguments.empty?
      for argument in @arguments
        parse_file(argument) if File.file?(argument)
        parse_dir(argument) if File.directory?(argument)
      end
      puts "Total todo items: #{@total}" if @total_only == true
    end
    
    # Parse file for todo items.
    def parse_file(filepath)
      File.open(filepath) do |file|
        items = []
        file.each_line do |line|
          matches = line.match /(?:#|\/\/|\/\*|@)[\s]*todo:?[\s]*(.+)$/i
          items << matches[1] unless matches.nil? || matches.length <= 0
          @total += 1 unless matches.nil? || matches.length <= 0
        end
        puts "\n" + filepath unless items.empty? || @total_only == true
        items.each{ |item| puts "   - #{item}" } unless @total_only == true
      end
    end
    
    # Parse directory for todo items.
    def parse_dir(dir)
      Dir["#{dir == '.' ? '.' : dir}/**/*"].each do |file|
        parse_file(file) if File.file?(file)
      end
    end
  end
end