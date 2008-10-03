
class DrupalInstall < Test::Unit::TestCase
    def setup
      Drupal.new.run('install ab'.split)
      Kernel.system "mkdir _modules"
      Drupal.new.run('install devel ./_modules'.split)
    end

    def teardown
      Kernel.system "rm -fr ./ab/*"
      Kernel.system "rmdir ./ab"
      Kernel.system "rm -fr ./_modules/*"
      Kernel.system "rmdir ./_modules"
    end

    def test_contrib_cwd
      assert(File.directory?('./ab'), 'Failed to install ab module in cwd.')
    end
    
    def test_contrib_dir
      assert(File.directory?('./_modules/devel'), 'Failed to install devel to _modules directory.')
    end
end
