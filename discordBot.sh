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
    -i|--image)
      profileImage="$2"
      shift 2
      ;;
    -h|--help)
      echo "Simple Discord Bot help"
      echo "Usage: ./discordBot.sh -m MESSAGE"
      echo ""
      echo "Flags:
      -u --mention: Mention a specific user (Userid)
      -m --message: The message you wish to send
      -b --botname: The name you want the bot to display
      -i --image: The profile image you want the bot to display (URL link)
      -h --help: Display help information"
      exit 1
      ;;
    --)
      shift
      break
      ;;
    -*|--*=)
      echo "Error: Unknown Flag $1" >&2
      echo "Use -h or --help for more information"
      exit 1
      ;;
    *)
      PARAMS="$PARAMS $1"
      shift
      ;;
    esac
done

url="https://discordapp.com/api/webhooks/URL"
curl -H "Content-Tyep: application/json" -X POST -d '{"username": "'$botname'", "avatar_url": "'$profileImage'", "content": "'$mention' '$message'"}' $url
echo ""
