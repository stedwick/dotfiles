# Interactive
if [ -n "$PS1" ]; then
  test -r "${HOME}/.bashrc" && source "${HOME}/.bashrc"
  test -r "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi

