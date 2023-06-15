#!/bin/bash
#Importante que se ejecute el script desde el subdirectorio /code del proyecto!
#Este script parsea varios archivo mono-fasta y proporciona informacion sobre sus correspondientes secuencias

for file in ../data/processed/secuencia*.fasta
do 
	
	seq=($(cat $file | tail -n1)) #se asigna la secuencia a la variable 'seq' para parsear su cadena de nucleotidos
	length=$(echo ${#seq}) #calcula la longitud de la variable
	initial=$(echo ${seq:0:1}) #toma el valor del primer valor de la cadena
	final=$(echo ${seq:$length-1:1}) #toma el valor del ultimo valor de la cadena
	GCcount=$(cat $file | tail -n1 | grep -E -o "[GC]" | wc -l) #cuenta el numero de nucleotidos G o C
	GCcontent=$(echo "($GCcount/$length)*100" | bc -l) #calcula el GC%
	repeatingseq=$(echo $seq | grep -Eo "(A+|T+|G+|C+)" | awk '{print $0, length}' | sort -k 2 -n | tail -n1 | cut -d " " -f1) 
	#busca la secuencia de un unico nucleotidos repetido mas larga
	
	echo "-------------------------"
	echo "La secuencia $file tiene:"	
	echo "Una longitud de $length nucleotidos"
	echo "Su nucleotido inicial es $initial"
	echo "Su nucleotido final es $final"
	echo "El numero de nucleotidos G/C es $GCcount, lo que, sobre un total de $length nucleotidos, corresponde a  $GCcontent % de G/C"
	echo "La subsecuencia de un mismo caracter mas larga es $repeatingseq"
	echo 

done
