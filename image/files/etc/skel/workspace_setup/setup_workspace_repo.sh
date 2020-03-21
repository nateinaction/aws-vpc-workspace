#!/bin/bash

REPO_NAME="workspace"
REPO_OWNER="nateinaction"
REPO_URL="git@github.com:${REPO_OWNER}/${REPO_NAME}.git"
REPO_LOCAL_PATH="${HOME}/code/github.com/${REPO_OWNER}"

mkdir -p "${REPO_LOCAL_PATH}"
git clone "${REPO_URL}" "${REPO_LOCAL_PATH}"
