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
      c.vm.provision :shell, path: 'flannel-master-conf.sh', privileged: false
      c.vm.provision "file", source: "deploy.yml", destination: "/home/vagrant/deploy-ubuntu.yml"
      c.vm.provision "file", source: "nginx-policy.yml", destination: "/home/vagrant/nginx-policy.yml"
      c.vm.provision "file", source: "deploy-nginx.yml", destination: "/home/vagrant/deploy-nginx.yml"
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
  
  config.vm.provision "shell", inline: <<-SHELL
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> ~/kubernetes.list
    sudo mv ~/kubernetes.list /etc/apt/sources.list.d
    sudo apt-get update
    # Install docker if you don't have it already.
    sudo apt-get install -y docker.io
    apt-get install -y kubelet kubeadm kubectl kubernetes-cni

    # kubelet requires swap off
    swapoff -a
    # keep swap off after reboot
    sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
    # ip of this box
    IP_ADDR=`ifconfig enp0s8 | grep Mask | awk '{print $2}'| cut -f2 -d:`
    # set node-ip
    echo ll
    ls -l /etc/systemd/system/kubelet.service.d/
    sudo sed -i ''  -e  '/$KUBELET_EXTRA_ARGS/s/$/ --node-ip='"$IP_ADDR/"''  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
    sudo systemctl daemon-reload
    sudo systemctl restart kubelet
    sudo ip link set enp0s8 mtu 9000
  SHELL
end
