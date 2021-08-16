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

${gcmd} app call --app-id $APPID --app-arg "str:UAT" --from=$ACCOUNT  --out=txn1.tx

${gcmd} clerk sign -i txn1.tx -o signout.tx
${gcmd} clerk rawsend -f signout.tx
# ${gcmd} clerk dryrun -t signout.tx --dryrun-dump -o dump1.dr
# tealdbg debug ../contracts/demo.teal -d dump1.dr

${gcmd} app read --app-id $APPID --guess-format --global --from $ACCOUNT
${gcmd} app read --app-id $APPID --guess-format --local --from $ACCOUNT

rm *.tx
