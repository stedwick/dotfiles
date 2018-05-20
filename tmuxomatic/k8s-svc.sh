#!/usr/bin/env sh

kubectl get svc --all-namespaces | ack -v kube | awk 'NR<2 {$3=$4=""; print $0; next} {printf "%s %s %s %s %s\n", substr($1, 1, 12), $2, $5, $6, $7}' | column -t
# kubectl get svc --all-namespaces | ack -v kube | awk 'NR<2 {$1=$3=$4=""; print $0; next} {printf "%s %s %s %s\n", $2, $5, $6, $7}' | column -t

