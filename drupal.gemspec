Gem::Specification.new do |s|
  s.name     = "drupal"
  s.version  = "1.0.0"
  s.date     = "2008-09-29"
  s.summary  = "Drupal development kit"
  s.email    = "tj@vision-media.ca"
  s.homepage = "http://vision-media.ca/resources/ruby/drupal-gem"
  s.description = "Drupal is an open source Ruby development tool allowing developers to quickly generate and manage Drupal modules."
  s.has_rdoc = true
  s.authors  = ["tj@vision-media.ca"]
  s.files    = ["History.txt", 
		"Manifest.txt", 
		"README.txt", 
		"Rakefile", 
		"drupal.gemspec", 
		"lib/drupal.rb", 
		"lib/drupal.create.module.rb", 
		"lib/drupal.todo.list.rb", 
		"lib/templates/comments/file", 
		"lib/templates/comments/large", 
		"lib/templates/hooks/block", 
		"lib/templates/hooks/boot", 
		"lib/templates/hooks/cron", 
		"lib/templates/hooks/form_alter", 
		"lib/templates/hooks/init", 
		"lib/templates/hooks/menu", 
		"lib/templates/hooks/perm", 
		"lib/templates/hooks/schema", 
		"lib/templates/hooks/theme", 
		"lib/templates/txt/changelog", 
		"lib/templates/txt/readme", 
		"bin/drupal"]
  s.test_files = ["test/test_drupal.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
end
