#!/bin/bash

cat bashrc.additions >> ~/.bashrc

cp ./.gitmessage ~
cp ./.gitconfig ~
git config --global commit.template ~/.gitmessage

# Install oh-my-zsh with Powerlevel10k theme
zsh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)"

# Install plugins
zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
cp ./.zshrc ~
cp ./.p10k.zsh ~

# Provide app-specific configurations to zshrc
if [ -f ~/.shell_override.sh ]; then
    echo "" >> ~/.zshrc  # Add blank line for separation
    cat ~/.shell_override.sh >> ~/.zshrc
fi
