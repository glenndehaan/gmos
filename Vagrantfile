# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "bento/ubuntu-18.04"
  config.vm.define "gmos" do |gmos|
  end

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "./", "/mnt/gmos"

  config.vm.provider "virtualbox" do |vb|
     # Customize the amount of memory on the VM:
     vb.cpus = 2
     vb.memory = "2048"
  end
end
