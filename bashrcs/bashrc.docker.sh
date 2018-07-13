export DOCKER_ROOT="$RESUME_ROOT/k8s/docker"

function docker_running() {
  local dps=$(docker ps 2>&1) dps_exit="$?"
  echo "$dps_exit"
}

if [ -n "$(type -t docker)" -a -n "$(type -t krun)" ]; then
  if [ $(docker_running) = "0" ]; then
    completions="$(docker image ls | awk '{printf "%s ", $1}')"
    complete -W "$completions" krun
  fi
fi

alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"
alias prune="docker rmi \$(docker images -f \"dangling=true\" -q)"
alias ddrun="docker run --rm -it"
alias dadminer="docker run -d --rm --name adminer -p 8080:8080 adminer"

function ddown() {
  local project="$1"
  shift
  eval "$DOCKER_ROOT/bin/docker.sh $project down $@"
}
function dbuild() {
  local project="$1"
  shift
  eval "$DOCKER_ROOT/bin/docker.sh $project build $@"
}
function dup() {
  local project="$1"
  shift
  eval "$DOCKER_ROOT/bin/docker.sh $project up -d $@"
}
function dlogs() {
  local project="$1"
  shift
  eval "$DOCKER_ROOT/bin/docker.sh $project logs -f $@"
}
function dexec() {
  local project="$1"
  shift
  eval "$DOCKER_ROOT/bin/docker.sh $project exec $@"
}
function drun() {
  local project="$1"
  shift
  eval "$DOCKER_ROOT/bin/docker.sh $project run --rm $@"
}
function reup() {
  ddown "$@"; dbuild "$@";  dup "$@"; prune
}
completions="default resume lb web db app"
complete -W "$completions" ddown
complete -W "$completions" dbuild
complete -W "$completions" dup
complete -W "$completions" dlogs
complete -W "$completions" dexec
complete -W "$completions" drun
complete -W "$completions" reup

