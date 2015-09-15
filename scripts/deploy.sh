#!/bin/bash

echo "${DEPLOY_PEM}" > deploy.pem
chmod 600 deploy.pem
scp -i deploy.pem -r public ${DEPLOY_USER}@${DEPLOY_IP}:${DEPLOY_PATH}
