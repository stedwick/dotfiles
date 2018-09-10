# Bootstrap Mac

# Mac App Store: update and install

# Homebrew: https://brew.sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Base
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES
mkdir ~/bin
brew install bash figlet
brew cask install bitwarden dropbox spotify iterm2 bowtie undercover keybase

# Opera: https://www.opera.com
# Page Shadow: https://addons.opera.com/en/extensions/details/page-shadow/
# Postgres: https://postgresapp.com/
# Redis: https://jpadilla.github.io/redisapp/
# Join.me: https://www.join.me
# Miro: http://www.mirovideoconverter.com/
# Setapp: https://setapp.com

# Dropbox: Apps (macOS)

# Terminal
brew install tmux reattach-to-user-namespace vim git tig liquidprompt ack hh tree gpg pinentry-mac # htop glances
# Powerline: Fonts -> Dotfiles/powerline (Inconsolata, 18pt, ~%110 vertical)

# Dev (install Xcode from App Store)
brew install ruby-install chruby node yarn postgresql wget ctags imagemagick awscli # dnsmasq go git-flow tmate colordiff pv gettext
brew cask install visual-studio-code sourcetree gpg-suite slack google-chrome firefox skype imageoptim ngrok virtualbox # docker minikube macsvg
# npm install -g bower
pip3 install --user tmuxp
pip3 install --user powerline-status
ruby-install ruby # Update .ruby-version

# Completions
brew install bash-completion@2 brew-cask-completion gem-completion bundler-completion rake-completion rails-completion spring-completion # docker-completion docker-compose-completion docker-machine-completion

# Janus for Vim: https://github.com/carlhuda/janus
curl -L https://bit.ly/janus-bootstrap | bash

# Syncta
brew cask install homebrew/cask-versions/java8
brew install phantomjs elasticsearch@2.4 aws-elasticbeanstalk
brew cask install chromedriver skype-for-business onedrive

# SSH keys
# GPG keys (GPG Keychain)

# Syncta
# AWS CLI: aws configure
mkdir ~/dev
git clone git@bitbucket.org:jeremiahchurch/ccc.git ~/dev/syncta
cd ~/dev/syncta
# gem pristine --all
git config user.email "philip@c3backflow.com"
cat README.md
# Ultrahook (Bitwarden)
# env.local
# OneDrive: .git/hooks/
# OneDrive shared sync: https://login.microsoftonline.com

# Dropbox: Dotfiles (link w/ bashrc dln function)
# ? .bashrc.syncta.secret.sh
# $HOME/Library/Application\ Support/Code/User/settings.json

# aws-elasticbeanstalk
# https://c3backflow.atlassian.net/wiki/spaces/DEV/pages/15237121/Access+Staging+Production+via+SSH

#####
#####
#####

# nom install -g browser-sync

# GitHub public key?

# GPG
gpg --import [ example.key ]
gpg --edit-key philip.brocoum@gmail.com
> trust
> 5
gpgconf --kill gpg-agent

# Dash: https://kapeli.com/dash
# MySQL: https://www.mysql.com/

# DNSMasq
sudo bash -c 'echo "address=/.localhost/127.0.0.1" > /usr/local/etc/dnsmasq.conf'
sudo bash -c 'echo "address=/.kube/192.168.99.100" > /usr/local/etc/dnsmasq.conf'
sudo /usr/local/sbin/dnsmasq
sudo killall -HUP mDNSResponder
# Edit DNS in System Prefs, add 127.0.0.1 and 8.8.8.8
go get github.com/jsha/minica

# Docker
ln -s ~/Dropbox/Dotfiles/docker-dashboard/sort_with_header.sh ~/bin/

# minikube start
# minikube addons enable metrics-server
# minikube addons enable heapster

# Resume
# .bashrc.default.secret.sh .bashrc.resume.secret.sh
# ~/dev/default-lb/certs
