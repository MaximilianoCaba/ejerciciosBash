#!/bin/bash

echo Ingrese un parrafo de texto

texto="hola como estas hola estas hola es como"

echo texto ingresado: $texto


echo cantidad de palabras: 

# muestra la cantidad de palabras que tiene el string
wc -w <<< $texto

echo $lenght
# uniq -c quita linas repetidas
# sort ordena el string
# tr hace un salto de linea para la salida de texto

echo $texto | tr ' ' '\n' | sort | uniq -c