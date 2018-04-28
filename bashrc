# Bash
export EDITOR="vim"
export VISUAL="vim"
export GPG_TTY="$(tty)" # for GPG
export HISTCONTROL="ignoreboth"
export HISTSIZE="1000000"
export HISTFILESIZE="1000000"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend

# Aliases
alias z="clear"
alias c="cat"
alias e="vim"
alias l="ls -hAFGa"
alias ll="ls -lhAFGa"
alias a="ack -i -A 5 -B 5"

# Homebrew
if [ -n "$(type -t brew)" ]; then
  case "$BASH_VERSION" in
    4.*) # Bash 4 (brew install bash)
      [ -r "$(brew --prefix)/share/bash-completion/bash_completion" ] && source "$(brew --prefix)/share/bash-completion/bash_completion" ;;
    3.*) # Bash 3 (masOS default)
      [ -r "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion" ;;
  esac
  if [ -r "$(brew --prefix)/share/liquidprompt" ]; then
    source "$(brew --prefix)/share/liquidprompt"
    function _phils_prompt() {
      # Add active docker-machine to prompt
      if [ "$DOCKER_MACHINE_NAME" = "docker" ]; then
        export LP_PS1_POSTFIX="\[\033[33m\]azure\[\033[00m\] $ "
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

# Docker
alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"
alias build="docker-compose build"
alias up="docker-compose up -d"
alias down="docker-compose down"
alias prune="docker rmi \$(docker images -f \"dangling=true\" -q)"
alias run="docker run --rm -it"
alias crun="docker-compose run --rm"

# Git
alias g="git"

alias gs="git status"
alias ga="git add -A"
alias gaa="git add"
alias gd="git diff -w --diff-filter=M"
alias gds="git diff -w --diff-filter=M --staged"
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
fuction gmnn() {
  git merge "$1" --no-commit --no-ff
}

# Dotfiles
function dln() {
    ln -s "/Users/pbrocoum/Dropbox/Dotfiles/$1" "$HOME/.$1"
}

# Add completion for aliases
[ -r "$HOME/.alias_completion.sh" ] && source "$HOME/.alias_completion.sh"

