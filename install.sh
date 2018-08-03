#!/bin/bash
# インストールシェル

openssl enc -d -aes-256-cbc -salt -k ${1} -in pisuke/slack-token.sh_enc -out pisuke/slack-token.sh


