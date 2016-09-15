
#include java

# SAP ASE already comes with it's own 
#java::oracle { 'jdk6' :
#	ensure  => 'present',
#	version => '6',
#	java_se => 'jdk',
#}

$tools = ['unzip', 'vim-X11','vim-common','vim-enhanced','vim-minimal']
$sybase_packages = [ 'glibc.x86-64' ]
$directories = ['/opt/sybase','/var/sybase','/opt/sybase/install']

#package { $sybase_packages: ensure => 'latest',}

group { 'sybase':
	ensure => 'present',
}

user { 'sybase':
	ensure => 'present',
    home => '/opt/sybase',
    groups => 'sybase',
}

file { $directories:
	ensure => 'directory',
	owner => 'sybase',
    group => 'sybase',
}

class { 'sudo':
  purge               => false,
  config_file_replace => false,
}

sudo::conf { 'sybase':
  content  => "sybase ALL=(ALL) NOPASSWD: ALL",
}