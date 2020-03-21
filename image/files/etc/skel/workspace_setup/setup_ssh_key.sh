#!/bin/bash

USER_WORKSPACE="${USER}@${HOSTNAME}"
SSH_DIR="${HOME}/.ssh"
SSH_CONFIG_PATH="${SSH_DIR}/config"
PRIVATE_SSH_KEY_NAME="id_ecdsa"
PRIVATE_SSH_KEY_PATH="${SSH_DIR}/${PRIVATE_SSH_KEY_NAME}"
PUBLIC_SSH_KEY_NAME="${PRIVATE_SSH_KEY_NAME}.pub"
PUBLIC_SSH_KEY_PATH="${SSH_DIR}/${PUBLIC_SSH_KEY_NAME}"

# Create SSH Key
ssh-keygen -t ecdsa -b 521 -C "${USER_WORKSPACE}" -f "${PRIVATE_SSH_KEY_PATH}"

# Set up the ssh config
{
  echo "# github";
  echo "Host github.com";
  echo "   User git";
  echo "   IdentitiesOnly yes";
  echo "   IdentityFile ${PRIVATE_SSH_KEY_PATH}";
} > "${SSH_CONFIG_PATH}"

# Upload the public key to github
sudo docker run --rm -it \
  -w "/workspace" \
  -v "$(pwd)/setup_github_terraform:/workspace" \
  hashicorp/terraform:0.12.23 init
sudo docker run --rm -it \
  -w "/workspace" \
  -e GITHUB_TOKEN \
  -v "$(pwd)/setup_github_terraform:/workspace" \
  -v "${PUBLIC_SSH_KEY_PATH}:${PUBLIC_SSH_KEY_PATH}" \
  hashicorp/terraform:0.12.23 apply \
    -var "ssh_key_name=${USER_WORKSPACE}" \
    -var "public_ssh_key_filepath=${PUBLIC_SSH_KEY_PATH}"
