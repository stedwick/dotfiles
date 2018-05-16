# Bootstrap Mac

# Mac App Store: update and install

# Homebrew: https://brew.sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Base (with https://www.undercoverhq.com/)
brew cask install bitwarden dropbox spotify iterm2 firefox undercover caffeine
mkdir ~/bin

# Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# Dropbox: Apps (macOS)

# Terminal
brew install bash tmux reattach-to-user-namespace liquidprompt ack git tig gpg pinentry-mac vim tree

# Dev (install Xcode from App Store)
brew install chruby ruby-install node postgresql tmate wget git-flow gettext dnsmasq go # mosh?
brew cask install visual-studio-code google-chrome opera imageoptim ngrok slack macsvg docker virtualbox minikube
npm install -g browser-sync
ruby-install ruby # Update .ruby-version

# DNSMasq
sudo bash -c 'echo "address=/.localhost/127.0.0.1" > /usr/local/etc/dnsmasq.conf'
sudo bash -c 'echo "address=/.kube/192.168.99.100" > /usr/local/etc/dnsmasq.conf'
sudo /usr/local/sbin/dnsmasq
# Edit DNS in System Prefs, add 127.0.0.1 and 8.8.8.8

# Tmuxomatic: https://github.com/oxidane/tmuxomatic
pip-python3 install tmuxomatic # (?)

# Go
go get github.com/jsha/minica

# Dash: https://kapeli.com/dash (Setapp?)

# Bitwarden: My SSH & GPG keys (also GitHub public key?)
gpg --import [ example.key ]
gpg --edit-key philip.brocoum@gmail.com
> trust
> 5
gpgconf --kill gpg-agent

# Janus for Vim: https://github.com/carlhuda/janus
curl -L https://bit.ly/janus-bootstrap | bash

# Ruby on Rails (Unneeded thx to Docker?)
gem install rails # `gem pristine --all` if needed

# Completions
brew install bash-completion@2 brew-cask-completion gem-completion bundler-completion rake-completion rails-completion spring-completion docker-completion docker-compose-completion docker-machine-completion

# Dropbox: Dotfiles (link w/ bashrc dln function)
ln -s ~/Dropbox/Dotfiles/docker-dashboard/sort_with_header.sh ~/bin/

