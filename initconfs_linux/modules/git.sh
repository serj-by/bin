#! /usr/bin/env bash
# Setup git an git user data
sudo apt install git
ssh-keygen
echo "Setting up name and E-mail"
git config --global user.name "Serj"
git config --global user.email "serj.by@yahoo.com"
echo "Git config done"