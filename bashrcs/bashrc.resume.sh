export RESUME_ROOT="$DEV_ROOT/resume"
export RESUME_APP_ROOT="$RESUME_ROOT/resume-app"
export RESUME_WEB_ROOT="$RESUME_ROOT/resume-web"
export RESUME_DB_ROOT="$RESUME_ROOT/resume-db"

[ -r "$HOME/.bashrc.resume.secret.sh" ] && source "$HOME/.bashrc.resume.secret.sh"

[ -r "$HOME/.bashrc.default.sh" ] && source "$HOME/.bashrc.default.sh"
[ -r "$HOME/.bashrc.docker.sh" ]  && source "$HOME/.bashrc.docker.sh"

