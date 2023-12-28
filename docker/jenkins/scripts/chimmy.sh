#!/usr/bin/env bash

#los scripts estan configurados en el docker-compose.yml
source /var/scripts/config-chimmy.sh

function info(){
    echo "path actual ${CURRENT_DIR}"
    echo "parametro pasado de consola ${1}"
    echo "el branch -> ${NUEVO_BRANCH}"
}

function setGlobalConfig(){
    # esto es para los usuarios de windows, para que no tire el error de salto de linea.
    # Se debe usar este comando antes de hacer el clone de los repos.
    git config --global core.autocrlf false
}

function getRepoDesarrollo(){
    #borro porque si existe da error el clone
    # verificar que este rm -rf este borrando la carpeta.
    rm -rf origen
    git clone --branch $ORIGEN_BRANCH --single-branch $ORIGEN_REPO origen -q
    echo "--- FIN CLONE ORIGEN ----"
}

function getRepoQA(){
    #borro porque si existe da error el clone
    # verificar que este rm -rf este borrando la carpeta.
    rm -rf destino
    git clone --branch $DESTINO_BRANCH --single-branch $DESTINO_REPO destino -q
    echo "--- FIN CLONE DESTINO ----"
}

function updateDestinoFiles(){
    #NOTA el source siempre debe terminar con una barra
    SOURCE="${CURRENT_DIR}/origen"
    #NOTA el target no debe terminar con barra
    TARGET="${CURRENT_DIR}/destino"
    #sincronizo carpetas
    # -a = archive mode
    # -v = verbose mode
    # --delete = delete files in destino
    # --progress = show progress
    # --exclude = exclude sass cache folders
    rsync -av --delete --progress --exclude .sass-cache/ --exclude .git/ --exclude docker/ $SOURCE $TARGET
    echo "--- FIN RSYNC ----"
}

function pushDestinoBranch(){
    TARGET="${CURRENT_DIR}/destino"
    cd $TARGET
    git config --global user.email "colombinis@gmail.com"
    git config --global user.name "Sebastian Colombini"
    # echo "--- GIT FETCH ----"
    # git fetch --all
    # echo "--- GIT PULL ----"
    # git pull origin $NUEVO_BRANCH
    echo "--- PWD ----"
    pwd
    echo "--- FIN PWD ----"
    echo "--- git remote -v . ----"
    git remote -v
    echo "--- FIN git remote -v ----"
    echo "--- GIT ADD . ----"
    git add .
    echo "--- GIT COMMIT ----"
    git commit -m "Sincronizando $DESTINO_BRANCH"
    echo "--- FIN GIT COMMIT ----"

    #Prueba final
    echo "--- GIT PUSH ----"
    git push origin $DESTINO_BRANCH

    git ftp push --syncroot src/ --insecure --auto-init --user magento --key /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236 --pubkey /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236.pub sftp://165.22.40.6:22/ --remote-root var/www/html/ -vv
}

# function uploadSSH(){

# }

info $1
setGlobalConfig
getRepoDesarrollo
getRepoQA
updateDestinoFiles
pushDestinoBranch
# uploadSSH