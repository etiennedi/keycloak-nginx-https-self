# Nginx Reverse Proxy to add HTTPS for Keycloak

## Why?

tl;dr: Telling minikube to use a locally started OIDC provider is hard.

The goal was to setup an OIDC provider for a local minikube installation. However,
the kubernetes `apiserver` does not support non-https OIDC Issuers. When using a self-signed
certificate `apiserver` accepts a CA. So the goal was to set this up with a rootCA that can then be 
trusted by the API server

## Requirements

Docker, Docker-compose, openssl
Optional: Minikube if you also want to start up minikube with OIDC pointed to the proxied keycloak

## How to use?

It should be relatively easy to reproduce:

### 1. Create CA
Run 
```sh
./create_ca.sh
```

### 2. Create and sign Certificates for nginx
Run 
```sh
./issue_cert.sh
```
This also adds the virtual box magic IP "10.0.2.2" as a subjectAltName to the certificate

### 3. build nginx and start up the network
```sh
docker-compose build && docker-compose up
```

### 4. (Optional) Add client in keycloak
Open https://localhost:8443 and sign in with user `admin` and password `pass`. Then create a client called `kubernetes-cluster`.

### 5. (Optional) start up minikube pointed to keycloak
Run
```sh
./start_minikube.sh
```

You can now use OpenID connect to authenticate against your minikube cluster. Keep in mind that the token will be considered invalid if the
issuer doesn't exactly match the way it was specified when starting up the `apiserver`. This means if you get your token from `localhost` it will not have `10.0.2.2` in the issuer uri. To get around that you can simply create an alias IP. There is a script (`./add_ip.sh`) which works on macOS. On linux you can probably do the same with `iptables`.


