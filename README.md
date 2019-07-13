# CNI Plugins Comparison: Flannel, Calico, Weave Net
This Vagrantfile will create three VMs with Kubernetes cluster on it. Communication between Pods is enabled by one of plugins: Flannel, Calico or Weave.

## How to run
### Get vagrant
* Website: [https://www.vagrantup.com/](https://www.vagrantup.com/)
* Source: [https://github.com/hashicorp/vagrant](https://github.com/hashicorp/vagrant)

### Clone repo

### Type:
```
vagrant up
```

Default plugin is Flannel. If you want Calico or Weave set appropriate env before:
```
VAGRANT_CNI_PLUGIN=CALICO vagrant up
```
or
```
VAGRANT_CNI_PLUGIN=WEAVE vagrant up
```
It will bring up 3 VMs: master, worker1 and worker2

You can ssh to each, using:
```
vagrant ssh <VM>
```
where VM is one of: master, worker1, worker2

Go to master and deploy some ubuntu containers to workers:
```
kubectl apply -f deploy.yml
```
While using Weave plugin you can also check out ingress policy.
While still on master:
```
kubectl apply -f deploy-nginx.yml
kubectl apply -f nginx-policy.yml
```
Get to know, where is nginx deployed. Run:
```
kubectl get pods -o wide
```

Ssh on worker with deployed nginx and check out iptables:
```
sudo iptables -L
```
### Clean up
After all experiments type:
```
vagrant destroy -f
```
Your VMs will be removed.
