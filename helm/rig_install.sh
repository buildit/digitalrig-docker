# Install dashboard (dashboard itself is bundled with minikube)
kubectl apply -f ./local/dashboard_ingress.yaml

# Install heapster monitoring (support local service definition to exclude `kubernetes.io/cluster-service` annotation)
kubectl apply -f ./local/heapster-service.yaml \
              -f https://raw.githubusercontent.com/kubernetes/heapster/release-1.2/deploy/kube-config/standalone/heapster-controller.yaml

# Install tiller
helm init
kubectl rollout status deployment/tiller-deploy -n kube-system

# internal ingress controller
helm delete --purge nginx-int
helm install ../../charts/stable/nginx-lego --name nginx-int -f ./local_vars/nginx-internal.yaml

# public ingress controller
helm delete --purge nginx-pub
helm install ../../charts/stable/nginx-lego --name nginx-pub --namespace public -f ./local_vars/nginx-public.yaml

# to make jenkins data visible on host: minikube ssh >> sudo ln -s /Users/romansafronov/dev/tmp/pv /tmp/hostpath_pv

#jenkins
helm delete --purge jenkins
helm install ../../charts/stable/jenkins --namespace default --name jenkins -f ./local_vars/jenkins.yaml

# AD DC local controller (optional)
helm delete --purge ad-dc
helm install ../../charts/digitalrig/samba-ad-dc/ -n ad-dc -f ./local_vars/ad-dc.yaml

#openvpn
helm delete --purge openvpn
helm install ../../charts/digitalrig/openvpn-k8s --namespace default --name openvpn -f ./local_vars/openvpn.yaml

echo "OpenVPN client configuration"
minikube service -n default --format "vpn_url_is__{{.IP}}:{{.Port}}" openvpn-openvpn
