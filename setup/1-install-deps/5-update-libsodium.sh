cd $LP_HOME

git clone https://github.com/input-output-hk/libsodium

cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install
