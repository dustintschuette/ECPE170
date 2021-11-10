# Start .text segment (program code)
	.text
	
	.globl	main
main:
	# Print string msg1
	li	$v0,4		# print_string syscall code = 4
	la	$a0, msg1	# load the address of msg
	syscall

	# Get input String from user and save
	
	addi $s1, $zero, 255	#size of buffer
	la $s0, buffer
	li	$v0, 8		# read_string syscall code = 8
	la	$a0, buffer	#pass the buffer base
	add	$a1, $zero, $s1	#pass the buffer size as an argument
	syscall	
	lb $t0, 0($s0)		#t0 is the first char in the string
	
	
while: beq $t0, $zero, notfound	#main loop while a null char is not found
	beq $t0, 101, found	#found an 'e'
	addi $t0, $t0, 1	#go to next char 
	addi $s0, $s0, 1	#load next char
	lb $t0, 0($s0)		#t0 = next char
	j while			#continue the loop				

notfound:
	# Print string msg2
	li	$v0, 4
	la	$a0, msg2
	syscall
	j exit
	
found: 
	# Print string msg3
	li	$v0, 4
	la	$a0, msg3
	syscall
	
	# Print Address
	li	$v0,1		# print_int syscall code = 1
	move	$a0, $s0	# int to print must be loaded into $a0
	syscall

	# Print \n
	li	$v0,4		# print_string syscall code = 4
	la	$a0, newline
	syscall
	
	sw $s0, result

exit:	li	$v0,10		# exit
	syscall

	# Start .data segment (data!)
	.data
buffer: .space 256
msg1:	.asciiz	"Enter a String:   "
msg2:   .asciiz "No e Found"
msg3:	.asciiz	"e found at memory Address:  "
result: .word 0
newline:   .asciiz	"\n"
