#!/bin/bash

eval "$(ssh-agent -s)" #start the ssh agent
chmod 600 deploy_key
ssh-add deploy_key

scp -i deploy_key -r public/* ${DEPLOY_USER}@${DEPLOY_IP}:${DEPLOY_PATH}
