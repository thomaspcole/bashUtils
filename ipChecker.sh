#!/bin/bash

################################################################################
# A simple script to get the DNS name of an IP and test if its online          #
#                                                                              #
# NOW WITH CONVENIENT CSV FORMAT                                               #
################################################################################

PIDS=""

if [[ -z $1 ]]; then
  echo "Invalid Usage"
  echo "Example: ./ipChecker.sh ip-list.txt"
  exit 1
fi

function checkIP() {
  #Try and resolve hostname. If none exists report N/A
  digIP=$(
      record=$(dig -x $1 +short);
      if [ -z $record ]; then echo "N/A";
    else echo ${record::-1};
  fi)

  #ping the address and grep for the number of received packets. This is 0 if it does not ping
  pingIP=$(ping -c 5 -i 0.2 -w 0.5 $1 | grep -i received | awk '{print $4}')

  #if the PingIP variable is 0 then the address does not ping.
  if [[ 0 -eq $pingIP ]]; then
    doesPing="NO"
  else
    doesPing="YES"
  fi

  printf "%s,%s,%s\n" $1 $digIP $doesPing
}

echo "IP,DNS Entry,Is Online"
#read each line in the file passed as the first arguement
while read ip; do
  checkIP $ip &
  PIDS+="$! "
done < $1

for pid in $PIDS; do
  wait $pid
done
