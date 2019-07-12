echo 'Start the cluster'
sudo kubeadm --apiserver-advertise-address=172.16.1.100 --pod-network-cidr=10.244.0.0/16 --token=secret.abcdef1234567890 init

sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chmod 777 /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config

curl https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml -O
sed -i '' -e '/- --kube-subnet-mgr/a\
\        - --iface=enp0s8' kube-flannel.yml
kubectl apply -f kube-flannel.yml
