#!/bin/bash

openssl aes-256-cbc -K $encrypted_fd017f77ecb3_key -iv $encrypted_fd017f77ecb3_iv -in deploy_key.enc -out deploy_key -d

eval "$(ssh-agent -s)" #start the ssh agent
chmod 600 deploy_key
ssh-add deploy_key

rsync -i deploy_key --delete --exclude android-field-guide --exclude en --exclude es --exclude ru --exclude --pt --exclude --zh=hans -r public/* ${DEPLOY_USER}@${DEPLOY_IP}:${DEPLOY_PATH}
