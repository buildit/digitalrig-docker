# internal proxy
helm delete --purge traefik-internal
helm install ../../../charts/stable/traefik --namespace kube-system --name traefik-internal -f ./vars/traefik-internal.yml
minikube service -n kube-system traefik-internal-traefik

# public proxy
helm delete --purge traefik-public
helm install ../../../charts/stable/traefik --namespace kube-system --name traefik-public -f ./vars/traefik-public.yml
minikube service -n kube-system traefik-public-traefik

# to make jenkins data visible on host: minikube ssh >> sudo ln -s /Users/romansafronov/dev/tmp/pv /tmp/hostpath_pv

#jenkins
helm delete --purge jenkins-m
helm install ../../../charts/stable/jenkins --namespace default --name jenkins-m -f ./vars/jenkins.yml

