#!/bin/bash

set -o pipefail

if [ "$DEBUG" = "yes" ]; then
    set -x
fi

echo ""
echo "$(date +%Y/%m/%d-%H:%M:%S)"

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
. "${SCRIPT_DIR}/env.sh"

addrFiles=$(find $KEYS_DIR -maxdepth 2 -type f -name "*.addr" -print)
echo $addrFiles | tr " " "\n" > addrFiles.tmp

while addrs= read -r addr
do
        walletName=${addr#${KEYS_DIR}/}
        walletBalance=$(cd ${SCRIPT_DIR} && tonos-cli account $(cat ${addr}))

                if [[ $walletBalance == *found* ]]
                then
                  walletBalance="Not found"
                else
                  walletBalance=$(cd ${SCRIPT_DIR} && tonos-cli account $(cat ${addr}) | grep balance | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')
                  walletBalance=$(echo $walletBalance / 1000000000 | bc -l)
                  walletBalance=$(php getRoundedNumber.php $walletBalance)
                fi

        echo $walletName": "$walletBalance

done < addrFiles.tmp
rm -rf addrFiles.tmp
echo ""

trap - EXIT

exit 0
