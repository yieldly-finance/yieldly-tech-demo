#!/bin/bash


date '+keyreg-teal-test start %Y%m%d_%H%M%S'

set -e
set -x
set -o pipefail
export SHELLOPTS

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

gcmd="goal"

ACCOUNT=""

APPID=""
ASSETID=""

ESCROW=$(${gcmd} clerk compile ../contracts/escrow.teal | awk '{ print $2 }'|tail -n 1)

#${gcmd} app optin  --app-id $APPID --from $ACCOUNT 

${gcmd} app call --app-id $APPID  --app-arg "str:opt" --from $ACCOUNT  --out=txn1.tx
${gcmd} asset send -a 0 -f ${ESCROW} -t ${ESCROW} --assetid ${ASSETID} --out=txn2.tx


cat txn1.tx txn2.tx > combinedtxn.tx
${gcmd} clerk group -i combinedtxn.tx -o groupedtxn.tx 
${gcmd} clerk split -i groupedtxn.tx -o split.tx 
${gcmd} clerk sign -i split-0.tx -o signout-0.tx
# THIS ALLOWS ME TO SIGN WITH APPLICATION LOGIC
${gcmd} clerk sign -i split-1.tx -o signout-1.tx -p ../contracts/escrow.teal
cat signout-0.tx signout-1.tx > signout.tx

${gcmd} clerk rawsend -f signout.tx
#${gcmd} clerk dryrun -t signout.tx --dryrun-dump -o dump1.dr
#tealdbg debug ../contracts/reward_fund_opting.teal -d dump1.dr

${gcmd} app read --app-id $APPID --guess-format --global --from $ACCOUNT
${gcmd} app read --app-id $APPID --guess-format --local --from $ACCOUNT

rm *.tx