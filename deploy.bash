#!/bin/bash

##########################################################################################
#                                                                                        #
# Checks out a git revision and make sure the repository is cloned on the remote server. #
# After that it builds and starts the service via docker-compose.                        #
#                                                                                        #
##########################################################################################

### Needs those variables in the environment ###
# REPO_NAME - Repository name to deploy
# REPO_URL - Repository url to deploy
# REVISON - Git revison to deploy
# ENVIRONMENT - Enviroment file string to be used with docker-compose files. https://hexdocs.pm/dotenvy/dotenv-file-format.html
### Variables end ###

### Configuration ###
# Directory on remote server where services should be located
BASE_DIR=/srv
### Configuration end ###

# Concat paths to get target path of service on remote server
repo_path="$BASE_DIR/$REPO_NAME"

# Check if repository is already cloned
if [ ! -d "$repo_path" ] ; then
    # If not we clone the default branch into the target remote path
    # https://git-scm.com/docs/git-clone
    git clone "$REPO_URL" "$repo_path"
fi

# Go into services directory
cd "$repo_path" || exit 1

# Reset current changes if any
# https://git-scm.com/docs/git-reset
git reset --hard

# Switch to target revison
# https://git-scm.com/docs/git-switch
git switch --detach "$REVISON"

# Write enviroment string to file
# https://hexdocs.pm/dotenvy/dotenv-file-format.html
echo "$ENVIRONMENT" > .env.local

# Just to make sure we attend to build the service if needed
# https://docs.docker.com/compose/reference/#use--f-to-specify-name-and-path-of-one-or-more-compose-files
# https://docs.docker.com/compose/environment-variables/set-environment-variables/#substitute-with---env-file
docker-compose --env-file .env.local -f docker-compose.yml -f docker-compose.production.yml build

# Stop running service
docker-compose --env-file .env.local -f docker-compose.yml -f docker-compose.production.yml down

# Start service new now with the revison
docker-compose --env-file .env.local -f docker-compose.yml -f docker-compose.production.yml up -d