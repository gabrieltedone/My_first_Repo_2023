#!/bin/bash
#Este script calcula la media de longitud de secuencias de un archivo .fastq y proporciona las longitudes minimas y maximas de las secuencias
#Este script se guarda y ejecuta desde /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/code
#El archivo .fastq tiene que estar en el directorio /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/raw/X.fastq

#selecciona la longitud de secuencia de cada lectura del archivo .fastq y redirige los valores al archivo read_lengths.txt
sed -n '1~4p' /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/raw/SRR1984406_1.fastq | cut -d '=' -f 2 > /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/processed/read_lengths.txt 

#se establecen las variables
valores=$(cat /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/processed/read_lengths.txt) #la variable toma los valores del archivo read_lengths.txt
num_de_secuencias=$(grep "@SRR19" /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/raw/SRR1984406_1.fastq | wc -l) #calcula el numero de lecturas del archivo .fastq
suma=0
media=0
minlength=0
maxlength=0

#bucle iterativo para sumar los valores de longitud a la variable suma
for i in $valores
do
	suma=$((suma+i))
done

#calculo de la media
media=$(echo $suma/$num_de_secuencias | bc -l) 	# redirigiendo la operacion aritmetica al comando 'bc -l' se consigue el valor decimal de la division

echo "Respuestas a la pregunta 2:"
echo "La suma de los valores de longitud de sequencia es $suma 
El numero de secuencias es $num_de_secuencias
La media de longitud de las secuencias es $media"

#ordenacion del archivo read_lenghts.txt y busqueda de max y min
minlength=$(sort -n /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/processed/read_lengths.txt | head -n1)
maxlength=$(sort -n /home/gabriel.tedone/Documentos/Tedone_eDNAread_2023_Nature/data/processed/read_lengths.txt | tail -n1)

echo " "
echo "Respuestas a la pregunta 3:"
echo "La longitud minima de las secuencias es $minlength"
echo "La longitud maxima de secuencia es $maxlength"
