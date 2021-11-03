	.globl main 

	.text 		

main:
	addi $s0, $zero, 2 # s0 = Z = 2
	addi $t0, $zero, 0 # t0 = int i = 0
while1: bgt $t0, 20, part2 #while loop start, check if (1 > 20)
	addi $s0, $s0, 1   #z++
	addi $t0, $t0, 2   #i+=2
	j while1
part2:  bgt $s0, 100, part3 # while(z <100)
	addi $s0, $s0, 1   #z++
	j part2
	
part3:  blt $t0, 0, end # while( i > 0)
	addi $s0, $s0, -1  #z--
	addi $t0, $t0, -1  #i--
	j part3
	
end:    sw $s0, Z		#write Z to our text integer Z
	sw $t0, I		#write I to our text integer I
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit



	.data

	
Z:	.word 0
I:      .word 0
