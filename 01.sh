#!/bin/bash

echo Ejercicio 01, numeros divisibles de 3, 5 y 7.
echo si el numero ingresado es divisible por 3 mostrara la leyenda Pling.
echo si el numero ingresado es divisible por 5 mostrara la leyenda Plong.
echo si el numero ingresado es divisible por 7 mostrara la leyenda Plang.
echo de lo contrario mostrara el numero ingresado.
echo Escriba un numero

read numero


if ! [[ $numero =~ ^[0-9]+$ ]]; 
then
echo El dato ingresado no es un numero
exit 1
fi

let divisibleXtres="$numero % 3"
let divisibleXcinco="$numero % 5"
let divisibleXsiete="$numero % 7"

if (($divisibleXtres == "0")); 
then
echo Pling
exit 1
fi

if (($divisibleXcinco == "0")); 
then
echo Plong
exit 1
fi

if (($divisibleXsiete == "0")); 
then
echo Plang
exit 1
fi

echo Mi numero ingresado es $numero
exit 1


