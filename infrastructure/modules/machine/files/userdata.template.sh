#!/bin/bash
# shellcheck disable=SC2154

set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

# Set hostname
echo ${workspace_subdomain} > /etc/hostname

# Add vars to local env
echo "PUBLIC_KEY_BUCKET=${users_public_key_bucket}" >> /etc/environment

# Initiate ssh key sync
/usr/local/bin/sync_ssh_keys.sh "${users_public_key_bucket}"
