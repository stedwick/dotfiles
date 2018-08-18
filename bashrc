# Bash
export EDITOR="vim"
export VISUAL="vim"
export GPG_TTY="$(tty)" # for GPG
export HISTCONTROL="ignoreboth"
export HISTSIZE="1000000"
export HISTFILESIZE="1000000"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:$HOME/Library/Python/3.7/bin"

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

export RAILS_ENV="development"
export RACK_ENV="development"

[ -r "$HOME/.bashrc.syncta.sh" ]  && source "$HOME/.bashrc.syncta.sh"
[ -r "$HOME/.bashrc.resume.sh" ]  && source "$HOME/.bashrc.resume.sh"

# Docker & Kubernetes
# [ -r "$HOME/.bashrc.docker.sh" ]  && source "$HOME/.bashrc.docker.sh"
# [ -r "$HOME/.bashrc.k8s.sh" ] && source "$HOME/.bashrc.k8s.sh"

# Powerline: currently Vim and Liquidprompt only
if [ -n "$(type -t powerline)" ]; then
  [ -r ~/.use_powerline ] && export USE_POWERLINE=true
fi

# Homebrew
if [ -n "$(type -t brew)" ]; then
  [ -d "$(brew --prefix)/opt/gettext/bin" ] && export PATH="$PATH:$(brew --prefix)/opt/gettext/bin"
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
      if [ -n "$K8S_ROOT" -a -n "$(type -t minikube)" -a -n "$DOCKER_HOST" ]; then
        local minikube_ip=$(minikube ip 2>&1) minikube_ip_exit="$?"
        [ "$minikube_ip_exit" != "0" ] && minikube_ip="oops"
        case "$DOCKER_HOST" in
          *"$minikube_ip"*)
            postfix="\[\033[33m\]minikube\[\033[00m\] $postfix"
          ;;
        esac
      fi
      if [ -n "$RAILS_ENV" -a "$RAILS_ENV" != "development" ]; then
        postfix="\[\033[33m\]$RAILS_ENV\[\033[00m\] $postfix"
      fi
      if [ -n "$K8S_ROOT" -a -n "$(type -t kubectl)" -a -n "$(type -t knamespace)" ]; then
        local _kns="$(knamespace)"
        if [ "$_kns" != "$K8S_NAMESPACE" ]; then
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

function rubocop_changed() {
  if [ -n "$GIT_CHANGED_FILES" ]; then
    git_diff="$GIT_CHANGED_FILES"
  else
    git_diff="$(git status -s | cut -c 4-)"
  fi
  echo "$git_diff"
  echo "$git_diff" | xargs bundle exec rubocop -a --force-exclusion
  echo "$git_diff" | xargs bundle exec rubocop -a --force-exclusion
}

function rspec_changed() {
  if [ -n "$GIT_CHANGED_FILES" ]; then
    git_diff="$GIT_CHANGED_FILES"
  else
    git_diff="$(git status -s | cut -c 4-)"
  fi
  git_diff=$(echo "$git_diff" | xargs -L1 basename | sed 's/\.rb/_spec.rb/' | grep '_spec\.' | xargs -L1 find spec -name)
  echo "$git_diff"
  echo "$git_diff" | xargs bin/rspec
}

# Git
alias g="git"

alias gs="git status"
alias ga="git add -A"
alias gaa="git add"
alias gd="git diff -w --diff-filter=M"
alias gds="git diff -w --diff-filter=M --staged"
alias gdds="git diff -w --staged"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gco="git checkout"
alias gp="git pull"
alias gu="git push"

alias gl="git log"
alias gb="git branch"
alias gw="git show"
alias gt="git tag"

alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gcs="git checkout staging"
alias gcpp="git checkout production"
alias gcp="git checkout philip"

alias gf="git fetch --all"

alias gss="git stash save"
alias gsp="git stash pop"
alias gsl="git stash list"

alias gm="git merge"
alias gmm="git merge master"
alias gmd="git merge develop"
alias gms="git merge staging"
alias gmpp="git merge production"
alias gmp="git merge philip"

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

