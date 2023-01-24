#! /usr/bin/bash

FL="/etc/vim/vimrc"

#check os
OS=`grep ID /etc/os-release -m 1 | cut -d "=" -f2 | tr -d '"'`
if [ "$OS" = "rhel" ]
then
	FL="/etc/vimrc"
fi

#check if relative number is set
CH=`grep relativenumber ${FL}`
if [[ -z $CH ]]
then
	echo -e "set relativenumber" | sudo tee -a ${FL}
fi


#create ~/.vim folder if it doesn't exist
DIR="${HOME}/.vim"
if [[ ! -d $DIR ]]
then
	mkdir $DIR
fi

#colorscheme
#check if ~/.vim/colors exists
C_DIR="${DIR}/colors"
if [[ ! -d $C_DIR ]]
then
	mkdir $C_DIR
fi

#monokai
curl -Lo $C_DIR/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

#onedark
curl -Lo $C_DIR/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/main/colors/onedark.vim
curl -Lo "${DIR}/autoload/onedark.vim" https://raw.githubusercontent.com/joshdick/onedark.vim/main/autoload/onedark.vim

#set default colorscheme
CLR="onedark"
#CH1=`grep "colorscheme ${CLR}" /etc/vim/vimrc`

echo "colorscheme ${CLR}" | sudo tee -a ${FL}

#Plugins
P_DIR="${DIR}/pack/plugins/start"

#vim-airline
P_DIR_1="${P_DIR}/vim-airline/"
if [[ ! -d $P_DIR_1 ]]
then
	git clone https://github.com/vim-airline/vim-airline.git $P_DIR_1
fi

#fugitive
P_DIR_2="${P_DIR}/fugitive"
if [[ ! -d $P_DIR_1 ]]
then
	git clone https://github.com/tpope/vim-fugitive.git $P_DIR_2
fi






