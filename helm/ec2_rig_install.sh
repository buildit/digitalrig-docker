# Install tiller
helm init
kubectl rollout status deployment/tiller-deploy -n kube-system

#openvpn
helm delete --purge openvpn
helm install ../../charts/digitalrig/openvpn-k8s --namespace default --name openvpn -f ./ec2_vars/openvpn.yaml
# helm upgrade openvpn ../../charts/digitalrig/openvpn-k8s --namespace default -f ./ec2_vars/openvpn.yaml

# internal proxy
helm delete --purge traefik-int
helm install ../../charts/stable/traefik --namespace kube-system --name traefik-int -f ./ec2_vars/traefik-internal.yaml

# at this point need to create/adjust route53 wildcard private record (*.riglet) to make traefik work as internal proxy

# public proxy
helm delete --purge traefik-pub
helm install ../../charts/stable/traefik --namespace kube-system --name traefik-pub -f ./ec2_vars/traefik-public.yaml

# at this point need to create/adjust route53 wildcard record (*.apps.[domain]) to make traefik work as an edge proxy

#jenkins
helm delete --purge jenkins
helm install ../../charts/stable/jenkins --namespace default --name jenkins -f ./ec2_vars/jenkins.yaml

# cleanup helm delete --purge `helm ls -q --all`