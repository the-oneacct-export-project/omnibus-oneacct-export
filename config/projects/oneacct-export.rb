require 'facter'

name 'oneacct-export'
maintainer 'Michal Kimle'
homepage 'https://github.com/EGI-FCTF/oneacct_export'

install_dir     '/opt/oneacct-export'
build_version   "0.2.5"
build_iteration 1

override :rubygems, :version => '2.4.4'
## WARN: do not forget to change RUBY_VERSION in the postinst script
##       when switching to a new minor version
override :ruby, :version => '2.1.5'

# creates required build directories
dependency 'preparation'

# oneacct-export dependencies/components
dependency 'oneacct-export'

# version manifest file
dependency 'version-manifest'

case Facter.value('operatingsystem')
when 'Debian'
  runtime_dependency 'redis-server'
when 'Ubuntu'
  runtime_dependency 'redis-server'
when 'CentOS'
  runtime_dependency 'redis'
end

exclude '\.git*'
exclude 'bundler\/git'
