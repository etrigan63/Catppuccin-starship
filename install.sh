#!/bin/bash


user=$(whoami)
file=user_starship.toml


function copiaFile(){
	echo "Copiando en..."
	echo "~/.config"
	cp $file $HOME/.config/starship.toml
}

function compDir(){
	if [ -d ~/.config ] 
		then 
			copiaFile 
		else 
			echo "No existe el directorio destino ~/.config"
			echo "Deseas crearlo y copiar el fichero en él? (s/n)"
			read resp
			if [ $resp == 's']
			then
				echo "Creando directorio..."
				mkdir ~/.config
				copiaFile
			else
				echo "Saliendo."
				exit 0
			fi
		fi
}


echo "Instalación del fichero de configuración."
echo ""
if [ "$EUID" -ne 0 ]
then
	echo "Para instalarlo en el usuario root, eleva privilegios: p.ej. [sudo -s]"
	echo "Instalando el fichero de configuración para el usuario: " $user
	echo ""
	compDir
	exit 0
else
	file=root_starship.toml
	compDir
fi
