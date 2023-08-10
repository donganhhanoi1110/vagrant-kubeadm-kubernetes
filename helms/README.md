# Vagrant VMs:

1. Follow steps on: https://devopscube.com/kubernetes-cluster-vagrant/
2. GitHub: https://github.com/techiescamp/vagrant-kubeadm-kubernetes
    - log: vagrant up
3. Check ssh-config:
    1. vagrant ssh-config
    2. ssh to master: ssh -i  C:/Users/donga/git-repos/vagrant-kubeadm-kubernetes/.vagrant/machines/master/virtualbox/private_key -p 2222 [vagrant@127.0.0.1](mailto:vagrant@127.0.0.1)
    3. ssh to worker: ssh -i   C:/Users/donga/git-repos/vagrant-kubeadm-kubernetes/.vagrant/machines/node01/virtualbox/private_key -p 2200 [vagrant@127.0.0.1](mailto:vagrant@127.0.0.1)

# K8s ingress controller <> Domain DNS

1. https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes
2. A basic outline of what you’ll need:
    - Some HTTP service running in your cluster
    - nginx ingress controller to receive external traffic and route it to your service
    - cert manager to create https certificates
    - Digital Ocean load balancer to give you a permanent public IP and route requests to your nginx (you need this because technically your K8s machines don’t have a permanent IP addresses) ⇒ if you go with bare metal please go to **Install MetalLB**
    - Configure your domains/subdomains to point to the load balancer via DNS A record.
    
    ## Install NGINX ingress-controller
    
    1. link:https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
        1. https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal-clusters
        2. https://kubernetes.github.io/ingress-nginx/deploy/baremetal/
    2. helm upgrade --install ingress-nginx ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --namespace ingress-nginx --create-namespace
        
    
    ### Install MetalLB
    
    1. https://metallb.universe.tf/installation/
    2. helm install metallb metallb/metallb -f values.yaml --namespace metallb-system --create-namespace
    3. kubectl apply -f values.yaml
    
    ```jsx
    apiVersion: metallb.io/v1beta1
    kind: IPAddressPool
    metadata:
      name: default-pool
      namespace: metallb-system
    spec:
      addresses:
        - 10.0.0.100/28
    ---
    apiVersion: metallb.io/v1beta1
    kind: L2Advertisement
    metadata:
      name: default
      namespace: metallb-system
    spec:
      ipAddressPools:
        - default-pool
    ```
