OUT_FILE=${1:-payment.addr}
PAYMENT_VKEY_FILE=${2:-payment.vkey}
STAKE_VKEY_FILE=${3:-stake.vkey}

if [ -s "$OUT_FILE" ]
then
   echo "$OUT_FILE already exists! Please specify another target or delete the old one explicitly."
   exit;
fi

if [ ! -s "$PAYMENT_VKEY_FILE" ]
then
   echo "$PAYMENT_VKEY_FILE not found. Please provide a file name that holds a payment verification key"
   exit;
fi

if [ ! -s "$STAKE_VKEY_FILE" ]
then
   echo "$STAKE_VKEY_FILE not found. Please provide a file name that holds a stake verification key"
   exit;
fi

#if [ $# -lt 2 ]
#  then
#    echo "Please provide a payment.vkey and a stake.vkey to get an associated payment address!"
#fi

cardano-cli shelley address build \
--payment-verification-key-file $PAYMENT_VKEY_FILE \
--stake-verification-key-file $STAKE_VKEY_FILE \
--out-file $OUT_FILE \
--$LP_CLUSTER_MAGIC
