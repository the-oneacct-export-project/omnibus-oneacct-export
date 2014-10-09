name "oneacct-export"
default_version "master"

dependency "ruby"
dependency "rubygems"

build do
  gem_name = "oneacct-export"

  gem "install #{gem_name} -n #{install_dir}/bin --no-rdoc --no-ri"
end
