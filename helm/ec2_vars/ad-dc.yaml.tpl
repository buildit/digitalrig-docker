image:
  repository: builditdigital/samba-ad-dc
  tag: latest
  pullPolicy: Always
service:
  type: ClusterIP
persistence:
  enabled: true
  storageClass: generic
  accessMode: ReadWriteOnce
  size: 256Mi
ad:
 realm: corp.riglet.io
 password: {{ .SetMe }}
 strictTls: false
