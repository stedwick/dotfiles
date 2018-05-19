#!/usr/bin/env sh

kubectl get deploy --all-namespaces | ack -v kube | awk '{printf "%s ", substr($1, 1, 12); $1=""; print $0}' | column -t

