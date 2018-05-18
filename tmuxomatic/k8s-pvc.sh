#!/usr/bin/env sh

kubectl get pvc --all-namespaces | sed 's/\([A-Z]\) \([A-Z]\)/\1-\2/g' | awk 'NR<2 {$7=""; print $0; next} {printf "%s %s %s %s %s %s %s\n", $1, $2, $3, substr($4, 1, 12), $5, $6, $8}' | column -t

