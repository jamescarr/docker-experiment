# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

DEFAULT_BOX     = 'docker_experiment2'
DEFAULT_BOX_URL = 'http://files.vagrantup.com/precise64.box'
DOMAIN          = 'example.com'

Vagrant.configure("2") do |config|
  node_definitions().each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box     = node[:box]
      node_config.vm.box_url = node[:box_url]
      node_config.vm.hostname = "#{node[:hostname]}.#{DOMAIN}"
      node_config.vm.network :private_network, ip: node[:ip]
      
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node[:ram].to_s]
      end

      node_config.vm.provision :shell, :inline => set_hostname(node)
      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
        puppet.manifest_file = 'site.pp'
      end
    end
  end
end

def set_hostname(node)
  $hostname_script = <<SCRIPT
echo "#{node[:hostname]}" >> /etc/hostname
hostname #{node[:hostname]}
SCRIPT

  $hostname_script

end

def node_definitions()
  nodes = YAML.load_file( "#{File.dirname(__FILE__)}/nodes.yaml" )
  puppet_nodes = []
  subnet=10
  nodes.each_key do |node_name|
    (1..3).each do |n|
      nodenum = "#{n}".rjust(2,'0')
      subnet += 1
      node_config = nodes[node_name]
      puppet_nodes << {:hostname    => "#{node_name}#{nodenum}",  
                       :ip          => "172.16.32.#{subnet}", 
                       :box         => node_config.fetch('box', DEFAULT_BOX), 
                       :box_url     => node_config.fetch('box_url', DEFAULT_BOX_URL),
                       :ram         => node_config.fetch('ram', 256),
                       :sync_folder => node_config.fetch('sync_folder', false)
      } 
    end
  end
  
  puppet_nodes
end
