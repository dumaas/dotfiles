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
cp ./.p10k.zsh ~

# Backup existing .zshrc if it exists
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.backup
fi

# Copy your dotfiles .zshrc to home directory
cp ./.zshrc ~

# If backup exists, append it to the end of the new .zshrc
if [ -f ~/.zshrc.backup ]; then
    echo "" >> ~/.zshrc  # Add blank line for separation
    cat ~/.zshrc.backup >> ~/.zshrc
    rm ~/.zshrc.backup  # Clean up backup file
fi
