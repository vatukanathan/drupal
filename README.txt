= drupal

http://vision-media.ca/resources/ruby/drupal-module-builder-gem

== DESCRIPTION:

Drupal is an open source Ruby development tool allowing developers 
to quickly generate and manage Drupal modules.

== SYNOPSIS:

	drupal [options] [arguments]

== REQUIREMENTS:

	none

== ARGUMENTS:

	create module        Generates a module skeleton from an interactive wizard.
	todo list [total]    Displays list of todo items or a total.

== OPTIONS:

 	-h, --help       Display this help information.
 	-V, --version    Display version of the Drupal development tool.

== EXAMPLES:

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

== INSTALL:

	sudo gem install drupal
	
== TODO:

  * Add formatted help option
  * Add download of Drupal core install via 'install core [version]'
  * Add download of modules 'install <module> [version]' 
  * Add graceful error handling
  * Add tests

== AUTHOR:

TJ Holowaychuk 
tj@vision-media.ca
http://vision-media.ca

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
