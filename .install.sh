#! /bin/sh


echo "##############################"
echo "# File copy                  #"
echo "##############################"

ln -sir ./vimrc ~/.vimrc
ln -sir ./zshrc ~/.zshrc
ln -sir ./xinitrc ~/.xinitrc
ln -sir ./Xdefaults ~/.Xdefaults

echo "##############################"
echo "# Extra downloads            #"
echo "##############################"

echo "## config vim ..."
mkdir ~/.vim/bundle
cd ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

echo ""
echo "## config oh-my-zsh ..."
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
chsh -s /bin/zsh


