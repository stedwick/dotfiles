# Bash
export EDITOR="vim"
export VISUAL="vim"
export GPG_TTY="$(tty)" # for GPG
export HISTCONTROL="ignoreboth"
export HISTSIZE="1000000"
export HISTFILESIZE="1000000"
# export PATH="$PATH:$HOME/bin" # included by default?
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
      if [ -n "$postfix" ]; then
        export LP_PS1_POSTFIX="${postfix}$ "
      else
        export LP_PS1_POSTFIX=""
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

function krun() {
  local image="$1"
  shift
  local pod="${image//_/-}"-"$(echo $RANDOM)"
  if [ -n "$*" -a "$1" != "expose" ]; then
    kubectl run --image="$image" -i -t --rm --restart=Never "$pod" -- "$@"
  else
    echo Pod: "$pod"
    kubectl run --image="$image" --attach=true --rm --restart=Never "$pod" 1>/dev/null &
    sleep 3
    kill -s INT %%
    if [ "$1" = "expose" ]; then
      kubectl port-forward "$pod" "$2" 1>/dev/null &
    fi
  fi
}

function kexec() {
  local pod="$1"
  shift
  kubectl exec ${pod#pod/} -i -t -- "$@"
}

alias k="kubectl"
alias kg="kubectl get"
alias kga="kubectl get all"
alias ka="kubectl apply -f"
alias kd="kubectl delete"
alias kdA="kubectl delete deployments,services --all"
# alias kdashboard="kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml"

alias kadminer="krun adminer expose 8080"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"
alias build="docker-compose build"
alias up="docker-compose up -d"
alias down="docker-compose down"
alias prune="docker rmi \$(docker images -f \"dangling=true\" -q)"
alias drun="docker run --rm -it"
alias crun="docker-compose run --rm"

# alias portainer="docker run -d --rm --name portainer -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer --no-auth"
alias dadminer="docker run -d --rm --name adminer -p 8080:8080 --network resume adminer"

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

# Dotfiles
function dln() {
    ln -s "/Users/pbrocoum/Dropbox/Dotfiles/$1" "$HOME/.$1"
}

# Add completion for aliases
[ -r "$HOME/.alias_completion.sh" ] && source "$HOME/.alias_completion.sh"

