#!/bin/bash

ssh-keygen -t ecdsa -b 521 -C "$(whoami)@$(hostname)"
