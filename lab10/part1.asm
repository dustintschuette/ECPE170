
	.globl main 

	.text 		


#goal is to compute Z = (A+B) + (C-D) + (E+F) - (A-C)
main:
	addi $s0, $zero, 15    #s0 = A = 15
	addi $s1, $zero, 10    #s1 = B = 10
	addi $s2, $zero, 7     #s2 = C = 7
	addi $s3, $zero, 2     #s3 = D = 2
	addi $s4, $zero, 18    #s4 = E = 18
	addi $s5, $zero, -3    #s5 = F = -3
	addi $s6, $zero, 0     #s6 = Z = 0
	add $t0, $s0, $s1      #t0 = A+B
	sub $t1, $s2, $s3      #t1 = C-D
	add $t2, $s4, $s5      #t2 = E+F
	sub $t3, $s0, $s2      #t3 = A-C
	add $t4, $t0, $t1      #t4 = (A+B) + (C-D)
	sub $t5, $t2, $t3      #t5 = (E+F) - (A-C)
	add $s6, $t4 ,$t5      #Z = (A+B) + (C-D) + (E+F) - (A-C)
	sw $s6, Z
	

	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit

	.data

	
Z:	.word 0
