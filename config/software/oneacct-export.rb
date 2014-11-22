name "oneacct-export"
## WARN: do not forget to change ONEACCT_VERSION in the postinst script
default_version "0.2.2"

dependency "ruby"
dependency "rubygems"

build do
  gem "install oneacct-export -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
end
