
.text

main:
    # Print string input
	li	$v0,4		# print_string syscall code = 4
	la	$a0, input	# load the address of input
	syscall

    # get in input
	li	$v0,5		# read int syscall code = 5
	syscall

    #move input to a0
    move $a0, $v0

    jal sum

    #store result in s0

    move $s0, $v0

    # Print string input
	li	$v0,4		# print_string syscall code = 4
	la	$a0, result	# load the address of result
	syscall

    #print result
	li	    $v0,1		        # print_int syscall code = 1
	move	$a0, $s0	        # int to print must be loaded into $a0
	syscall

    j exit

#takes in one argument in a0
#if a0 != 0 then this function calls itself on a0 -1
#returns a0 + (a0 -1)
sum:
    beq $a0, $zero, sumReturn

    #push ra to stack
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    #push a0 to the stack
    addi $sp, $sp, -4
    sw $a0, 0($sp)

    addi $a0, $a0, -1
    jal sum

    #pop a0 from the stack
    lw $t0, 0($sp)
    addi $sp, $sp, 4

    #pop ra from the stack
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    #add t0 and v0
    add $v0, $v0, $t0

    #return
    jr $ra


sumReturn:
    move $v0, $a0
    jr $ra

exit:
    li $v0, 10              # Sets $v0 to "10" to select exit syscall
	syscall                 # Exit
.data
newline: .asciiz "\n"
input: .asciiz "\n Please enter a positive integer: "
result: .asciiz "\n sum is: "