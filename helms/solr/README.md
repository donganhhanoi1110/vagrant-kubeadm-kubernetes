* helm history solr -n dev
```asciidoc
REVISION	UPDATED                 	STATUS  	CHART     	APP VERSION	DESCRIPTION
1       	Thu May 16 14:38:42 2024	deployed	solr-0.8.1	8.11.1     	Install complete
```
* helm get values solr -n dev
```asciidoc
USER-SUPPLIED VALUES:
addressability:
  external:
    domainName: swissre.magnolia-platform.com
    ingressTLSTermination:
      tlsSecret: swissre-magnolia-platform-com
    method: Ingress
    useExternalAddress: false
dataStorage:
  type: persistent
image:
  tag: 8.11.3
ingressOptions:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/auth-secret: solr-basic-auth
    nginx.ingress.kubernetes.io/auth-type: basic
podOptions:
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: technology
              operator: In
              values:
              - solr-cloud
            - key: solr-cloud
              operator: In
              values:
              - solr
          topologyKey: kubernetes.io/hostname
        weight: 100
solrOptions:
  javaMemory: -Xms300m -Xmx640m
zk:
  provided:
    image:
      tag: 0.2.15
```
* command:
  * install solr operator: (https://apache.github.io/solr-operator/docs/running-the-operator.html)
    * helm repo add apache-solr https://solr.apache.org/charts && helm repo update
    * kubectl create -f https://solr.apache.org/operator/downloads/crds/v0.8.1/all-with-dependencies.yaml
    * helm install solr-operator apache-solr/solr-operator --version 0.8.1 -n solr
    * helm upgrade -i solr apache-solr/solr --version 0.8.1 -f ./values.yaml --create-namespace -n solr
* we can set the config via API: https://solr.apache.org/guide/8_11/configsets-api.html
* set the schema file in: managed-schema.xml