# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-6.6-64-puppet"
  config.vm.synced_folder "manifests", "/etc/puppet/manifests"
  config.ssh.insert_key = false
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  config.vm.provision "shell", inline: <<-SHELL
    #sudo yum upgrade -y
    #sudo yum update -y
    sudo /opt/puppetlabs/puppet/bin/puppet module install puppet-archive
    sudo /opt/puppetlabs/puppet/bin/puppet module install puppetlabs-java
    sudo chmod 777 /vagrant/ASE_Suite.linuxamd64.tgz
    sudo /opt/puppetlabs/puppet/bin/puppet apply /etc/puppet/manifests/site.pp
    sudo su - sybase -c "tar -xf /vagrant/ASE_Suite.linuxamd64.tgz -C /opt/sybase/install"
    #sudo su - sybase  -c "/opt/sybase/install/ASE_Suite/setup.bin -i silent -f /vagrant/sample_response.txt -DAGREE_TO_SAP_LICENSE=true"
  SHELL
end
