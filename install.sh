#!/bin/bash


user=$(whoami)
file=user_starship.toml


function copiaFile(){
	echo "Copying into..."
	echo "~/.config"
	cp $file $HOME/.config/starship.toml
}

function compDir(){
	if [ -d ~/.config ] 
		then 
			copiaFile 
		else 
			echo "The destination directory ~/.config does not exist."
			echo "Do you want to create it and copy the configuration to it? (y/n)"
			read resp
			if [ $resp == 'y']
			then
				echo "Creating directory..."
				mkdir ~/.config
				copiaFile
			else
				echo "Exiting."
				exit 0
			fi
		fi
}


echo "Configuration file install."
echo ""
if [ "$EUID" -ne 0 ]
then
	echo "To install as root, use elevated privileges: e.g. [sudo -s]"
	echo "Installing configuration file for user: " $user
	echo ""
	compDir
	exit 0
else
	file=root_starship.toml
	compDir
fi
