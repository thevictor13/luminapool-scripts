OUT_FILE=${1:-tx.signed}

TX_RAW_FILE=${2:-tx.raw}
PAYMENT_SKEY_FILE=${3:-payment.skey}


if [ -s "$OUT_FILE" ]
then
   echo "$OUT_FILE already exists! Please specify another target or delete the old one explicitly."
   exit 1;
fi

if [ ! -s "$TX_RAW_FILE" ]
then
   echo "$TX_RAW_FILE not found. Please provide a file name that holds a raw transaction"
   exit 1;
fi

if [ ! -s "$PAYMENT_SKEY_FILE" ]
then
   echo "$PAYMENT_SKEY_FILE not found. Please provide a file name that holds the sender's payment signing key"
   exit 1;
fi


cardano-cli shelley transaction sign \
--tx-body-file $TX_RAW_FILE \
--signing-key-file $PAYMENT_SKEY_FILE \
--$LP_CLUSTER_MAGIC \
--out-file $OUT_FILE
