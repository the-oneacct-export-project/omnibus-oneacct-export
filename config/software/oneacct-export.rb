name "oneacct-export"
default_version "master"

dependency "ruby"
dependency "rubygems"

source :git => "https://github.com/Misenko/oneacct_export.git"

build do
  gem_name = "oneacct_export"

  gem "build #{gem_name}.gemspec"
  gem "install #{gem_name}-0.0.1.alpha.1.gem -n #{install_dir}/bin --no-rdoc --no-ri"
end
