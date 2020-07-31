if [ $# -eq 0 ]
  then
    echo "Please provide a tag (version number) to checkout cardano-node"
    exit;
fi

cd $LP_HOME

cd cardano-node
git checkout tags/$1
