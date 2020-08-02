OUT_FILE=${1:-stake.addr}
STAKE_VKEY_FILE=${2:-stake.vkey}

if [ -s "$OUT_FILE" ]
then
   echo "$OUT_FILE already exists! Please specify another target or delete the old one explicitly."
   exit;
fi

if [ ! -s "$STAKE_VKEY_FILE" ]
then
   echo "$STAKE_VKEY_FILE not found. Please provide a file name that holds a stake verification key"
   exit;
fi

cardano-cli shelley stake-address build \
--stake-verification-key-file $STAKE_VKEY_FILE \
--out-file $OUT_FILE \
--$LP_CLUSTER_MAGIC
