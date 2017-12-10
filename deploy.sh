#! /bin/sh

sudo apt install -y curl
sudo apt install -y build-essential cmake
sudo apt install -y python-dev python3-dev
sudo apt install -y clang
ln -s $PWD/.vimrc ~/.vimrc
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

echo 'Please change .tmux.conf.local by yourself'
