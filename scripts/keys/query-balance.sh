PAYMENT_ADDR_FILE=${1:-payment.addr}

if [ ! -s "$PAYMENT_ADDR_FILE" ]
then
   echo "$PAYMENT_ADDR_FILE not found. Please provide a file name that holds a payment address"
   exit 1;
fi

echo "Current balance of $PAYMENT_ADDR_FILE"
cardano-cli shelley query utxo \
--address $(cat $PAYMENT_ADDR_FILE) \
--$LP_CLUSTER_MAGIC
