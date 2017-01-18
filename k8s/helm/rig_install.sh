# internal proxy
helm delete --purge traefik-int
helm install ../../../charts/stable/traefik --namespace kube-system --name traefik-int -f ./vars/traefik-internal.yaml
minikube service -n kube-system traefik-internal-traefik

# public proxy
helm delete --purge traefik-pub
helm install ../../../charts/stable/traefik --namespace kube-system --name traefik-pub -f ./vars/traefik-public.yaml
minikube service -n kube-system traefik-public-traefik

# to make jenkins data visible on host: minikube ssh >> sudo ln -s /Users/romansafronov/dev/tmp/pv /tmp/hostpath_pv

#jenkins
helm delete --purge jenkins
helm install ../../../charts/stable/jenkins --namespace default --name jenkins -f ./vars/jenkins.yaml

#openvpn
helm delete --purge openvpn
helm install ../../../charts/digitalrig/openvpn-k8s --namespace default --name openvpn -f ./vars/openvpn.yaml
minikube service -n default --format "remote {{.IP}} {{.Port}}" openvpn-openvpn

# cleanup helm delete --purge `helm ls -q --all`