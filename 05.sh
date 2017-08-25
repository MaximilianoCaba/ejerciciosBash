#!/bin/bash
IFS=$'\n' # soluciona los problemas de salto de linea

installDependencies(){
	{
	# existe las dependencias SOX y LAME? la respuesta la guarda en una variable
  SOX_SEARCH_DEPENDENCY=$(dpkg -s sox 2>&1)
  LAME_SEARCH_DEPENDENCY=$(dpkg -s lame 2>&1)
} &> /dev/null

#si no existe la dependencia SOX la instala
if [[ $SOX_SEARCH_DEPENDENCY == *"dpkg-query:"* ]]; then
	echo instalando la dependencia sox, aguarde por favor...
  SOX_INSTALL=$(sudo apt-get install sox)
  echo dependencia sox instalada correctamente
fi

#si no existe la dependencia LAME la instala
if [[ $LAME_SEARCH_DEPENDENCY == *"dpkg-query:"* ]]; then
	echo instalando la dependencia lame, aguarde por favor...
  SOX_INSTALL=$(sudo apt-get install sox)
  echo dependencia lame instalada correctamente
fi
}

allDependenciesOK (){

	if [[ $SOX_SEARCH_DEPENDENCY == *"Status: install ok installed"* ]] && [[ $LAME_SEARCH_DEPENDENCY == *"Status: install ok installed"* ]]; then
	echo la dependencia sox and lame esta installada correctamente, ya se puede escuchar musica
	else
		echo hay un error al corroborar las dependencias sox y lame, por favor solucione el problema
		exit 1
fi
}

ifExistFolder(){
	if [ ! -d "$HOME/Music" ]; then
	{
  		cd $HOME
  		mkdir Music
	} &> /dev/null
	echo se creo una carpeta llamada Music en $HOME/Music, coloque sus temas en esa carpeta
	fi
}

principalMenu(){
	echo MENU PRINCIPAL
	cd "$HOME/Music"
	echo "1 ) reproducir un tema seleccionado"
	echo "2 ) reproducir Random"
	read tipeReproduction
	if [ $tipeReproduction == "1" ]; then
		reproducirUnTema
	else
			if [ $tipeReproduction == "2" ]; 
				then
				echo
				reproducirRandom
			else
				echo Comando invalido
				principalMenu
			fi
	fi 
}

reproducirUnTema(){
		COUNT=0
		arrayMusic=()
for file in *.wav
	do
		if [ $file == "*.wav" ]; 
		then
		echo 
		else
		COUNT=$(( $COUNT + 1 ))
    	echo $COUNT ")" $file
    	arrayMusic+=$file
		fi
	done

	if [ ${#arrayMusic[@]} -eq 0 ]; then
    echo No hay temas para reproducir, agregue nuevos temas en $HOME/Music
	else
	echo escriba numero del tema a reproducir o BACK para volver
	read idMusic
	isNumber='^[0-9]+$'
	
	if [[ $idMusic =~ $isNumber ]]; 
		then
		position="$idMusic - 1"
	echo
	echo "--> para finalizar de reproducir presione CTRL + C <--"
	play ${arrayMusic[position]}
	startReproductor
	else
		if [ $idMusic == "BACK" ];
			then
			principalMenu
			else
		echo el comando ingreaso no es valido
		reproducirUnTema
		fi
	fi	
fi
}

reproducirRandom(){
	echo este menu no esta desarrollado aun, espera a la version 2.0
	principalMenu
}



transformMusicToWav(){
	# transforma de mp3 a wav
	for file in *.mp3
	do
		{
  			lame --decode $file $file.wav 2>&1
  			rm $file
		} &> /dev/null
	done
}


# si estan instaladas las dependencias SOX y LAME procede con el programa
startReproductor(){

	#Si no existe la carpeta Music la crea
	ifExistFolder
	
	# transformo los temas a wav
	transformMusicToWav

	# ejecuto el menu principal
	principalMenu 

}

installDependencies

allDependenciesOK

startReproductor
