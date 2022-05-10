.data
	prompt_main: .asciiz "\nEnter operation number: "
	prompt_a: .asciiz "\nEnter first number: "
	prompt_b: .asciiz "Enter second number: "
	prompt_c: .asciiz "Enter third number: "
	end: .asciiz "\nDo you want to continue?: "
	result: .asciiz "\nOperation result: "
	wrong: .asciiz "\nWrong operation number!"
.text
	main:
	#first prompt
	li $v0, 4
	la $a0, prompt_main
	syscall
	
	#loading program number
	li $v0, 5
	syscall
	move $s7, $v0
	#loading variables
	li $t0, 1
	li $t1, 2
	li $t2, 3
	
	load:
	#a prompt
	li $v0, 4
	la $a0, prompt_a
	syscall
	#loading a number
	li $v0, 5
	syscall
	move $s0, $v0
	#b prompt
	li $v0, 4
	la $a0, prompt_b
	syscall
	#loading b number
	li $v0, 5
	syscall
	move $s1, $v0
	#c prompt
	li $v0, 4
	la $a0, prompt_c
	syscall
	#loading c number
	li $v0, 5
	syscall
	move $s2, $v0

	#conditional jumps
	#if_one:
	beq $s7, $t0, one
	#if_two:
	beq $s7, $t1, two
	#if_three:
	beq $s7, $t2, three
	#if_different:
	bgt $s7, $t2, default
	beqz $s7, default
	
	results:
	#result prompt
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	la $a0, ($t7)
	syscall
	cont:
	#end prompt
	li $v0, 4
	la $a0, end
	syscall
	#loading end number
	li $v0, 5
	syscall
	bgtz $v0, main
	
	
	#program is finished running
	li $v0, 10
	syscall
	
	
	
	
	one:
	add $t7, $s0, $s1
	mul $t7, $t7, $s2
	j results
	
	two:
	sub $t7, $s0, $s1
	div $t7, $t7, $s2
	j results

	three:
	sub $t7, $s0, $s1
	add $t7, $t7, $s2
	j results
	
	default:
	#wrong prompt
	li $v0, 4
	la $a0, wrong
	syscall
	j cont
	
	
	

	
	
