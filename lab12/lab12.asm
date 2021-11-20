# Simple game of connect 5 played on a 9x6 board with the outer 2 cols filled in
#game flips a coin to see who is first then turns alternate between player and computer
.globl main

.text

main:
    # Print string rand
	li	$v0,4		# print_string syscall code = 4
	la	$a0, rand	# load the address of msg
	syscall

    # get in random1
	li	$v0,5		# print_string syscall code = 4
	syscall
    sw $v0, m_w

    # Print string rand2
	li	$v0,4		# print_string syscall code = 4
	la	$a0, rand2	# load the address of msg
	syscall

    # get in random2
	li	$v0,5		# print_string syscall code = 4
	syscall
    sw $v0, m_z

    li $a0, 2
    jal getRand

    beq $v0, 0, compFirst
    #player first

    # Print string won coin toss
	li	$v0,4		# print_string syscall code = 4
	la	$a0, coinHW	# load the address of msg
	syscall

    #take player turn
    jal playerturn

    j mainLoop

    compFirst:
        # Print string lost coin toss
        li	$v0,4		# print_string syscall code = 4
        la	$a0, coinCW	# load the address of msg
        syscall

    mainLoop:
        li $s0, 0       #s0 = gameOver flag
        beq $s0, 1, exit
        jal printboard
        jal playerturn
        j mainLoop



    
    j exit

playerturn:
    li $t0, 0
    inputloop: bgt $t0, 0, inputEnd

    # Print string wasking for input
	li	$v0,4		# print_string syscall code = 4
	la	$a0, turnQ	# load the address of msg
	syscall

    #read in input
	li	$v0,5		# print_string syscall code = 4
	syscall
    
    #check input
    bgt $v0, 9, inputloop
    blt $v0, 0, inputloop

    #if input is within range check to see if move is valid

    move $a0, $v0

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $a1, 72

    jal checkmove

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    move $t0, $v0
    j inputloop
inputEnd:
    jr $ra

#checks if move is valid, if so returns the index of the move, if not returns 0
#takes in one argument for the col selected
checkmove:
    li $v0, 0                       #default return value is 0
    li $t5, 5                       #counter variable, represents each row to be checked
    checkmoveloop:   
        beq $t5, -1, returnmove     #loop runs from 5 to 0, returns if free space is found
        mul $t6, $t5, 9
        add $t6, $t6, $a0           #loading i*9 + move for index of possible moves
        la $t7, board
        add $t7, $t7, $t6           #get address of posible move
        lb $t8, 0($t7)              #load value of possible move 
        beq $t8, 46, exitFound      #check to see of space is free
        #if not free try next row
        addi $t5, $t5, -1            #i--
        j checkmoveloop

    exitFound:
        sb $a1, 0($t7)              #updateboard
        move $v0, $t6               #return index of move taken



    returnmove:
        jr $ra

#prints board
#uses $t0-$t2
#takes no arguments, returns nothing
printboard:
    li $t0, 0                   #t0 = index
    la $t1, board               #load up board address
    # Print boardHeader
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, boardHeader	    # load the address of msg
	syscall

    # Print boardTop
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, boardTop	        # load the address of msg
	syscall



printloop:
    beq $t0, 53, exitprint       #goes from 0 to 53 to print entire board

    # Print board[i]
	li	$v0,11		            # print char syscall code = 11
	lb	$a0, 0($t1)	            # load the address of msg
	syscall

    # Print space
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, space	            # load the address of msg
	syscall
    
    li $t2, 9
    div $t0, $t2                  # i % 9
    mfhi $t2
    beq $t2, 8, printnl
printloop2:
    addi $t0, $t0, 1            #index++
    addi $t1, $t1, 1            #board[index]
    j printloop
printnl:
    # Print boardSide
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, boardSide	            # load the address of msg
	syscall
    j printloop2
exitprint:
    # Print board[i]
	li	$v0,11		            # print char syscall code = 11
	lb	$a0, 0($t1)	            # load the address of msg
	syscall

    # Print space
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, space	            # load the address of msg
	syscall

    # Print boardBottom
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, boardBottom	    # load the address of msg
	syscall
    jr $ra


#Function for flipping a coin, returns 0 or 1 based on result
#takes one argument for the modulus range, returns 1 value stored in v0
#uses registers: t0, t1, t2, t3, t4, t5
#t5 = result
#changes stored values of m_w and m_z
getRand:   
        lw $t0, m_z              #load in seed for rand gen
        lw $t1, m_z              #load in seed for rand gen
        lw $t2, m_w              #load in seed for rand gen
        lw $t3, m_w              #load in seed for rand gen
        li $t5, 0                #result = 0
        
        li $t4, 65535
        and $t0, $t0, $t4         #(m_z & 65535)
        srl $t1, $t1, 16          #(m_z >> 16)

        li $t4, 36969             #load 36969 for multiplication

        mul  $t0, $t0, $t4        #36969 * (m_z & 65535)
        addu  $t0, $t0, $t1       #36969 * (m_z & 65535) + (m_z >> 16)

        andi $t2, $t2, 65535      #(m_w & 65535)
        srl $t3, $t3, 16          #(m_w >> 16)

        li $t4, 18000             #load 18000 for multiplication

        mul  $t2, $t2, $t4        #18000 * (m_z & 65535)
        addu  $t2, $t2, $t3       #18000 * (m_z & 65535) + (m_z >> 16)

        sw   $t0, m_z            #save new value for m_z
        sw   $t2, m_w             #save new value for m_w

        sll $t0, $t0, 16          #(m_z << 16)
        addu $t5, $t0, $t2        #result = (m_z << 16) + m_w in v0
        li $t4, 2
        divu $t5, $t4             #result % a0
        mfhi $t5
        move $v0, $t5             #load result
        jr $ra                    #return

exit:
    li $v0, 10              # Sets $v0 to "10" to select exit syscall
	syscall                 # Exit

.data
    board: .asciiz "C.......CH.......HC.......CH.......HC.......CH.......H"
    rand: .asciiz "\n Please enter first random number 0-500000: "
    rand2: .asciiz "\n Please enter second random number 0-500000: "
    coinHW: .asciiz "\n You Won the coin toss!\n"
    coinCW: .asciiz "\n You lost the coin toss!\n"
    turnQ: .asciiz "\n Enter your move: "
    turnC: .asciiz "\n Computer move: "
    winC: .asciiz "\n Computer Won"
    winH: .asciiz "\n Human Won"
    boardHeader: .asciiz "   1 2 3 4 5 6 7  \n"
    boardTop: .asciiz " _________________ \n|"
    boardSide: .asciiz "|\n|"
    boardBottom: .asciiz "|\n ------------------\n"
    space: .asciiz " "
    m_w: .word 50000                 #starting 32 bit int for random gen
    m_z: .word 60000                  #starting 32 bit int for random gen 
    




