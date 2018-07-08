#!/usr/bin/env sh

kubectl get hpa --all-namespaces | awk '{sub(/.*\//, "", $3); printf "%s %s ", $2, $3; $1=$2=$3=""; print $0}' | column -t

