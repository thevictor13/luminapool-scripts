mkdir -p $LP_HOME/install
cd $LP_HOME/install

sudo apt-get update -y
sudo apt-get install build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libtool autoconf -y

