Gem::Specification.new do |s|
  s.name     = "drupal"
  s.version  = "0.0.4"
  s.date     = "2008-10-03"
  s.summary  = "Drupal development kit"
  s.email    = "tj@vision-media.ca"
  s.homepage = "http://vision-media.ca/resources/drupal/drupal-module-builder-gem"
  s.description = "Drupal is an open source Ruby development tool allowing developers to quickly generate and manage Drupal modules."
  s.has_rdoc = true
  s.require_path = "lib"
  s.authors  = ["tj@vision-media.ca"]
  s.files    = ["History.txt", 
		"Manifest.txt", 
		"README.txt", 
		"Rakefile", 
		"drupal.gemspec", 
		"lib/drupal.rb", 
		"lib/drupal/create_module.rb", 
		"lib/drupal/todo_list.rb", 
		"lib/drupal/install.rb", 
		"lib/drupal/templates/comments/file", 
		"lib/drupal/templates/comments/large", 
		"lib/drupal/templates/hooks/block", 
		"lib/drupal/templates/hooks/boot", 
		"lib/drupal/templates/hooks/cron", 
		"lib/drupal/templates/hooks/form_alter", 
		"lib/drupal/templates/hooks/init", 
		"lib/drupal/templates/hooks/menu", 
		"lib/drupal/templates/hooks/perm", 
		"lib/drupal/templates/hooks/schema", 
		"lib/drupal/templates/hooks/theme", 
		"lib/drupal/templates/txt/changelog", 
		"lib/drupal/templates/txt/readme", 
		"bin/drupal"]
	s.executables = ["drupal"]
  s.test_files = ["test/test_drupal.rb", "test/test_install.rb", "test/test_create_module.rb", "test/test_todo_list.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
end
