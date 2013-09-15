#! /bin/bash

# git pull origin master

echo "##############################"
echo "# File copy                  #"
echo "##############################"
echo ""
echo "Copy files into home directory"

for file in `ls -a -I .git -I . -I .. -I README.rst -I bootstrap.sh`; do
    ln -sir $file ~/$file
done

echo "##############################"
echo "# Extra configs              #"
echo "##############################"
echo ""

echo "## config vim ..."

if [[ ! -x ~/.vim/bundle/neobundle.vim ]]; then
    mkdir ~/.vim/bundle
    cd ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    cd -
fi

echo "## config oh-my-zsh ..."

if [[ ! -x ~/.oh-my-zsh ]]; then
    cd ~
    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    chsh -s /bin/zsh
    cd -
fi

