#!/usr/bin/env sh

kubectl get svc --all-namespaces | ack -v kube | awk {'print $1" "$3" "$4" "$5'} | column -t

