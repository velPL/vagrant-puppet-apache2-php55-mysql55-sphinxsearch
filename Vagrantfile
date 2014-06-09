# Example 5
#
# Single box with LAMP stack and sample static/dynamic sites via Puppet.
#
box      = 'debian-73-x64-virtualbox-puppet'
url      = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-puppet.box'
hostname = 'zf2'
domain   = 'dev'
ip       = '192.168.56.101'
ram      = '512'

Vagrant.configure("2") do |config|
  config.vm.box = box
  config.vm.box_url = url
  config.vm.hostname = domain
  config.vm.network "private_network", ip: "#{ip}"
  config.vm.synced_folder "./project", "/var/www", id: "webproject"
  config.vm.provision :shell, :inline => "echo \"Europe/Warsaw\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  

  config.vm.provider "virtualbox" do |vb|
	vb.customize ["modifyvm", :id,
		'--name', hostname,
		'--memory', ram]
  end  

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
  end
end
