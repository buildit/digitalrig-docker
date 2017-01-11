# see https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto

export PATH=$PATH:/Users/romansafronov/Downloads/EasyRSA-3.0.1/
easyrsa init-pki
easyrsa build-ca
easyrsa gen-req server_req nopass
easyrsa gen-req client_req nopass
easyrsa sign-req client client_req
easyrsa sign-req server server_req

openssl pkcs12 -export -in pki/issued/server_req.crt -inkey pki/private/server_req.key -certfile pki/ca.crt -out vpn.p12

# generate dh
easyrsa gen-dh

# cat dh | base64 to ovpn.yml secret
# cat p12 | base64 to ovpn.yml secret
