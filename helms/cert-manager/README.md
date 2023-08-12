# Install cert-manager
1. helm repo add jetstack [https://charts.jetstack.io](https://charts.jetstack.io/)
2. helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.12.3 --set installCRDs=true
    1. https://artifacthub.io/packages/helm/cert-manager/cert-manager
    2. https://cert-manager.io/docs/configuration/acme/ 
        1. In order to begin issuing certificates, you will need to set up a ClusterIssuer
        or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).
        2. k apply -f clusterissuer-letsencrypt-staging.yaml
		```
		```	
        3. k apply -f clusterissuer-letsencrypt-prod.yaml
