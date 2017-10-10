name 'oneacct-export'
maintainer 'Boris Parak <parak@cesnet.cz>'
homepage 'https://github.com/the-oneacct-export-project/oneacct-export'
description 'A tool for exporting OpenNebula\'s accounting data to APEL.'

install_dir     '/opt/oneacct-export'
build_version   "0.5.0"
build_iteration 1

override :rubygems, :version => '2.4.8'
## WARN: do not forget to change RUBY_VERSION in the postinst script
##       when switching to a new minor version
override :ruby, :version => '2.1.9'

# creates required build directories
dependency 'preparation'

# oneacct-export dependencies/components
dependency 'oneacct-export'

# version manifest file
dependency 'version-manifest'

if File.exists? '/etc/redhat-release'
  runtime_dependency 'redis'
else
  runtime_dependency 'redis-server'
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
