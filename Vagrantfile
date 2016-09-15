# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-6.6-64-puppet"
  config.vm.synced_folder "manifests", "/etc/puppet/manifests"
  config.ssh.insert_key = false
  config.vm.network "forwarded_port", guest: 5001, host: 5001
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 5002, host: 5002
  config.vm.network "forwarded_port", guest: 4900, host: 4900
  config.vm.network "forwarded_port", guest: 4282, host: 4282
  config.vm.network "forwarded_port", guest: 4283, host: 4283
  config.vm.network "forwarded_port", guest: 4998, host: 4998
  config.vm.network "forwarded_port", guest: 4992, host: 4992

  config.vm.provider "virtualbox" do |v|
    # Minimum are 4k for java
    v.memory = 5120
  end

  config.vm.provision "shell", inline: <<-SHELL
    #sudo yum upgrade -y
    #sudo yum update -y
    #sudo sysctl -w kernel.shmmax=4294967296
    #sudo /opt/puppetlabs/puppet/bin/puppet module install puppet-archive
    #sudo /opt/puppetlabs/puppet/bin/puppet module install puppetlabs-java
    sudo /opt/puppetlabs/puppet/bin/puppet module install saz-sudo
    sudo chmod 777 /vagrant/ASE_Suite.linuxamd64.tgz
    sudo /opt/puppetlabs/puppet/bin/puppet apply /etc/puppet/manifests/site.pp
    sudo su - sybase -c "tar -xf /vagrant/ASE_Suite.linuxamd64.tgz -C /opt/sybase/install"
    #sudo su - sybase  -c "/opt/sybase/install/ASE_Suite/setup.bin -i silent -f /vagrant/sample_response.txt -DAGREE_TO_SAP_LICENSE=true"
  SHELL
end
