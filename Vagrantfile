# -*- mode: ruby -*-
# vi: set ft=ruby :

$init = <<SCRIPT
sudo /home/vagrant/android-sdk-linux/platform-tools/adb kill-server
sudo /home/vagrant/android-sdk-linux/platform-tools/adb start-server
sudo /home/vagrant/android-sdk-linux/platform-tools/adb devices
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "ionic-android"

  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.provision :shell, run: "always", inline: $init

  config.vm.network "forwarded_port", guest: 8100, host: 8100
  config.vm.network "forwarded_port", guest: 35729, host: 35729

  config.vm.network "forwarded_port", guest:8100, host:8100
  config.vm.network "forwarded_port", guest: 35729, host:35729

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["usbfilter", "add", "0", "--target", :id, "--name", "android", "--vendorid", "0x18d1"]
    vb.memory = '1024'
  end
end
