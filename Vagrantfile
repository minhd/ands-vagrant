# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "centos65"

  config.vm.provision :shell, :path => "scripts/provision.sh"
  config.vm.synced_folder "core", "/var/www/core/", type: "nfs"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 80, host: 8080

end