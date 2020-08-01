if [ $# -eq 0 ]
  then
    echo "Please provide the tag (version number) used to checkout cardano-node"
    exit;
fi

cd $LP_HOME

cd cardano-node
cabal update
cabal build all

cp -p dist-newstyle/build/x86_64-linux/ghc-8.6.5/cardano-node-$1/x/cardano-node/build/cardano-node/cardano-node $LP_HOME/.local/bin/

cp -p dist-newstyle/build/x86_64-linux/ghc-8.6.5/cardano-cli-$1/x/cardano-cli/build/cardano-cli/cardano-cli $LP_HOME/.local/bin/

