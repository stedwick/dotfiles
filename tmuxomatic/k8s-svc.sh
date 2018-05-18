#!/usr/bin/env sh

kubectl get svc --all-namespaces | ack -v kube | awk {'print $1" "$2" "$5" "$6" "$7'} | column -t

