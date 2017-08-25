#!/bin/bash

echo Algoritmo que analiza los archivos de una ubicacion, y dependiendo el usuario analiza cuales archivos no puede editar
direct="/home/maximiliano/Scripts/Ejercicios/EjemploEjercicio4"
COUNT=0
USERINSERT="maximiliano"

echo Usuario: $USERINSERT

for FILE in $(ls $direct)
do

	direction="$direct/$FILE"
	#separo por espacios en un array las informacion extra obtenida del archivo
	IFS=' ' read -r -a fullFile <<< $(ls -l $direction)
	permision=${fullFile[0]} #lista de permisos 
	userPropert=${fullFile[2]} # propietario del archivo
	isFile=${permision:0:1} # es un arhivo o directorio? (-:archivo, d:directorio)
	writeFilePropert=${permision:2:1} # la propiedad de escritura para el propietario del archivo (-:sin permisos, w:con permisos)
	writeFileGroup=${permision:5:1} # la propiedad de escritura para un grupo especifico (-:sin permisos, w:con permisos)
	writeFileOther=${permision:8:1} # la propiedad de escritura para otros usuarios (-:sin permisos, w:con permisos)

	if [ $isFile != "d" ]; then
		# si no tengo permiso y soy el propietario
		if [ $writeFilePropert != "w" ] && [ $USERINSERT == $userPropert ];	then
			COUNT=$(( $COUNT + 1 ))
			echo Archivo: $FILE, Propietario: $userPropert, Permisos: $permision
		else
			# si no tengo permiso y no soy el propietario
			if [ $writeFileGroup != "w" ] || [ $writeFileGroup != "w" ]; then
			COUNT=$(( $COUNT + 1 ))
			echo Archivo: $FILE, Propietario: $userPropert, Permisos: $permision
			fi
		fi
	fi
done

echo cantidad de achivos que no se pueden editar con el usuario $USERINSERT: $COUNT 
