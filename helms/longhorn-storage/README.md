# Declare Repo and download longhorn helmchart
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm search repo longhorn
helm pull longhorn/longhorn --version 1.2.2
tar -xzf longhorn-1.2.2.tgz

#copy to our own file
cp longhorn/values.yaml values-longhorn.yaml
#Make sure on worker node you run:
sudo apt install open-iscsi

#apply and install longhorn storage with our custom values.
helm install longhorn-storage -f values-longhorn.yaml longhorn --namespace storage

#install storage class with 2 reclaim Policy
kubectl apply -f longhorn-storage-class-delete.yaml
kubectl apply -f longhorn-storage-class-retain.yaml

#install pvc with 2 reclaimPolicy
k apply -f longhorn-pvc-delete.yaml
k apply -f longhorn-pvc-retain.yaml

#apply pod to test the volume and pvc
k apply -f test-pod-longhorn-retain.yaml
k apply -f test-pod-longhorn-delete.yaml
