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
## create secret for grafana cloud:
* kubectl create secret generic grafana-cloud --from-literal=username=yourUsername --from-literal=password=yourSecret --dry-run=client -oyaml > grafana-cloud-secret.yaml
* k apply -f grafana-cloud-secret.yaml -n monitoring 

Get info from https://grafana.com/orgs/maxxn9x/hosted-metrics/1152374#sending-metrics
```yaml
prometheus:
  prometheusSpec:
    remoteWrite:
      - url: https://xxx/api/prom/push
        basicAuth:
          username:
            #below is your secretname / key, please check crd-prometheuses.yaml
            name: grafana-cloud
            key: username
          password:
            name: grafana-cloud
            key: password
```