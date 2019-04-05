#!/bin/bash

################################################################################
# A simple script to send a message to a discord server.                       #
#                                                                              #
#                                                                              #
################################################################################

PARAMS=""

while (( "$#" )); do
  case "$1" in
    -u|--mention)
      mention="<@$2>"
      shift 2
      ;;
    -m|--message)
      message="$2"
      shift 2
      ;;
    -b|--botname)
      botname="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    -*|--*=)
      echo "Error: Unknown Flag $1" >&2
      exit 1
      ;;
    *)
      PARAMS="$PARAMS $1"
      shift
      ;;
    esac
done

url="https://discordapp.com/api/webhooks/URL"
curl -H "Content-Tyep: application/json" -X POST -d '{"username": "'$botname'", "content": "'$mention' '$message'"}' $url
echo ""

