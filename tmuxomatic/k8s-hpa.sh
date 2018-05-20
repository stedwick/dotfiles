#!/usr/bin/env sh

# kubectl get hpa --all-namespaces | awk '{sub(/.*\//, "", $3); printf "%s %s %s ", substr($1, 1, 12), $2, $3; $1=$2=$3=""; print $0}' | column -t
kubectl get hpa --all-namespaces | awk '{sub(/.*\//, "", $3); printf "%s %s ", $2, $3; $1=$2=$3=""; print $0}' | column -t

