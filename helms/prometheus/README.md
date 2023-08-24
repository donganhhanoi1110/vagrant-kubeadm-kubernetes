# Install helm
* helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
* helm repo add stable https://charts.helm.sh/stable
* helm repo update
* helm search repo prometheus |egrep "stack|CHART"
* helm pull prometheus-community/kube-prometheus-stack --version 34.9.0
* tar -xzf kube-prometheus-stack-34.9.0.tgz
* cp kube-prometheus-stack/values.yaml values-prometheus.yaml

## Install
helm install monitoring -f values-prometheus.yaml kube-prometheus-stack --create-namespace -n monitoring
## Upgrade
helm upgrade monitoring -f values-prometheus.yaml kube-prometheus-stack --create-namespace -n monitoring
