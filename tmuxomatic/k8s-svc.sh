#!/usr/bin/env sh

kubectl get svc | ack -v kubernetes | awk {'print $1" "$3" "$4" "$5'} | column -t

