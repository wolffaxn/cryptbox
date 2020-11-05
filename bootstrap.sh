#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install \
    curl \
    gnupg \
    gnupg-agent \
    scdaemon \
    secure-delete \
    hopenpgp-tools \
    pcscd \
    yubikey-personalization
