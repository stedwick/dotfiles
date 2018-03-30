# Bash
export EDITOR="vim"
export VISUAL="vim"
export HISTCONTROL="ignoreboth"
export GPG_TTY="$(tty)" # for GPG
shopt -s histappend
bind '"\t"':"menu-complete"

# Aliases
alias x="exit"
alias z="clear"
alias c="cat"
alias e="vim"
alias l="ls -hAFGa"
alias ll="ls -lhAFGa"
alias a="ack -i -A 5 -B 5"

# Homebrew
if [ -n "$(type -t brew)" ]; then
  [ -r "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"
  [ -r "$(brew --prefix)/share/liquidprompt" ] && source "$(brew --prefix)/share/liquidprompt"
  [ -r "$(brew --prefix)/share/chruby/chruby.sh" ] && source "$(brew --prefix)/share/chruby/chruby.sh"
fi

# Ruby
function cd() {
  builtin cd "$@" || return
  [ -n "$(type -t chruby)" ] && [ -r ".ruby-version" ] && chruby "$(cat .ruby-version)"
}
cd .

# Python (for tmuxp)
export PATH="$PATH:$(python -c 'import site; print(site.USER_BASE)')/bin"

# Dotfiles
function dln() {
    ln -s "/Users/pbrocoum/Dropbox/Dotfiles/$1" "$HOME/.$1"
}

# Docker
alias d="docker"

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

alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gmm="git merge master"
alias gmd="git merge develop"

alias gss="git stash save"
alias gsp="git stash pop"
alias gsl="git stash list"

# Automatically add completion for all aliases to commands having completion functions
[ -r "$HOME/.alias_completion.sh" ] && source "$HOME/.alias_completion.sh"
