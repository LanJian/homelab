# WIP

kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml

kubectl create secret generic -n cert-manager cloudflare-api-token-secret \
  --from-literal=api-token=`pass -o cloudflare/cert-manager-api-token`
