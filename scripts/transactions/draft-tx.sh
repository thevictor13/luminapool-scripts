OUT_FILE=${1:-tx.draft}

PAYMENT2_ADDR_FILE=${2:-payment2.addr}
PAYMENT_ADDR_FILE=${3:-payment.addr}

TX_ID_IX=$4

if [ -s "$OUT_FILE" ]
then
   echo "$OUT_FILE already exists! Please specify another target or delete the old one explicitly."
   exit 1;
fi

if [ ! -s "$PAYMENT2_ADDR_FILE" ]
then
   echo "$PAYMENT2_ADDR_FILE not found. Please provide a file name that holds the recipient's payment address"
   exit 1;
fi

if [ ! -s "$PAYMENT_ADDR_FILE" ]
then
   echo "$PAYMENT_ADDR_FILE not found. Please provide a file name that holds the sender's payment address"
   exit 1;
fi

if [ $# -lt 4 ]
then
   echo "Attempting to get transaction data..."
   get-tx-id-and-index.sh $PAYMENT_ADDR_FILE
   read -p "Please provide a transaction ID and an index in the following syntax: TxHash#TxIx: " TX_ID_IX
fi

cardano-cli shelley transaction build-raw \
--tx-in $TX_ID_IX \
--tx-out $(cat $PAYMENT2_ADDR_FILE)+0 \
--tx-out $(cat $PAYMENT_ADDR_FILE)+0 \
--ttl 0 \
--fee 0 \
--out-file $OUT_FILE
