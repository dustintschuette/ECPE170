.text
.globl main

main:
	la $s0 , A             #s0 = base address of A
	la $s6, B              #s6 = base address of B
	addi $t0, $zero, 1     # load value for B[0]
	sw $t0, 0($s6)	       # B[0] = 1
	addi $t0, $zero, 2     #load value for B[1]
	sw $t0, 4($s6)         #B[1] = 2
	addi $t0, $zero, 3     #load value for B[2]
	sw $t0, 8($s6)	       #B[2] = 3
	addi $t0, $zero, 4     #load value for B[3]
	sw $t0, 12($s6)         #B[3] = 4
	addi $t0, $zero, 5     #load value for B[4]
	sw $t0, 16($s6)	       #B[4] = 5
	addi $t0, $zero, 0     # int i = 0
	
	addi $s2, $zero, 12    # C = 12
for:	bgt $t0, 4, part2      #if i > 4 exit the loop
	add $t1, $t0, $t0      #t1 = 2i
	add $t1, $t1, $t1      #t1 = 4i 
	add $s7, $t1, $s6      #(arrayB + i)
	lw $s7, 0($s7)	       #*(arrayB + i)
	add $s7, $s7, $s2      #*(arrayB+i) + C
	add $t2, $s0, $t1      #(arrayA +i)
	sw $s7, 0($t2)         #A[i] = B[i] + C
	addi $t0, $t0, 1       #i++
	j for
	
part2:	addi $t0, $t0, -1      #i--
while: blt $t0, 0, endmain
	add $t1, $t0, $t0      #t1 = 2i
	add $t1, $t1, $t1      #t1 = 4i
	add $t2, $s0, $t1      # (arrayA + i)
	lw  $t3, 0($t2)        # *(arrayA + i)
	add $t3, $t3, $t3      #t3 = 2 * A[i]
	sw $t3, 0($t2)	       #A[i] = A[i] * 2
	addi $t0, $t0, -1      #i--
	j while
	
	
endmain:
	li $v0, 10
	syscall
	
.data
A: .space 20
B: .space 20
