TX_DRAFT_FILE=${1:-tx.draft}
PROTOCOL_JSON_FILE=${2:-protocol.json}
TX_OUT=${3:-2}

if [ ! -s "$TX_DRAFT_FILE" ]
then
   echo "$TX_DRAFT_FILE not found. Please provide a file name that holds a transaction draft"
   exit 1;
fi

if [ ! -s "$PROTOCOL_JSON_FILE" ]
then
   echo "$PROTOCOL_JSON_FILE not found. Please provide a file name that contains protocol parameters"
   exit 1;
fi

if [ $# -lt 3 ]
then
   read -p "Transaction out count (2 for simple transfers, 1 for registrations or voting) [2]: " TX_OUT
fi

TX_OUT=${TX_OUT:-2}

cardano-cli shelley transaction calculate-min-fee \
--tx-body-file $TX_DRAFT_FILE \
--tx-in-count 1 \
--tx-out-count $TX_OUT \
--witness-count 1 \
--byron-witness-count 0 \
--$LP_CLUSTER_MAGIC \
--protocol-params-file $PROTOCOL_JSON_FILE

