#!/bin/bash

chmod 600 deploy_key
scp -i deploy_key -r public/* ${DEPLOY_USER}@${DEPLOY_IP}:${DEPLOY_PATH}
