#!/bin/bash                                                                                                 [11/26]
# Date:        09-02-2017
# Usage:       volumes-sorted-by-date.sh
# Description: list bacula volumes sorted by last write
#
#

### VARS ###
mapfile -t pools < <(echo "list pools" | sudo bconsole | awk 'NR>9 {print $4}' | head -n -2)


### FUNCTIONS ##
function header(){
  local pool="$1"

  echo " "
  echo "+--------------- $pool ------------+"
  echo " "
}

function ordenated_pool_list(){
  local pool="$1"

  echo "list media pool=$pool" |
    sudo bconsole |
    awk 'NR>9 {print $4" "$24" "$25}' |
    head -n -2 |
    sort -t " " -k2.1,2.4 -k2.9,2.10 -k2.6,2.7

}


### MAIN ###
for pool in ${pools[*]}; do
  header "$pool"

  ordenated_pool_list "$pool"
done

echo " "
