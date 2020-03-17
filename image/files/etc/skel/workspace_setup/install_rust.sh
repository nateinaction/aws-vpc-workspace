#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
curl -L https://git.io/rustlings | bash
