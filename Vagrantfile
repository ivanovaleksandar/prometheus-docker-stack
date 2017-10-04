VAGRANT_API_VERSION = '2'
Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 2048
  end

  config.vm.define :prometheus_stack do |prometheus_stack|
    prometheus_stack.vm.box = 'ubuntu/xenial64'
    prometheus_stack.vm.host_name = 'prometheus.local'
    prometheus_stack.vm.synced_folder 'saltstack/salt', '/srv/salt'
    prometheus_stack.vm.network 'private_network', ip: '192.168.10.50'

    prometheus_stack.vm.provision :salt do |salt|
      salt.masterless = true
      salt.minion_config = 'saltstack/etc/minion'
      salt.run_highstate = true
    end
  end
end
