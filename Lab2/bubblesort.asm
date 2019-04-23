.data 
	arraySize: .word 10
	elements: .word 3 7 5 54 1 87 30 75 17 66 
.text
	main:
		#address of the array in $a0,the array size in $a1
		la $a0, elements
		lw $a1, arraySize
		jal bubbleSort
		
		#end of program
		li $v0,10
		syscall	
	
	swapElements: 
		sw  $t5, ($t2) 			# load the word value of t5 into the address of t2 
		sw  $t4, ($t3)			# load the word value of t4 into the address of t3
		subi $t6, $t6, 1 		# decreament count
		li $t7, 0 			# set swapped to true
		j counter		
	bubbleSort:
		#setting t9 as boolean
		addi $t9,$zero,0	
		
		checker:
			beq $t6, $zero, swappedLoop	# if count = 0, exit to while loop
			subi $t5, $t6, 1 		# t5 is t6- 1 to get length - 2 value
			mul $t0, $t6, 4 		# * 4 bytes to get distance from a1 
			mul $t1, $t5, 4 		# * 4 bytes to get (distance from a1) - 1 
			add $t2, $t0, $a1 		# add to a1 address to get actual address
			add $t3, $t1, $a1 		# value at t2 is now the count - 1 item of the list 
			lw $t4, ($t2)			# load actual value at t2 address into t4 
			lw $t5, ($t3)			# load actual value at t3 address into t5 
			blt $t4, $t5, swapPositions 	# branch if t2 is less than t3
			# fall through
			subi $t6, $t6, 1 		# decreament count
			j checker			# return for loop
		
		sorted:
			move $t6, $a0 	 	# move count to t6 so it can be decremeanted
			subi $t6, $t6, 1 	# Decrement count by 1 since nTh byte is 4 * length - 1
			bgtz $t7, printInts 	# if swapped is false go to print ints
			li $t7, 1 		# set swapped to false
	printAll:
		move $t0, $a0 		# save count to t0 so a0 can be used in syscall 
		li $v0, 1 		# set v0 1 for syscall 
		loop2: 
			ble $t0, $zero, out 	# check if count is 0 
			lw $a0, ($a1)		# get word at current address based on count 
			syscall 		# stdout word
			addi $a1, $a1, 4 	# increment word address by 4 bytes 
			subi  $t0, $t0, 1 	# decreament count by 1 
			j loop2		
	out:	
		jr $ra
