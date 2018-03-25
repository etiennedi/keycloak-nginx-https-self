#!/bin/bash

minikube \
  --extra-config apiserver.Authentication.OIDC.IssuerURL=https://10.0.2.2:8444/auth/realms/master \
  --extra-config apiserver.Authentication.OIDC.UsernameClaim=sub \
  --extra-config apiserver.Authentication.OIDC.ClientID=kubernetes-cluster \
  --extra-config apiserver.Authentication.OIDC.CAFile=$(pwd)/rootCA.crt \
  start

#  --extra-config apiserver.Authorization.Mode=RBAC \

