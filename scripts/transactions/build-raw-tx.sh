OUT_FILE=${1:-tx.raw}

PAYMENT2_ADDR_FILE=${2:-payment2.addr}
PAYMENT_ADDR_FILE=${3:-payment.addr}

TX_ID_IX= $4

TX_DRAFT_FILE=${5:-tx.draft}
PROTOCOL_JSON_FILE=${6:-protocol.json}

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

echo "Attempting to get transaction data..."
get-tx-id-and-index.sh $PAYMENT_ADDR_FILE

if [ $# -lt 4 ]
then
   read -p "Please provide a transaction ID and an index in the following syntax: TxHash#TxIx: " TX_ID_IX
fi

if [ ! -s "$TX_DRAFT_FILE" ]
then
   echo "Drafting transaction, so that we can calculate the transaction fee automatically..."
   draft-tx.sh "$TX_DRAFT_FILE" "$PAYMENT2_ADDR_FILE" "$PAYMENT_ADDR_FILE" "$TX_ID_IX"
fi


echo "Attempting to calculate transaction fee..."
AUTO_TX_FEE=$(calculate-fee.sh "$TX_DRAFT_FILE" "$PROTOCOL_JSON_FILE" 2)

read -p "UTXO balance in Lovelaces (as shown in the above table): " UTXO

read -p "Amount to be sent in Lovelaces: " AMOUNT_TO_SEND

read -p "Transaction fee [$AUTO_TX_FEE]: " TX_FEE
TX_FEE=${TX_FEE:-AUTO_TX_FEE}

CHANGE=$(($UTXO - $AMOUNT_TO_SEND - $TX_FEE))

echo "Change to be sent back is $CHANGE Lovelaces"

SLOT_TIP=$(cardano-cli shelley query tip --$LP_CLUSTER_MAGIC | jq -r '.slotNo')
TTL=$(($SLOT_TIP + 200))

echo "Slot tip: $SLOT_TIP. TTL will be: $TTL"

cardano-cli shelley transaction build-raw \
--tx-in $TX_ID_IX \
--tx-out $(cat $PAYMENT2_ADDR_FILE)+$AMOUNT_TO_SEND \
--tx-out $(cat $PAYMENT_ADDR_FILE)+$CHANGE \
--ttl $TTL \
--fee $TX_FEE \
--out-file $OUT_FILE
