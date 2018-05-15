# Interactive
if [ -n "$PS1" ]; then
  test -e "#{HOME}/.bashrc" && source "${HOME}/.bashrc"
  test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi

