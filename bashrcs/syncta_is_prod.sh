#!/usr/bin/env sh

if [ -n "$(grep -e "^RDS" "/Users/pbrocoum/dev/syncta/.env.local")" ]; then
  echo " PRODUCTION "
else
  echo "   "
fi
