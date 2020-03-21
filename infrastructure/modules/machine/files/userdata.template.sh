#!/bin/bash
# shellcheck disable=SC2154

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

# Set hostname
sudo hostnamectl set-hostname "${workspace_domain}"

# Add vars to local env
echo "GITHUB_TOKEN=${github_access_token}" >> /etc/environment
echo "PUBLIC_KEY_BUCKET=${users_public_key_bucket}" >> /etc/environment

# Initiate ssh key sync
/usr/local/bin/sync_ssh_keys.sh "${users_public_key_bucket}"
