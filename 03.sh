#!/bin/bash

shortName=""
longName=""

echo El algoritmo buscara automaticamente al usuario con string mas corto y mas largo y lo mostrara por consola.

for name in $(cut -d':' -f1 /etc/passwd)
	do
		#al ser la primera vez que ingresa el lenght es 0 y asigna el primer usuario a ambas variables
	if ((${#shortName} == "0")) && ((${#longName} == "0")); 
		then
			shortName=$name
			longName=$name
		fi
	if((${#name} < ${#shortName}))
		then
			shortName=$name
		fi
	if((${#name} > ${#shortName}))
		then
			longName=$name
		fi
done

echo Usuario con nombre menor $shortName
echo Usuario con nombre mayor $longName





