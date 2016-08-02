# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

nodes = YAML.load_file("onvm/conf/nodes.conf.yml")
ids = YAML.load_file("onvm/conf/ids.conf.yml")

Vagrant.configure("2") do |config|
  config.vm.box = "tknerr/managed-server-dummy"
  config.ssh.username = ids['username']
  config.ssh.password = ids['password']

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "onvm", "/onvm", disabled: false, create: true

  lnodes = nodes['ctlnodes']
  if lnodes
    lnodes.each do |key|
      config.vm.define "#{key}" do |node|
        nodekey = nodes['logical2physical'][key]

        node.vm.provider :managed do |managed|
          managed.server = nodes[nodekey]['eth0']
        end

        node.vm.provision "#{key}-install", type: "shell", privileged: false do |s|
          s.path = "onvm/" + key + "/scripts/" + key + ".sh"
        end
      end
    end
  end

end
