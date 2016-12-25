require 'facter'

name 'oneacct-export'
maintainer 'Michal Kimle <kimle.michal@gmail.com>'
homepage 'https://github.com/EGI-FCTF/oneacct_export'
description 'A tool for exporting OpenNebula\'s accounting data to APEL.'

install_dir     '/opt/oneacct-export'
build_version   "0.4.4"
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
when 'Debian', 'Ubuntu'
  runtime_dependency 'redis-server'
when 'CentOS'
  runtime_dependency 'redis'
end

# tweaking package-specific options
package :deb do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'MIT'
  priority 'extra'
  section 'net'
end

package :rpm do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'MIT'
  category 'Applications/System'
end

exclude '\.git*'
exclude 'bundler\/git'
