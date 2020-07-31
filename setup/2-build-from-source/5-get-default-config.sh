#if [ $# -eq 0 ]
#  then
#    echo "Please provide a Cardano Cluster (environment) to fetch config for"
#    exit;
#fi

CLUSTER=${1:-$LP_CLUSTER}

cd $LP_STORAGE

mkdir -p $CLUSTER/config
cd $CLUSTER/config

wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CLUSTER-config.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CLUSTER-byron-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CLUSTER-shelley-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CLUSTER-topology.json

