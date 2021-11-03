	.globl main 

	.text 		

main:
	addi $s0, $zero, 10	#s0 A=10;
	addi $s1, $zero, 15	#s1 B=15;
	addi $s2, $zero, 6	#s2 C=6;
	addi $s3, $zero, 0	#s3 Z=0;
	
	bgt $s0, $s1, path1     # if(A > B ||
	blt $s2, 5, path1       #C < 5)
	bgt $s0, $s1, path2     #else if((A > B)
path3:  addi $s3, $zero, 3      #else z = 3
	j part2
	
	

path1: addi $s3, $zero, 1       #Z = 1
	j part2
path2:  addi $t0, $s2, 1        #t0 = C+1 
	beq $t0 , 7 , path22   #&& ((C+1) == 7))
	j path3
path22: addi $s3, $zero, 2      #Z = 2

part2:  beq $s3, 1, case1       #switch case 1
	beq $s3, 2, case2	#switch case 2
	addi $s3, $zero, 0	#default Z = 0
	j end
case1:  addi $s3, $zero, -1	#Z = -1
	j end
case2:  addi $s3, $zero, -2	#Z = -2
end:    sw $s3, Z		#write Z to our text integer Z
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

	.data

	
Z:	.word 0
