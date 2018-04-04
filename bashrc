# Bash
export EDITOR="vim"
export VISUAL="vim"
export HISTCONTROL="ignoreboth"
export GPG_TTY="$(tty)" # for GPG
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
  [ -r "$(brew --prefix)/share/liquidprompt" ] && source "$(brew --prefix)/share/liquidprompt"
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

# Git (Deprecated by VS Code?)
alias g="git"

alias gs="git status"
alias ga="git add -A"
alias gd="git diff -w --diff-filter=M"
alias gds="git diff -w --diff-filter=M --staged"
alias gc="git commit -a -m"
alias gp="git pull"
alias gu="git push"

alias gl="git log"
alias gb="git branch"
alias gw="git show"

alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gmm="git merge master"
alias gmd="git merge develop"

alias gss="git stash save"
alias gsp="git stash pop"
alias gsl="git stash list"

# Dotfiles
function dln() {
    ln -s "/Users/pbrocoum/Dropbox/Dotfiles/$1" "$HOME/.$1"
}

# Add completion for aliases
[ -r "$HOME/.alias_completion.sh" ] && source "$HOME/.alias_completion.sh"
