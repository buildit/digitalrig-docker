# Install tiller
helm init

# internal proxy
helm delete --purge traefik-int
helm install ../../charts/stable/traefik --namespace kube-system --name traefik-int -f ./vars/traefik-internal.yaml

# public proxy
helm delete --purge traefik-pub
helm install ../../charts/stable/traefik --namespace kube-system --name traefik-pub -f ./vars/traefik-public.yaml

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
minikube service -n default --format "{{.IP}}:{{.Port}}" openvpn-openvpn

minikube service -n kube-system  --format "http://traefik.kube.local:{{.Port}}" traefik-int-traefik
# cleanup helm delete --purge `helm ls -q --all`
