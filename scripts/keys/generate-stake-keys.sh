VKEY_FILE=${1:-stake.vkey}
SKEY_FILE=${2:-stake.skey}

if [ -s "$VKEY_FILE" ]
then
   echo "$VKEY_FILE already exists! Please specify another target or delete the old one explicitly."
   exit;
fi

if [ -s "$SKEY_FILE" ]
then
   echo "$SKEY_FILE already exists! Please specify another target or delete the old one explicitly."
   exit;
fi


cardano-cli shelley stake-address key-gen \
--verification-key-file $VKEY_FILE \
--signing-key-file $SKEY_FILE
