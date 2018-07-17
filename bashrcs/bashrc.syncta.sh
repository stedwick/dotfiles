export SYNCTA_ROOT="$DEV_ROOT/syncta"

function syncta_ssh() {
	eb ssh -e "ssh -i ~/.ssh/id_rsa -L 5433:$RDS_URL:5432"
}

function syncta_dump() {
	pg_dump -h $RDS_HOSTNAME -p $RDS_PORT -U $RDS_USERNAME -d $RDS_DB_NAME -c --if-exists -f ~/Documents/Syncta/staging.sql
}

function syncta_import() {
	psql -h localhost -p 5432 -U cccuser -d ccc_development -b -f ~/Documents/Syncta/staging.sql
}

[ -r "$HOME/.bashrc.syncta.secret.sh" ] && source "$HOME/.bashrc.syncta.secret.sh"

