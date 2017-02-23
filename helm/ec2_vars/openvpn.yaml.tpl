image:
  repository: builditdigital/openvpn-k8s
  tag: latest
  pullPolicy: Always
service:
  type: LoadBalancer
  externalPort: 443
  internalPort: 443
  protocol: tcp
openvpn:
    # Network allocated for openvpn clients (default: 10.240.0.0).
    network: 10.240.0.0
    # Network subnet allocated for openvpn client (default: 255.255.0.0).
    subnet:  255.255.0.0
    # Protocol used by openvpn tcp or udp (default: udp).
    proto: tcp
    # Base64 of server dh
    dhPem: {{ .dhPem }}
    # Base64 of p12 certificate store
    certsP12: {{ .certsP12 }}
    # Base64 of password
    ldapPass: {{ .ldapPass }}
    auth:
      cert: true
      ldap: true
    rawOpts:
      # this magic is needed to add host VPC network
      # todo: add it into openvpn image
      # 'duplicate-cn' is needed to be able to use same client key
      value: |-
        push "route 172.20.0.0 255.255.0.0"\nduplicate-cn
resources:
  limits:
    cpu: 1000m
    memory: 198Mi
  requests:
    cpu: 200m
    memory: 128Mi
k8s:
  network: 100.0.0.0
  subnet: 255.0.0.0
  pod:
    # Kubernetes pod network (optional).
    network: 10.0.0.0
    # Kubernetes pod network subnet (optional).
    subnet: 255.0.0.0

ldap:
  url: ldap://{{ .ldapIP }}
  basename: CN=Users,dc=corp,dc=riglet,dc=io
  bindname: CN={{ .vpnUser }},CN=Users,DC=corp,DC=riglet,DC=io
  loginattr: CN
