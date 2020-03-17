#!/bin/bash
# shellcheck disable=SC2154

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

# Add vars to local env
echo "PUBLIC_KEY_BUCKET=${users_public_key_bucket}" >> /etc/environment

# Initiate ssh key sync
/usr/local/bin/sync_ssh_keys.sh "${users_public_key_bucket}"

# Set hostname
hostname ${workspace_subdomain}

# Make code dir
mkdir "$HOME/code"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export $PATH="$PATH:$HOME/.cargo/bin"
curl -L https://git.io/rustlings | bash
