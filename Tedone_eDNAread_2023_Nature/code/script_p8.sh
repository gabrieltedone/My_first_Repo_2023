#!/bin/bash
#Este script se tiene que ejecutar desde /code y parsea las secuencias*.fasta en ../data/processed/
#Este script reporta por la salida estandar la secuencia de ADN del archivo .fasta, su secuencia reversa y complementaria de ARN con asociadas sus frecuencias de aparcicion de cada nucleotido (A, U, G, C) 
#Las secuencias estan reportadas en sentido 5' --> 3'

for file in ../data/processed/secuencia*.fasta
do
	seq=$(cat $file | tail -n1) 							#obtiene la secuencia
	revcomplRNA=$(echo $seq | tr "ATGC" "UACG" | rev)		#obtiene la cadena complementaria y reversa de ARN
	length=$(echo ${#revcomplRNA})							#obtiene la longitud de la secuencia
	
	Acount=$(echo $revcomplRNA | grep -Eo "A" | wc -l)		#cuenta el numero de nucleotidos A en la secuencia de ARN
	freqA=$(echo "100*($Acount/$length)"| bc -l)			#calcula su porcentaje sobre la longitud de la secuencia
	Ucount=$(echo $revcomplRNA | grep -Eo "U" | wc -l)		#idem para "U"
	freqU=$(echo "100*($Ucount/$length)" | bc -l)	
	Gcount=$(echo $revcomplRNA | grep -Eo "G" | wc -l)		#idem para "G"
	freqG=$(echo "100*($Gcount/$length)" | bc -l)	
	Ccount=$(echo $revcomplRNA | grep -Eo "C" | wc -l)		#idem para "C"
	freqC=$(echo "100*($Ccount/$length)" | bc -l)
	
	echo "---------------------"	
	echo -e "De la secuencia de ADN en $file : \n5' $seq 3'"	
	echo -e "Su secuencia reversa y complementaria de ARN es: \n5' $revcomplRNA 3'"
	echo "Donde las frecuencias de aparicion de los nucleotidos son:"
	echo "$freqA" | awk '{printf("%.2f",$1)}' ; echo "% A" #con awk '{printf("%.2f",$1)}' se redondea a 2 decimales el porcentaje
	echo "$freqU" | awk '{printf("%.2f",$1)}' ; echo "% U"
	echo "$freqG" | awk '{printf("%.2f",$1)}' ; echo "% G"
	echo "$freqC" | awk '{printf("%.2f",$1)}' ; echo "% C"
done
