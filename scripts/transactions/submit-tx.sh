TX_SIGNED_FILE=${2:-tx.signed}

if [ ! -s "$TX_SIGNED_FILE" ]
then
   echo "$TX_SIGNED_FILE not found. Please provide a file name that holds a signed transaction"
   exit 1;
fi

cardano-cli shelley transaction submit \
--tx-file $TX_SIGNED_FILE \
--$LP_CLUSTER_MAGIC
