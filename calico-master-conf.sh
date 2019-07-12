echo 'Start the cluster'
sudo kubeadm --apiserver-advertise-address=172.16.1.100 --pod-network-cidr=192.168.0.0/16  --token=secret.abcdef1234567890 init

sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chmod 777 /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config
curl -O https://docs.projectcalico.org/v3.8/manifests/calico.yaml
#sed -i '' -e '/1440/ s//8950/g' calico.yaml
kubectl apply -f calico.yaml
