export SYNCTA_ROOT="$DEV_ROOT/syncta"
export ONEDRIVE_DIR="$HOME/OneDrive - Watts Water Technologies, Inc"

function syncta_ssh() {
  eb ssh $AWS_EB_ENV -e "ssh -i ~/.ssh/c3-staging -L 5433:$RDS_URL:5432"
}

function syncta_ssh_stage() {
  eb ssh $AWS_EB_ENV -e "ssh -i ~/.ssh/c3-staging -L 5434:$RDS_STAGE_URL:5432"
}

[ -r "$HOME/.bashrc.syncta.secret.sh" ] && source "$HOME/.bashrc.syncta.secret.sh"

