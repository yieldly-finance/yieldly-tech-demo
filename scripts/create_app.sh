#!/bin/bash
# creates and updates the app

date '+keyreg-teal-test start %Y%m%d_%H%M%S'

set -e
set -x
set -o pipefail
export SHELLOPTS

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

gcmd="goal"

ACCOUNT=""

ESCROW=$(${gcmd} clerk compile ../contracts/escrow.teal | awk '{ print $2 }'|tail -n 1)

# Create the App and then update it with the stateless teal escrow
APPID=$(${gcmd} app create --creator ${ACCOUNT} --approval-prog ../contracts/demo.teal --global-byteslices 32 --global-ints 32 --local-byteslices 8 --local-ints 8 --app-arg "addr:"${ACCOUNT} --clear-prog ../contracts/close.teal | grep Created | awk '{ print $6 }')

# Now Needs to update after updating stateless contract
UPDATE=$(${gcmd} app update --app-id=${APPID} --from ${ACCOUNT}  --approval-prog ../contracts/demo.teal   --clear-prog ../contracts/close.teal --app-arg "addr:${ESCROW}" )
${gcmd} app optin  --app-id $APPID --from $ACCOUNT 


# ASSETID=$(${gcmd} asset create --creator ${ACCOUNT} --total 10000000000000000 --unitname DEMO --decimals 6  | awk '{ print $6 }'|tail -n 1)
# echo "Asset ID="$ASSETID
echo "App ID="$APPID 
