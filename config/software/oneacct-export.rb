name "oneacct-export"
default_version "0.2.1"

dependency "ruby"
dependency "rubygems"

build do
  gem "install oneacct-export -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
end
