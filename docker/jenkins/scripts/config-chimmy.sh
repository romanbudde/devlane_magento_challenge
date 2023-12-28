#!/usr/bin/env bash

# Variables comunes para utilizar en el proyecto

NOW=$(date +"%Y-%m-%d")
NUEVO_BRANCH="${NOW}_${1}" 

NUEVO_TAG="${1}" #2.2.4 se llama en proceso distinto por lo que este $1 se pasa a otro archivo .sh
CURRENT_DIR=$(pwd)

ORIGEN_REPO=git@bitbucket.org:sacsicomar/chimmy-sacsi.git
ORIGEN_BRANCH=upgrade_patch_jenkins

#test
DESTINO_REPO=git@gitlab.com:roman_budde/chimmy-sacsi.git
# DESTINO_REPO=git@github.com:romanbudde/doppler-wp-plugin.git

#FINAL
# DESTINO_REPO=git@github.com:MakingSense/doppler-wp-plugin.git
DESTINO_BRANCH=upgrade_patch
# DESTINO_BRANCH=master

#show all enviroment variables
function DUMP_ENV(){
    printenv
}