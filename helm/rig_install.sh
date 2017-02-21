# Install dashboard (dashboard itself is bundled with minikube)
kubectl apply -f ./dashboard/ingress.yaml

# Install tiller
helm init
kubectl rollout status deployment/tiller-deploy -n kube-system

# internal ingress controller
helm delete --purge nginx-int
helm install ../../charts/stable/nginx-lego --name nginx-int -f ./vars/nginx-internal.yaml

# public ingress controller
helm delete --purge nginx-pub
helm install ../../charts/stable/nginx-lego --name nginx-pub --namespace public -f ./vars/nginx-public.yaml

# to make jenkins data visible on host: minikube ssh >> sudo ln -s /Users/romansafronov/dev/tmp/pv /tmp/hostpath_pv

#jenkins
helm delete --purge jenkins
helm install ../../charts/stable/jenkins --namespace default --name jenkins -f ./vars/jenkins.yaml

# AD DC local controller (optional)
helm delete --purge ad-dc
helm install ../../charts/digitalrig/samba-ad-dc/ -n ad-dc -f ./vars/ad-dc.yaml

#openvpn
helm delete --purge openvpn
helm install ../../charts/digitalrig/openvpn-k8s --namespace default --name openvpn -f ./vars/openvpn.yaml

echo "OpenVPN client configuration"
minikube service -n default --format "vpn_url_is__{{.IP}}:{{.Port}}" openvpn-openvpn
