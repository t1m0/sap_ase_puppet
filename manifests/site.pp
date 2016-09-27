
#include java

# SAP ASE already comes with it's own 
#java::oracle { 'jdk6' :
#	ensure  => 'present',
#	version => '6',
#	java_se => 'jdk',
#}

Package { ensure => 'latest' }
# Default packages
package { 'vim-X11': ensure => 'latest',name => 'vim-X11'}
package { 'vim-enhanced': ensure => 'latest',name => 'vim-enhanced'}
package { 'vim-minimal': ensure => 'latest',name => 'vim-minimal'}
###
# SAP ASE Installation
###
$directories = ['/opt/sybase','/var/sybase','/opt/sybase/install']
# Mandatory for SAP ASE
package { 'glibc.x86_64': ensure => 'latest',name => 'glibc.x86_64'} 
package { 'glibc.i686': ensure => 'latest',name => 'glibc.i686'} ->

group { 'sybase':
	ensure => 'present',
} ->

user { 'sybase':
	ensure => 'present',
    home => '/opt/sybase',
    groups => 'sybase',
} ->

file { $directories:
	ensure => 'directory',
	owner => 'sybase',
    group => 'sybase',
} ->

class { 'sudo':
  purge               => false,
  config_file_replace => false,
} ->

sudo::conf { 'sybase':
  content  => "sybase ALL=(ALL) NOPASSWD: ALL",
} ->

exec { 'extract_tar':
  user    => 'sybase',
  command => '/bin/tar -xf /vagrant/ASE_Suite.linuxamd64.tgz -C /opt/sybase/install',
  creates => '/opt/sybase/install/ASE_Suite'
}# ->

exec { 'install_sap_ase':
  user    => 'sybase',
  command => '/opt/sybase/install/ASE_Suite/setup.bin -i silent -f /vagrant/sample_response.txt -DAGREE_TO_SAP_LICENSE=true',
  creates => '/opt/sybase/interfaces',
  timeout => 2600,
  logoutput => true,
}