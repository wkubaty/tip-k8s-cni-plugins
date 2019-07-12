echo 'Start the cluster'
sudo kubeadm --apiserver-advertise-address=172.16.1.100 --pod-network-cidr=10.4.0.0/16 --token=secret.abcdef1234567890 init

sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chmod 777 /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config

sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo mkdir -p /var/lib/weave
sudo sh -c "echo 'password' > /var/lib/weave/weave-passwd"
kubectl create secret -n kube-system generic weave-passwd --from-file=/var/lib/weave/weave-passwd
#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.WEAVE_MTU=8916&password-secret=weave-passwd"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
