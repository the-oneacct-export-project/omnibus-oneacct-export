require 'facter'

name 'oneacct-export'
maintainer 'Michal Kimle'
homepage 'https://github.com/EGI-FCTF/oneacct_export'

install_dir     '/opt/oneacct-export'
build_version   "0.2.1"
build_iteration 1

override :rubygems, :version => '2.4.1'
override :ruby, :version => '2.1.3'

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
