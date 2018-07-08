#!/usr/bin/env sh

kubectl get po --all-namespaces | ack -v kube | awk '{printf "%s %s ", substr($1, 1, 12), substr($2, 1, 22); $1=$2=""; print $0}' | column -t

