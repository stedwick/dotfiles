#!/usr/bin/env sh

kubectl get pvc | sed 's/\([A-Z][A-Z]\) \([A-Z][A-Z]\)/\1-\2/g' | awk 'NR<2 {$6=""; print $0; next} {printf "%s %s %s", $1, $2, substr($3, 1, 12); $1=$2=$3=$6=""; print $0}' | column -t
# kubectl get pv | sed 's/\([A-Z][A-Z]\) \([A-Z][A-Z]\)/\1-\2/g' | awk 'NR<2 {$3=$4=$7=""; print $0; next} {printf "%s", substr($1, 1, 12); $1=$3=$4=$7=""; print $0}' | column -t
