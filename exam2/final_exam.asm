

.globl main

.text

main:

    #s0 = search key
    #s1 = size of the array
    #s2 = index return value 

    li $s0, 7
    li $s1, 5
    la $a2, array

    

    #indexes start at 0 so 1 less
    addi $s1, $s1, -1


    addi $a2, $a2, 16


    #push key to the stack so we can print it later
    addi $sp, $sp, -4
    sw $s0, 0($sp)

    #load values for function call
    move $a0, $s0
    move $a1, $s1

    jal search

    #pop search key from stack for printing
    lw $s0, 0($sp)
    addi $sp, $sp, 4

    #save index of results
    move $s2, $v0

    bne $v0, -1, printfound

    printnotFound:

        # Print string msg1
        li	$v0,4		            # print_string syscall code = 4
        la	$a0, msg1	            # load the address of msg
        syscall

        j exit

    printfound:    

        # Print string msg2
        li	$v0,4		            # print_string syscall code = 4
        la	$a0, msg2	            # load the address of msg
        syscall
        
        #print searchKey
        li	$v0,1		            # print int syscall code = 1
        move $a0, $s0               #move search key into a0
        syscall

        # Print string msg3
        li	$v0,4		            # print_string syscall code = 4
        la	$a0, msg3	            # load the address of msg
        syscall

        #print indexValue
        li	$v0,1		            # print int syscall code = 1
        move $a0, $s2               #move index into a0
        syscall

        # Print string msg4
        li	$v0,4		            # print_string syscall code = 4
        la	$a0, msg4	            # load the address of msg
        syscall

        j exit


#takes three arguments the search key, the current index to be searched, and the address to be compared recursively searchs array name "Array"
#returns index if value found, if not found returns -1
search:
        beq $a1, -1, returnNotFound
        
        #load value of array at the index to be checked versus search key
        lw $t0, 0($a2)
        beq $t0, $a0, returnFound

        #not this index, load values for next check

        
        addi $a1, $a1, -1
        addi $a2, $a2, -4

        #push return address to stack
        addi $sp, $sp, -4
        sw $ra, 0($sp)

        jal search

        #pop ra from stack
        lw $ra, 0($sp)
        addi $sp, $sp, 4

        jr $ra


    returnFound:
        move $v0, $a1
        jr $ra

    returnNotFound:
    #end of array reached with value not found, return -1
        li $v0, -1
        jr $ra

exit:
    li $v0, 10              # Sets $v0 to "10" to select exit syscall
	syscall  


.data
    msg1: .asciiz "Search key not found \n"
    msg2: .asciiz "Element "
    msg3: .asciiz " found at array index " 
    msg4: .asciiz "\n"
    array: .word 2, 3, 5, 7, 11