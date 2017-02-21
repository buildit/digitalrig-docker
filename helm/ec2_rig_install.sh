# Install dashboard + ingress record
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml -f ./ec2/dashboard_ingress.yaml

# Install heapster monitoring (see https://github.com/kubernetes/kops/blob/master/docs/addons.md)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/release-1.2/deploy/kube-config/standalone/heapster-service.yaml \
              -f https://raw.githubusercontent.com/kubernetes/heapster/release-1.2/deploy/kube-config/standalone/heapster-controller.yaml

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