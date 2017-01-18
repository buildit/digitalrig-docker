image:
  repository: builditdigital/openvpn-k8s
  tag: latest
  pullPolicy: IfNotPresent
service:
  type: NodePort
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
      ldap: false
k8s:
  network: 172.20.0.0
  subnet: 255.255.0.0
  pod:
    # Kubernetes pod network (optional).
    network: 10.0.0.0
    # Kubernetes pod network subnet (optional).
    subnet: 255.0.0.0

ldap:
  url: ldap://{{ .ldapIp }}
  basename: CN=Users,dc=corp,dc=riglet,dc=io
  bindname: CN={{ .vpnUser }},CN=Users,DC=corp,DC=riglet,DC=io
  loginattr: CN
