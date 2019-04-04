#!/bin/bash

################################################################################
# A simple script to print out disk usage of a given volume                    #
#                                                                              #
# Add the path of additional disks in the DIRS variable                        #
################################################################################

DIRS=('/dev/sda1' '/dev/sda2')

echo ""
for dir in ${DIRS[@]}; do
  stats=$(df -h $dir)

  if [[ -z $stats ]]; then
    continue
  fi

  drivePerc=$(echo $stats | awk '{ print $12 }' | tr -d %)
  fillPerc=$(( $drivePerc / 2 ))
  spacingChar=$(( 50 - $fillPerc ))

  echo $dir

  echo -n "["

  for (( i = 0; i < fillPerc; i++ )); do
    echo -n "#"
  done

  for (( i = 0; i < spacingChar; i++ )); do
    echo -n "-"
  done

  echo "] "$drivePerc"%"
  echo ""

done
