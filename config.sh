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