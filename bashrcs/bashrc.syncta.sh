export SYNCTA_ROOT="$DEV_ROOT/syncta"

function stagify() {
  export RDS_HOSTNAME=localhost
  export RDS_PORT=5433
}

function unstagify() {
  unset RDS_DB_NAME
  unset RDS_USERNAME
  unset RDS_PASSWORD
  unset RDS_HOSTNAME
  unset RDS_PORT
}

[ -r "$HOME/.bashrc.syncta.secret.sh" ] && source "$HOME/.bashrc.syncta.secret.sh"

