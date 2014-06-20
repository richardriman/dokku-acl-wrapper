# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV["BOX_NAME"] || "trusty"
BOX_URI = ENV["BOX_URI"] || "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
BOX_MEMORY = ENV["BOX_MEMORY"] || "512"
ACL_DOMAIN = ENV["ACL_DOMAIN"] || "dokku-acl-wrapper.me"
ACL_IP = ENV["ACL_IP"] || "10.0.0.2"

ssh_key = File.open(File.expand_path('~/.ssh/id_dsa.pub'), 'r').read().strip()

$provision = <<SCRIPT
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get -y install git linux-image-extra-\`uname -r\`
  wget -qO- https://raw.github.com/progrium/dokku/master/bootstrap.sh | sudo bash
  mv /home/dokku/.sshcommand /home/dokku/.sshcommand.prev
  echo "/vagrant/dokku-acl-wrapper" >/home/dokku/.sshcommand
  cp /vagrant/test/fixtures/dokku/ACL /home/dokku/ACL
  echo "#{ssh_key}" | sshcommand acl-add dokku user1
SCRIPT

Vagrant::configure("2") do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.hostname = "#{ACL_DOMAIN}"
  config.vm.network :private_network, ip: ACL_IP

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", BOX_MEMORY]
  end

  config.vm.provision :shell, :inline => $provision
end
