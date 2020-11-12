# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ubuntu 20.04 cloud image for vagrant
  config.vm.box = "ubuntu/focal64"
  # https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box
  config.vm.box_version = "20201111.0.1"

  # create wireguard node
  config.vm.define :box do |box|
    # time in seconds that vagrant will wait for the machine to boot
    box.vm.boot_timeout = 300
    # disable automatic box update checking
    box.vm.box_check_update = false

    box.vm.provider "virtualbox" do |vb|
      # the hostname the machine should have
      vb.name = "cryptbox"
      vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      vb.customize ["modifyvm", :id, "--audio", "none"]
      vb.customize ['modifyvm', :id, '--usb', 'on']
      vb.customize ['modifyvm', :id, '--usbehci', 'on']
      # Yubikey 5 NFC
      vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'YubiKey OTP+FIDO+CCID', '--vendorid', '0x1050', '--productid', '0x0407']
    end
  end

  config.vm.provision :shell, privileged: false, path: "bootstrap.sh"
end
