client
dev tun
proto tcp

remote {{URL}} {{PORT}}

mssfix 1400
resolv-retry 30
nobind
persist-key
persist-tun
mute-replay-warnings
remote-cert-tls server
verb 3

auth-user-pass
auth-nocache

