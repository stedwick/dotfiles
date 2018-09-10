#!/usr/bin/env sh

if [ -n "$(grep -e "^RDS" "$SYNCTA_ROOT/.env.local")" ]; then
  echo " PRODUCTION "
else
  echo "   "
fi
