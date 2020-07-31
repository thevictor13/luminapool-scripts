#if [ $# -eq 0 ]
#  then
#    echo "Please provide a Cardano Cluster (environment) to run the relay on"
#    exit;
#fi

cd $LP_HOME

CLUSTER=${1:-$LP_CLUSTER}

cardano-node run \
   --topology $LP_STORAGE/$CLUSTER/config/$CLUSTER-topology.json \
   --database-path $LP_STORAGE/$CLUSTER/db \
   --socket-path $LP_STORAGE/$CLUSTER/db/node.socket \
   --host-addr $($LP_SCRIPTS/scripts/get-public-ip.sh) \
   --port $LP_PORT \
   --config $LP_STORAGE/$CLUSTER/config/$CLUSTER-config.json
