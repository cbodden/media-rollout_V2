#!/usr/bin/env bash

_API_DIR=".config"
_API_FILE="api_keys"
_APPDATA="/media_rollout/appdata"
_CFG="config_samples"


#########################################
#### docker & docker compose install ####
#########################################

apt update -y

apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    git-core \
    software-properties-common \
    yq \
    -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
curl -L --fail \
    https://raw.githubusercontent.com/linuxserver/docker-docker-compose/master/run.sh \
    -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
apt install docker-ce


############################################
#### initial docker-compose up and down ####
############################################

docker-compose -f docker_files/docker-compose.yml up -d
docker-compose -f docker_files/docker-compose.yml stop


###################################
#### config file configuraions ####
###################################
if [ ! -e "${_API_DIR}/${_API_FILE}" ]
then
    mkdir ${_API_DIR}

    #### sabnzbd config ####
    _SAB_API=$(openssl rand -hex 16)
    _SAB_NZB=$(openssl rand -hex 16)
    cp ${_CFG}/sabnzbd.ini ${_APPDATA}/sabnzbd/

    echo "_SAB_API = ${_SAB_API}" >> ${_API_DIR}/${_API_FILE}
    echo "_SAB_NZB = ${_SAB_NZB}" >> ${_API_DIR}/${_API_FILE}

    sed -i \
        -e "s/^api_key.*/api_key = ${_SAB_API}/g" \
        -e "s/^nzb_key.*/nzb_key = ${_SAB_NZB}/g" \
        ${_APPDATA}/sabnzbd/sabnzbd.ini
    #### end sabnzbd config ####

    #### nzbhydra2 config ####
    _NZB_API=$(openssl rand -hex 13 \
        | tr a-f A-F)
    cp ${_CFG}/nzbhydra.yml ${_APPDATA}/nzbhydra2/nzbhydra.yml

    echo "_NZB_API = ${_NZB_API}" >> ${_API_DIR}/${_API_FILE}

    yq -y -i \
        --arg _YQ_VAR ${_NZB_API} '.main.apiKey = $_YQ_VAR' \
        ${_APPDATA}/nzbhydra2/nzbhydra.yml

    sed -i \
        -e '/  downloaders: \[\]/r hydra_sab_section.txt' \
        -e 's/  downloaders: \[\]/  downloaders:/g' \
        ${_APPDATA}/nzbhydra2/nzbhydra.yml

    sed -i \
        -e "s/^  - apiKey:.*/  - apiKey: ${_SAB_API}/g" \
        ${_APPDATA}/nzbhydra2/nzbhydra.yml
    #### end nzbhydra2 config ####

    ### lidarr, radarr, and sonarr configs ####
    _ARR_IN="lidarr:LDR
    radarr:RDR
    sonarr:SNR"

    for ITER in ${_ARR_IN}
    do
        _ITER_IN=_${ITER##*:}_API
        _ITER_API=$(openssl rand -hex 16)
        cp ${_CFG}/${ITER%%:*}_config.xml ${_APPDATA}/${ITER%%:*}/config.xml

        echo "${_ITER_IN} = ${_ITER_API}" >> ${_API_DIR}/${_API_FILE}

        sed -i \
            "s/^  <ApiKey>.*/  <ApiKey>${_ITER_API}<\/ApiKey>/g" \
            ${_APPDATA}/${ITER%%:*}/config.xml
    done
    #### end lidarr, radarr, and sonarr configs ####
fi
