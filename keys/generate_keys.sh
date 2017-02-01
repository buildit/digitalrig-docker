# see https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto

# config
set -e
CURDIR=`dirname $0`
TMPNAME=tmp
TMP=$CURDIR/$TMPNAME
EASYRSA_VER=3.0.1
EASYRSA_DIR="$TMP/EasyRSA-$EASYRSA_VER"

# cleanup
mkdir -p $TMP
rm -rf $TMP/keys

if [ ! -d "$TMP/EasyRSA-$EASYRSA_VER" ]
then
    wget -O $TMP/easyrsa.zip https://github.com/OpenVPN/easy-rsa/releases/download/$EASYRSA_VER/EasyRSA-$EASYRSA_VER.zip
    unzip $TMP/easyrsa.zip -d $TMP
fi

# configure easyrsa
PATH=$PATH:$EASYRSA_DIR
export EASYRSA_PKI="$TMP/keys"
export EASYRSA_BATCH=true
export EASYRSA_KEY_SIZE=1024
export EASYRSA_SSL_CONF="$EASYRSA_DIR/openssl-1.0.cnf"
export EASYRSA_EXT_DIR="$EASYRSA_DIR/x509-types"

# generate pki
easyrsa init-pki
easyrsa build-ca nopass

# server
export EASYRSA_REQ_CN=rig-client
easyrsa gen-req server_req nopass
easyrsa sign-req server server_req

# client
export EASYRSA_REQ_CN=rig-server
easyrsa gen-req client_req nopass
easyrsa sign-req client client_req

# generate dh
easyrsa gen-dh
openssl pkcs12 -export -in "$TMP/keys/issued/server_req.crt" -inkey "$TMP/keys/private/server_req.key" -certfile "$TMP/keys/ca.crt" -out "$TMP/keys/vpn.p12" -passout pass:

cp -f "$CURDIR/client.ovpn.tpl" $TMP/client.ovpn

echo '<ca>' >> "$TMP/client.ovpn"
cat "$TMP/keys/ca.crt" >> "$TMP/client.ovpn"
echo '</ca>' >> $TMP/client.ovpn

echo '<key>' >> $TMP/client.ovpn
cat "$TMP/keys/private/client_req.key" >> "$TMP/client.ovpn"
echo '</key>' >> "$TMP/client.ovpn"

echo '<cert>' >> "$TMP/client.ovpn"
cat "$TMP/keys/issued/client_req.crt" >> "$TMP/client.ovpn"
echo '</cert>' >> "$TMP/client.ovpn"

echo "
===============================================
Client VPN file template is at $TMP/client.ovpn
===============================================
Please set following in ovpn.yml
===============================================
=== openvpn.dhPem:"
echo `cat "$TMP/keys/dh.pem" | base64`
echo "=== openvpn.certsP12"
echo `cat "$TMP/keys/vpn.p12" | base64`

