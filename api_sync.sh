#!/usr/bin/env bash

_API_DIR=".config"
_API_FILE="api_keys"
_CFG_SAMPLES="config_samples"

if [ ! -e "${_API_DIR}/${_API_FILE}" ]
then
    #### sabnzbd config ####
    _SAB_API=$(openssl rand -hex 16)
    _SAB_NZB=$(openssl rand -hex 16)

    mkdir ${_API_DIR}
    echo "_SAB_API = ${_SAB_API}" >> ${_API_DIR}/${_API_FILE}
    echo "_SAB_NZB = ${_SAB_NZB}" >> ${_API_DIR}/${_API_FILE}

    sed -i \
        -e "s/^api_key.*/api_key = ${_SAB_API}/g" \
        -e "s/^nzb_key.*/nzb_key = ${_SAB_NZB}/g" \
        sabnzbd.ini

    #### nzbhydra2 config ####
    _NZB_API=$(openssl rand -hex 13 \
        | tr a-f A-F)

    echo "_NZB_API = ${_NZB_API}" >> ${_API_DIR}/${_API_FILE}

    yq -y -i \
        --arg _YQ_VAR ${_NZB_API} '.main.apiKey = $_YQ_VAR' \
        nzbhydra.yml

    sed -i \
        -e '/  downloaders: \[\]/r hydra_sab_section.txt' \
        -e 's/  downloaders: \[\]/  downloaders:/g' \
        nzbhydra.yml

    sed -i \
        -e "s/^  - apiKey:.*/  - apiKey: ${_SAB_API}/g" \
        nzbhydra.yml


    ### lidarr, radarr, and sonarr configs ####
    _ARR_IN="lidarr:LDR
    radarr:RDR
    sonarr:SNR"

    for ITER in ${_ARR_IN}
    do
        _ITER_IN=_${ITER##*:}_API
        _ITER_API=$(openssl rand -hex 16)

        echo "${_ITER_IN} = ${_ITER_API}" >> ${_API_DIR}/${_API_FILE}

        sed -i \
            "s/^  <ApiKey>.*/  <ApiKey>${_ITER_API}<\/ApiKey>/g" \
            ${ITER%%:*}_config.xml
    done
fi
