Bootstrap Mac

Mac App Store: update and install

# Homebrew: https://brew.sh

# Base
brew cask install bitwarden dropbox spotify iterm2

# Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# Undercover: https://www.undercoverhq.com/

# Dropbox: Apps (macOS)

# Terminal
brew install tmux reattach-to-user-namespace bash liquidprompt ack gpg pinentry-mac

# Dev
brew install git chruby ruby-install node
brew cask install visual-studio-code google-chrome imageoptim ngrok
npm install -g browser-sync
ruby-install ruby # Update .ruby-version
gem install tmuxinator

# Dropbox: Dotfiles (bashrc dln function)

# Python (for tmuxp)
easy_install --user pip
pip install --user tmuxp

# Bitwarden: My SSH & GPG Keys (also GitHub public key?)
gpg --import [ example.key ]
gpg --edit-key philip.brocoum@gmail.com
> trust
> 5
gpgconf --kill gpg-agent

# Janus for Vim: https://github.com/carlhuda/janus

# Docker: https://store.docker.com
brew cask install docker dockstation

# Completions
brew install bash-completion@2 tmuxinator-completion docker-completion docker-compose-completion docker-machine-completion