.globl main

.text


#main's function is to genrate 2 random numbers and print them out,
#then find their gcd using euclidian's algorithm
#main will then print the resulting value
#this is repeated a total number of 10 times
#s0 = i
#s1 = n1
#s2 = n2
#s3 = gcd (n1, n2)

main:
    addi $s0, $zero, 0          # i = 0
    addi $s1, $zero, 0          # n1 = 0
    addi $s2, $zero, 0          # n2 = 0

mainLoop:
    beq $s0 10 exit             #if i == 10 exit

    addi $a0 $zero 1            #load min for randInRang
    addi $a1 $zero 10000        #load max for randInRang
    jal randInRange             #get val for n1
    add $s1 $zero $v0           #load n1 with random number

    addi $a0 $zero 1            #load min for randInRang
    addi $a1 $zero 10000        #load max for randInRang
    jal randInRange             #get val for n2
    add $s2 $zero $v0           #load n2 with random number



    # Print string msg1
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, msg1	            # load the address of msg
	syscall

    # Print n1
	li	    $v0,1		        # print_int syscall code = 1
	move	$a0, $s1	        # int to print must be loaded into $a0
	syscall

    # Print string msg2
	li	$v0,4		            #print_string syscall code = 4
	la	$a0, msg2	            # load the address of msg
	syscall

    # Print n2
	li	    $v0,1		        # print_int syscall code = 1
	move	$a0, $s2	        # int to print must be loaded into $a0
	syscall

    # Print string msg3
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, msg3	            # load the address of msg
	syscall

    add $a0, $zero, $s1           #load n1 for gcd
    add $a1, $zero, $s2           #load n2 for gcd

    jal gcd                     #gcd(n1, n2)

    add $s3, $zero, $v0           #load in result

    # Print gcd
	li	$v0,1		            # print_int syscall code = 1
	move	$a0, $s3	        # int to print must be loaded into $a0
	syscall

    # Print string msg4
	li	$v0,4		            # print_string syscall code = 4
	la	$a0, msg4	            # load the address of msg
	syscall

    addi $s0, $s0, 1              #i++

    j mainLoop                  #jump back to condition check
#Function for generating random numbers
#takes no arguments, returns 1 value stored in v0
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
        move $v0, $t5             #load result
        jr $ra                    #return
        
#Function's purpose to generate a random number in the range provided using the getRand function
#Recieves 2 arguments which represent the min and max of the range of the random number desired
#returns one random number
#Uses registers: t0, t1, t2
#t0 = min
#t1 = max / range

randInRange:
            add $t0, $zero, $a0    #get min to t0
            add $t1, $zero, $a1    #get max to t1  

            subu $t1, $t1, $t0      #(max - min)
            addi $t1, $t1, 1       # range = (max - min) + 1


            addi $sp ,$sp, -4       #move stack pointer down to store min
            sw $t0 ,0($sp)         #store min
            
            addi $sp, $sp, -4       #move stack pointer down to store return address
            sw $ra, 0($sp)         #store ra

            addi $sp, $sp, -4       #move stack pointer down to store range
            sw $t1, 0($sp)         #store range

            jal getRand            #get the random number needed

            lw $t1, 0($sp)         #load in range from the stack
            addi $sp, $sp, 4        #move up stack pointer

            divu $v0, $t1           #rand_num % range

            mfhi $t2               #load our new random number into t2

            

            lw $ra, 0($sp)         #load in return address from the stack
            addi $sp, $sp, 4        #move up stack pointer

            lw $t0, 0($sp)         #load in min from the stack
            addi $sp, $sp, 4        #move up stack pointer

            addu $v0, $t2, $t0       #load (rand_num % range) + min

            jr $ra                #final value loaded, return





#recursive function to find the gcd of two numbers
#function takes in two arguments 
#function returns one argument in v0
#uses registers t0, t1
gcd:
    addu $t0, $zero, $a0    #get n1 to t0
    addu $t1 ,$zero, $a1    #get n2 to t1

    beq $t1 ,$zero, gcdFound  #if(n2 == 0) gcd is found
            
    addi $sp ,$sp, -4      #move stack pointer down to store return address
    sw $ra, 0($sp)         #store ra

    divu $t0 $t1             # n1% n2
    
    mfhi $a1                #load n1 %n2 for next gcd call

    
    addu $a0, $zero, $t1     #load in n2 for gcd call

    jal gcd               # gcd(n2, n1%n2)

    #leave return value as is, it is the return value we need to return anyways
         

    lw $ra, 0($sp)         #load in return address from the stack
    addi $sp, $sp, 4       #move up stack pointer

    jr $ra                 #unwind stack, return to callee

gcdFound:
    addu $v0, $zero, $t0    #load n1 for return
    jr $ra                 #return to callee
exit:
    li $v0, 10              # Sets $v0 to "10" to select exit syscall
	syscall                 # Exit



.data
    m_w: .word 50000                 #starting 32 bit int for random gen
    m_z: .word 60000                  #starting 32 bit int for random gen 
    msg1: .asciiz "GCD of "
    msg2: .asciiz " and " 
    msg3: .asciiz " is: "
    msg4: .asciiz ". \n"