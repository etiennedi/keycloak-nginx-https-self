#!/bin/bash 

set -e

openssl genrsa -out cert.key 2048
openssl req -config ./ssl.conf -new -key cert.key -out cert.csr
openssl x509 -req -in cert.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out cert.crt -days 500 -sha256 -extensions v3_req -extfile ssl.conf
