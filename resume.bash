export RESUME_APP_ROOT="$DEV_ROOT/resume-app"
export RESUME_WEB_ROOT="$DEV_ROOT/resume-web"
export RESUME_DB_ROOT="$DEV_ROOT/resume-db"

RAILS_ENV=development

RAILS_ENV_development=development
RACK_ENV_development=development
RAILS_LOG_TO_STDOUT_development=true
SECRET_KEY_BASE_development=""

RAILS_ENV_test=test
RACK_ENV_test=test
RAILS_LOG_TO_STDOUT_test=true
SECRET_KEY_BASE_test=""

RAILS_ENV_staging=staging
RACK_ENV_staging=staging
RAILS_LOG_TO_STDOUT_staging=true

RAILS_ENV_production=production
RACK_ENV_production=production
RAILS_LOG_TO_STDOUT_production=true

[ -r "$HOME/.resume.secret.bash" ] && source "$HOME/.resume.secret.bash"

