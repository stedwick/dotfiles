# Bash
export EDITOR="vim"
export VISUAL="vim"
export GPG_TTY="$(tty)" # for GPG
export HISTCONTROL="ignoreboth"
export HISTSIZE="1000000"
export HISTFILESIZE="1000000"
export PATH="$PATH:$HOME/bin:$HOME/go/bin/"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend

# Aliases
alias z="clear"
alias c="cat"
alias e="vim"
alias l="ls -hAFGa"
alias ll="ls -lhAFGa"
alias a="ack -i"
alias aa="ack -i -A 5 -B 2"
alias m="less -FX"
alias j="jobs"
alias cdiff="colordiff -u"

# Apps
export DEV_ROOT="/Users/pbrocoum/dev"
export K8S_ROOT="$DEV_ROOT/k8s"
export RAILS_ENV="development"
export RACK_ENV="development"
export k8s_namespace="resume-development"
[ -r "$HOME/.default.bash" ] && source "$HOME/.default.bash"
[ -r "$HOME/.resume.bash" ] && source "$HOME/.resume.bash"

# Powerline: currently Vim and Liquidprompt only
if [ -n "$(type -t powerline)" ]; then
  echo hi 1>/dev/null
  # export USE_POWERLINE=true
fi

# Homebrew
if [ -n "$(type -t brew)" ]; then
  export PATH="$PATH:$(brew --prefix)/opt/gettext/bin"
  case "$BASH_VERSION" in
    4.*) # Bash 4 (brew install bash)
      [ -r "$(brew --prefix)/share/bash-completion/bash_completion" ] && source "$(brew --prefix)/share/bash-completion/bash_completion" ;;
    3.*) # Bash 3 (masOS default)
      [ -r "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion" ;;
  esac
  if [ -r "$(brew --prefix)/share/liquidprompt" ]; then
    source "$(brew --prefix)/share/liquidprompt"
    function _phils_prompt() {
      local postfix=""
      # Add active docker-machine to prompt
      if [ -n "$DOCKER_MACHINE_NAME" ]; then
        postfix="\[\033[33m\]$DOCKER_MACHINE_NAME\[\033[00m\] $postfix"
      fi
      if [ -n "$(type -t minikube)" -a -n "$DOCKER_HOST" ]; then
        case "$DOCKER_HOST" in
          *"$(minikube ip)"*)
            postfix="\[\033[33m\]minikube\[\033[00m\] $postfix"
          ;;
        esac
      fi
      if [ -n "$RAILS_ENV" -a "$RAILS_ENV" != "development" ]; then
        postfix="\[\033[33m\]$RAILS_ENV\[\033[00m\] $postfix"
      fi
      if [ -n "$(type -t kubectl)" -a -n "$(type -t knamespace)" ]; then
        local _kns="$(knamespace)"
        if [ "$_kns" != "$k8s_namespace" ]; then
          [ -z "$_kns" ] && _kns="default"
          postfix="\[\033[33m\]$_kns\[\033[00m\] $postfix"
        fi
        local _ctx="$(kubectl config current-context)"
        if [ "$_ctx" != "minikube" ]; then
          [ -z "$_ctx" ] && _ctx="unset"
          postfix="\[\033[33m\]$_ctx\[\033[00m\] $postfix"
        fi
      fi
      if [ -n "$postfix" ]; then
        export LP_PS1_POSTFIX="${postfix}$ "
      else
        unset LP_PS1_POSTFIX
      fi
    }
    PROMPT_COMMAND="_phils_prompt; $PROMPT_COMMAND"
  fi
  [ -r "$(brew --prefix)/share/chruby/chruby.sh" ] && source "$(brew --prefix)/share/chruby/chruby.sh"
fi

# Ruby
function cd() {
  builtin cd "$@" || return
  [ -n "$(type -t chruby)" ] && [ -r ".ruby-version" ] && chruby "$(cat .ruby-version)"
}
cd .

# Kubernetes
[ -n "$(type -t kubectl)" ]  && source <(kubectl completion bash)
[ -n "$(type -t minikube)" ] && source <(minikube completion bash)

function knamespace() {
  if [ "$1" = "unset" ]; then
    kubectl config set-context "$(kubectl config current-context)" --namespace= 1>/dev/null
  elif [ -n "$1" ]; then
    kubectl config set-context "$(kubectl config current-context)" --namespace="$1" 1>/dev/null
  else
    kubectl config view | grep namespace | sed 's/.*: //'
  fi
}
completions="unset default resume-development resume-production resume-staging resume-test"
complete -W "$completions" knamespace
if [ -n "$(type -t kubectl)" ]; then
  kubectl config set-context minikube 1>/dev/null
  knamespace "$k8s_namespace"
fi

alias k="kubectl"
alias kg="kubectl get"
alias kga="kubectl get all"
alias kd="kubectl delete"
alias kdA="kubectl delete hpa,deploy,svc,cm --all"
alias kexec="kubectl exec -it"

# alias kdashboard="kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml"

function klogs() {
  kubectl logs -f "deployment/$1" "$@"
}
completions="lb web db app"
complete -W "$completions" klogs

function krestart() {
  kubectl patch -p '{"spec":{"template":{"metadata":{"labels":{"k8s_apply_date":"'$(date +"%s")'"}}}}}' deployment "$@"
}
completions="lb web db app"
complete -W "$completions" krestart

function ka() {
  export K8S_APPLY_DATE="$(date +%s)" # Restart pods even if nothing changes
  [ "$1" = "-f" ] && shift
  local fil="$1"
  shift
  cat "$fil" | envsubst | kubectl apply -f - "$@"
  unset K8S_APPLY_DATE
}

function kdeploy() {
  eval "$K8S_ROOT/bin/deploy.sh $@"
}

function krun() {
  local image="$1"
  shift
  local pod="${image#*_}"
  local pod="${pod//_/-}"-run-"$RANDOM"
  kubectl run --image="$image" -it --rm --restart=Never "$pod" "$@"
}
if [ -n "$(type -t docker)" ]; then
  completions="$(docker image ls | awk '{printf "%s ", $1}')"
  complete -W "$completions" krun
fi

# Docker
alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"
alias prune="docker rmi \$(docker images -f \"dangling=true\" -q)"
alias ddrun="docker run --rm -it"
alias dadminer="docker run -d --rm --name adminer -p 8080:8080 --network '$k8s_namespace' adminer"

function ddown() {
  local project="$1"
  shift
  eval "$K8S_ROOT/docker/bin/docker.sh $project down $@"
}
function dbuild() {
  local project="$1"
  shift
  eval "$K8S_ROOT/docker/bin/docker.sh $project build $@"
}
function dup() {
  local project="$1"
  shift
  eval "$K8S_ROOT/docker/bin/docker.sh $project up -d $@"
}
function dlogs() {
  local project="$1"
  shift
  eval "$K8S_ROOT/docker/bin/docker.sh $project logs -f $@"
}
function dexec() {
  local project="$1"
  shift
  eval "$K8S_ROOT/docker/bin/docker.sh $project exec $@"
}
function drun() {
  local project="$1"
  shift
  eval "$K8S_ROOT/docker/bin/docker.sh $project run --rm $@"
}
function reup() {
  ddown "$@"; dbuild "$@";  dup "$@"; prune
}
completions="default resume lb web db app"
complete -W "$completions" ddown; complete -W "$completions" dbuild; complete -W "$completions" dup; complete -W "$completions" dlogs; complete -W "$completions" dexec; complete -W "$completions" drun; complete -W "$completions" reup

function buildall() {
  export RAILS_ENV=test
  echo ">>> RAILS_ENV=$RAILS_ENV : default"
  dbuild default
  echo ">>> RAILS_ENV=$RAILS_ENV : resume"
  dbuild resume
  export RAILS_ENV=staging
  echo ">>> RAILS_ENV=$RAILS_ENV : default"
  dbuild default
  echo ">>> RAILS_ENV=$RAILS_ENV : resume"
  dbuild resume
  export RAILS_ENV=production
  echo ">>> RAILS_ENV=$RAILS_ENV : default"
  dbuild default
  echo ">>> RAILS_ENV=$RAILS_ENV : resume"
  dbuild resume
  export RAILS_ENV=development
  echo ">>> RAILS_ENV=$RAILS_ENV : default"
  dbuild default
  echo ">>> RAILS_ENV=$RAILS_ENV : resume"
  dbuild resume
}
function mbuildall() {
  eval $(minikube docker-env)
  echo ">>> docker: minikube"
  buildall
  prune
  echo ">>> docker: phil-azure"
  eval $(docker-machine env phil-azure)
  buildall
  prune
  echo ">>> docker: local"
  eval $(docker-machine env -u)
  buildall
  prune
}

# Git
alias g="git"

alias gs="git status"
alias ga="git add -A"
alias gaa="git add"
alias gd="git diff -w --diff-filter=M"
alias gds="git diff -w --diff-filter=M --staged"
alias gdds="git diff -w --staged"
alias gc="git commit -a -m"
alias gcc="git commit -m"
alias gp="git pull"
alias gu="git push"

alias gl="git log"
alias gb="git branch"
alias gw="git show"
alias gt="git tag"

alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gcs="git checkout staging"
alias gcp="git checkout production"

alias gss="git stash save"
alias gsp="git stash pop"
alias gsl="git stash list"

alias gm="git merge"
alias gmm="git merge master"
alias gmd="git merge develop"
alias gms="git merge staging"
alias gmp="git merge production"

function gmnn() {
  git merge "$1" --no-commit --no-ff
}
completions="master staging"
complete -W "$completions" gmnn

# Dotfile linking
function dln() {
  ln -s "$(pwd)/$1" "$HOME/.$1"
}

# Add completion for aliases
unset completions
[ -r "$HOME/.alias_completion.sh" ] && source "$HOME/.alias_completion.sh"

