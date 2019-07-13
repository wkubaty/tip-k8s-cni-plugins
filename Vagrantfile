Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false


  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "1448"
  end

  config.vm.define "master" do |c|
    c.vm.hostname = "master"
    c.vm.network "private_network", ip: "172.16.1.100"
    
    if ENV['VAGRANT_CNI_PLUGIN'] == 'CALICO'
      config.vm.provision "shell", privileged: false, inline: "echo 'plugin: Calico'"
      c.vm.provision :shell, path: 'calico-master-conf.sh', privileged: false 
    elsif ENV['VAGRANT_CNI_PLUGIN'] == 'WEAVE'
      config.vm.provision "shell", privileged: false, inline: "echo 'plugin: Weave'"
      c.vm.provision :shell, path: 'weave-master-conf.sh', privileged: false
      c.vm.provision "file", source: "nginx-policy.yml", destination: "/home/vagrant/nginx-policy.yml"
      c.vm.provision "file", source: "deploy-nginx.yml", destination: "/home/vagrant/deploy-nginx.yml"
    else
      config.vm.provision "shell", privileged: false, inline: "echo 'plugin: Flannel'"
      c.vm.provision :shell, path: 'flannel-master-conf.sh', privileged: false
    end
    c.vm.provision "file", source: "deploy.yml", destination: "/home/vagrant/deploy.yml"
  end

  config.vm.define "worker1" do |c|
      c.vm.hostname = "worker1"
      c.vm.network "private_network", ip: "172.16.1.101"
      c.vm.provision :shell, path: 'worker-conf.sh'
  end

  config.vm.define "worker2" do |c|
      c.vm.hostname = "worker2"
      c.vm.network "private_network", ip: "172.16.1.102"
      c.vm.provision :shell, path: 'worker-conf.sh'
  end

  config.vm.provision "shell", path: 'config.sh'
  
end
