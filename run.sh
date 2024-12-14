#!/bin/bash

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v toolpath ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); toolpath=$(realpath --canonicalize-missing ${scriptpath}/${relativepath}); fi

# Load Configuration
libpath=$(readlink --canonicalize-missing "${toolpath}/includes")
source ${libpath}/functions.sh


# Optional argument
engine=${1-"podman"}

# Container Name
containername="hailodfc-docker"

# Container Image
containerimage="hailodfc-docker:debian-latest"

# Folder Bind Mount
containerbindfolder="./models"

# Load the Environment Variables into THIS Script
if [[ -f ./.env ]]
then
    eval "$(shdotenv --env .env || echo \"exit $?\")"
fi

# Terminate and Remove Existing Containers if Any
${engine} stop --ignore ${containername}
${engine} rm --ignore ${containername}

# Run Image with Infinite Loop to prevent it from automatically terminating
${engine} run --privileged -d --name=${containername} --env-file "./.env" -v "${containerbindfolder}:/models" localhost:5000/local/"${containerimage}"

# Open Interactive Shell with Container
${engine} exec -it ${containername} /bin/bash
