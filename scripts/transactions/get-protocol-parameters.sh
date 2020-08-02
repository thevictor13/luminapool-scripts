OUT_FILE=${1:-protocol.json}

if [ -s "$OUT_FILE" ]
then
   echo "$OUT_FILE already exists! Please specify another target or delete the old one explicitly."
   exit 1;
fi

cardano-cli shelley query protocol-parameters \
  --$LP_CLUSTER_MAGIC \
  --out-file $OUT_FILE
