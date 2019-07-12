echo 'Join the master'
kubeadm join --token=secret.abcdef1234567890 172.16.1.100:6443 --discovery-token-unsafe-skip-ca-verification
