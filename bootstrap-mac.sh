# Bootstrap Mac

# Mac App Store: update and install

# Homebrew: https://brew.sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Base (with https://www.undercoverhq.com/)
brew cask install bitwarden dropbox spotify iterm2 firefox undercover

# Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# Dropbox: Apps (macOS)

# Terminal
brew install bash tmux reattach-to-user-namespace liquidprompt ack git tig gpg pinentry-mac

# Dev (install Xcode from App Store)
brew install chruby ruby-install node postgresql tmate wget git-flow # mosh?
brew cask install visual-studio-code google-chrome imageoptim ngrok slack atom
npm install -g browser-sync
ruby-install ruby # Update .ruby-version
# sudo vim /etc/hosts

# Tmuxomatic: https://github.com/oxidane/tmuxomatic
pip-python3 install tmuxomatic # (?)

# Bitwarden: My SSH & GPG keys (also GitHub public key?)
gpg --import [ example.key ]
gpg --edit-key philip.brocoum@gmail.com
> trust
> 5
gpgconf --kill gpg-agent

# Janus for Vim: https://github.com/carlhuda/janus
curl -L https://bit.ly/janus-bootstrap | bash

# Docker: https://store.docker.com
brew cask install docker
docker volume create portainer_data
docker run --rm -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --name portainer portainer/portainer --no-auth

# Ruby on Rails
gem install rails # `gem pristine --all` if needed

# Completions
brew install bash-completion@2 brew-cask-completion gem-completion bundler-completion rake-completion rails-completion spring-completion docker-completion docker-compose-completion docker-machine-completion

# Dropbox: Dotfiles (link w/ bashrc dln function)
