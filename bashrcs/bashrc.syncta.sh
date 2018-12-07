export SYNCTA_ROOT="$DEV_ROOT/syncta"
export ONEDRIVE_DIR="$HOME/OneDrive - Watts Water Technologies, Inc"

function syncta_ssh() {
  eb ssh $AWS_EB_ENV -e "ssh -i ~/.ssh/c3-staging -L 5433:$RDS_URL:5432"
}

function syncta_ssh_with_stage() {
  eb ssh $AWS_EB_ENV -e "ssh -i ~/.ssh/c3-staging -L 5433:$RDS_URL:5432 -L 5434:$RDS_STAGE_URL:5432"
}

function syncta_scrub_stage() {
  psql --host "$RDS_HOSTNAME" --port "$RDS_PORT" --username "$RDS_STAGE_USERNAME" --dbname "$RDS_RPOD_DB_NAME" --file "$ONEDRIVE_DIR/scrub-stage.sql"
}

function syncta_dump_stage() {
  pg_dump --host "$RDS_HOSTNAME" --port "$RDS_PORT" --username "$RDS_STAGE_USERNAME" --dbname "$RDS_RPOD_DB_NAME" --schema public --clean --if-exists --no-owner --no-privileges --format c --file "$ONEDRIVE_DIR/stage-scrubbed-$(date +%F).dump"
}

function syncta_restore_stage() {
  pg_restore --host "$RDS_HOSTNAME" --port "$RDS_PORT" --username "$RDS_STAGE_USERNAME" --dbname "ccc_staging_$(date +%F)" --schema public --clean --if-exists --no-owner --no-privileges --verbose "$HOME/OneDrive - Watts Water Technologies, Inc/stage-scrubbed-$(date +%F).dump"
}

function syncta_restore_dev() {
  psql -h localhost -p 5432 -U cccuser -d ccc_development -b -f "$ONEDRIVE_DIR/stage-scrubbed-$(date +%F).dump"
}

[ -r "$HOME/.bashrc.syncta.secret.sh" ] && source "$HOME/.bashrc.syncta.secret.sh"

