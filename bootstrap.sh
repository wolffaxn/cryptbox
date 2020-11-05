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
    pinentry-tty \
    pcscd \
    yubikey-personalization

GPG_HOMEDIR=/home/vagrant/.gnupg
mkdir -p "$GPG_HOMEDIR"
chown -R vagrant:vagrant "$GPG_HOMEDIR"
chmod 700 "$GPG_HOMEDIR"

sudo curl -s -o /etc/ssl/certs/sks-keyservers.netCA.pem https://sks-keyservers.net/sks-keyservers.netCA.pem
cat << EOF > "$GPG_HOMEDIR"/dirmngr.conf
keyserver hkps://hkps.pool.sks-keyservers.net
hkp-cacert /etc/ssl/certs/sks-keyservers.netCA.pem
EOF

GPG_AGENT_CONF="$GPG_HOMEDIR"/gpg-agent.conf
cat << EOF > "$GPG_AGENT_CONF"
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
pinentry-program /usr/bin/pinentry-tty
# cache PIN for at most a day
default-cache-ttl 86400
max-cache-ttl 86400
EOF

cat << EOF > "$GPG_HOMEDIR"/scdaemon.conf
card-timeout 30
# Yubikey 5 NFC
reader-port "Yubico YubiKey OTP FIDO CCID 00 00"
EOF

gpgconf --kill all
