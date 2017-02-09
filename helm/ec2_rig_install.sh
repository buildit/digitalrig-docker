# Install tiller
helm init
kubectl rollout status deployment/tiller-deploy -n kube-system

#openvpn
helm delete --purge openvpn
helm install ../../charts/digitalrig/openvpn-k8s --namespace default --name openvpn -f ./ec2_vars/openvpn.yaml
# helm upgrade openvpn ../../charts/digitalrig/openvpn-k8s --namespace default -f ./ec2_vars/openvpn.yaml

# internal ingress controller
helm delete --purge nginx-int
helm install ../../charts/stable/nginx-lego --name nginx-int -f ./ec2_vars/nginx-internal.yaml

# public ingress controller
helm delete --purge nginx-pub
helm install ../../charts/stable/nginx-lego --name nginx-pub --namespace public -f ./ec2_vars/nginx-public.yaml

# at this point need to create/adjust route53 wildcard record (*.apps.[domain]) to make traefik work as an edge proxy

#jenkins
helm delete --purge jenkins
helm install ../../charts/stable/jenkins --namespace default --name jenkins -f ./ec2_vars/jenkins.yaml

# cleanup helm delete --purge `helm ls -q --all`