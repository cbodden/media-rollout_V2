#!/usr/bin/env bash

#===============================================================================
#          FILE: media-rollout.sh
#         USAGE: ./media_rollout.sh
#   DESCRIPTION: This script rolls out a media stack in docker
#                Check help for description
#       OPTIONS: Check help
#  REQUIREMENTS: fresh ubuntu server install
#          BUGS: probably a bunch
#        AUTHOR: cesar@pissedoffadmins.com
#  ORGANIZATION: pissedoffadmins.com
#       CREATED: 19-OCT-2021
#===============================================================================

## source all the shlib's
for ITER in shlib/core/*.shlib
do
    source ${ITER}
done

for ITER in shlib/services/*.shlib
do
    source ${ITER}
done


clear

## option selection
while getopts "CcUuDdRrGgIiHh" OPT
do
    case "${OPT}" in
        [Cc])
            _menu configure
            ;;
        [Uu])
            _menu update
            ;;
        [Dd]|[Rr])
            _menu remove
            ;;
        [Gg])
            _info >&2
            exit 0
            ;;
        [Ii])
            _menu install
            ;;
        [Hh]|*)
            _usage >&2
            exit 1
            ;;
    esac
done
if [[ ${OPTIND} -eq 1 ]]
then
    _usage >&2
    exit 1
fi
