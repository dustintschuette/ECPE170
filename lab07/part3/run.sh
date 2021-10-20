#!/bin/bash

declare -a testSizes=( 256 512 768 1024 1280 1536 1792 2048);
declare -a ARR
declare result=1
declare result2=1
declare toparse=''
declare counter=0
echo Algorithim, 1, 2 > output.txt
for((i = 0; i< 8; i++))
do
	
	#run program for algorithim one
	toparse=$(./matrix_math 1 ${testSizes[i]} )
	
	#parse output
		
	if [[ $toparse =~ ([[:space:]]*)([[:digit:]]+)(\.)([[:digit:]]+)([A-Z])(\+)([[:digit:]]+) ]] 
		then
		result="${BASH_REMATCH}"
		#echo Algorithim 1: for ${testSizes[i]} is:  >> output.txt
		fi
	
	 toparse=$(./matrix_math 2 ${testSizes[i]} ) 
	 if [[ $toparse =~ ([[:space:]]*)([[:digit:]]+)(\.)([[:digit:]]+)([A-Z])(\+)([[:digit:]]+) ]]; 			then
	 	result2="${BASH_REMATCH}"
		#echo A lgorithim 2: for ${testSizes[i]} is:  >> output.txt
		echo ${testSizes[i]}, ${result}, ${result2} >> output.txt
		fi
	 
done	
	

