# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # config.vm.box = "ubuntu/bionic64"
  config.vm.box = "bento/centos-7"

  config.vm.define "vagrant-tools" do |pp|
  end

  # config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.synced_folder "../", "/home/vagrant/shared", type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "6000"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"] #limit the use of cpu to 100%
    vb.customize ["modifyvm", :id, "--ioapic", "on"] #needed to use more cpus
    vb.customize ["modifyvm", :id, "--cpus", "4"]  #enable 4 cpus for the vm
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]  #fix dns
  end
  
  config.vm.provision "shell", path: "provision.sh"
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/provision.yml"
    ansible.install = false
  end
end
