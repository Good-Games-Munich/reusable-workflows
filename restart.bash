#!/bin/bash

# Set that script fails on any error
set -e

############################################
#                                          #
# Restarts the service via docker-compose. #
#                                          #
############################################

### Needs those variables in the environment ###
# REPO_NAME - Repository name to deploy
### Variables end ###

### Configuration ###
# Directory on remote server where services is located
BASE_DIR=/srv
### Configuration end ###

# Concat paths to get target path of service on remote server
repo_path="$BASE_DIR/$REPO_NAME"

# Go into services directory
cd "$repo_path" || exit 1

# Shut down service
docker-compose --env-file .env.local -f docker-compose.yml -f docker-compose.production.yml down

# Start service up again
docker-compose --env-file .env.local -f docker-compose.yml -f docker-compose.production.yml up --detach