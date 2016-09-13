include java

java::oracle { 'jdk6' :
	ensure  => 'present',
	version => '6',
	java_se => 'jdk',
}

$packages = [ 'glibc.i686', 'unzip', 'vim-X11','vim-common','vim-enhanced','vim-minimal' ]
$directories = ['/opt/sybase','/var/sybase','/opt/sybase/install']

package { $packages: ensure => 'installed' }

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
