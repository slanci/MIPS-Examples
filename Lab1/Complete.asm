.data
	promptElements: .asciiz "Enter number of elements: \n" 
	promptValue: .asciiz "Enter value: \n"
	myArray:.space 80
	newLine: .asciiz "\n"
	
.text
	main:
		#prompt user to enter num of elements
		li $v0, 4
		la $a0, promptElements
		syscall
		#Get num of elements
		li $v0,5
		syscall
		
		move $t1,$v0   #t1 is the number of elements
		syscall
		
		mul $t2,$t1,4
		#i = 0
		addi $t0,$zero,1
		while: 
			bgt $t0,$t2,exit 
			
			#Print enter value message
			li $v0,4
			la $a0,promptValue
			syscall
			
			#get the value
			li $v0,5
			syscall
			
			move $s0,$v0
			
			sb   $s0,myArray($t0)
			addi $t0,$t0,4
	
			#store the num of elements in $t0
			#move $t0,$v0
			#incrementing t0
			#addi $t0,$t0,4
			
			j while
		exit:
			addi $t0,$zero,1
			while2:
				bgt $t0,$t2,exit2 
		    	
				lw $t6,myArray($t0)
				#Print current number
				li $v0,1
				move $a0, $t6
				syscall
		
				#Print a new line
				li $v0,4
				la $a0,newLine
				syscall
				
				addi $t0,$t0,4
				
				j while2
			exit2:
					
				    #Print a new line
					li $v0,4
					la $a0,newLine
					syscall
				while3:
					blt $t0,$zero,exit3
					
					lw $t6,myArray($t0)
					#Print current number
					li $v0,1
					move $a0, $t6
					syscall
		
					#Print a new line
					li $v0,4
					la $a0,newLine
					syscall
					
					addi $t0,$t0,-4
				
					j while3
				
				exit3:		
		
					#Tell the system this is the end of main
					li $v0,10
					syscall


		
	
			.data
	prompt_c: .asciiz "Enter a:\n"
	prompt_d: .asciiz "Enter b:\n"
.text
	#Print enter c message
	li $v0, 4
	la $a0, prompt_c
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	mul  $t1,$t1,$t1

	#Print enter d message
	li $v0, 4
	la $a0, prompt_d
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	mul $t2,$t2,-5 
	#subtract d from c
	sub $t3, $t1, $t2
	
	addi $t3,$t3,7
	#and bitwise 
	andi $t3, $t3, 3
	
	li $v0, 1
	move $a0, $t3
	syscall

	.data
	prompt_c: .asciiz "Enter a:\n"
	prompt_d: .asciiz "Enter b:\n"
.text
	#Print enter c message
	li $v0, 4
	la $a0, prompt_c
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	mul  $t1,$t1,$t1

	#Print enter d message
	li $v0, 4
	la $a0, prompt_d
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	mul $t2,$t2,-5 
	#subtract d from c
	sub $t3, $t1, $t2
	
	addi $t3,$t3,7
	#and bitwise 
	andi $t3, $t3, 3
	
	li $v0, 1
	move $a0, $t3
	syscall


	
	
	
	
	
.data
	myArray: .space 400
	menuText: .asciiz " 1.Find summation of numbers stored in the myArray which is greater than an input number. \n 2.Find summation of even and odd numbers and display them. \n 3.Display the number of occurrences of the myArray elements divisible by a certain input number. \n 4.Quit."
	enterSelection: .asciiz "Enter Selection: " 
	enterNumOfEl: .asciiz "Enter number of elements: "
	enterMessage: .asciiz "Enter numbers: "
	sumBigger: .asciiz "Sum of elements bigger than: "
	
	divBy: .asciiz "no of elements divisible by:  "
	nextLine: .asciiz  "\n"
	
.text
	main:
		#Enter num of elements
		li $v0,4
		la $a0,enterNumOfEl
		syscall
		
		#get num of elements
		li $v0,5
		syscall
		
		move $t1,$v0
		move $s2, $t1
		
		#next line
		li $v0,4
		la $a0,nextLine
		syscall
		
		#Enter elements
		li $v0,4
		la $a0,enterMessage
		syscall
		
		# i = 0
		addi $t0,$zero,0
		
		while:
			beq $t1,$zero,while2
			
			#get values
			li $v0,5
			syscall
			
			#store elements in $t2
			move $t2,$v0
			sw $t2,myArray($t0)
			#increment $t0
			addi $t0,$t0,4
			subi $t1,$t1,1
			j while
		while2:		
			#Print menu
			li $v0,4
			la $a0,menuText
			syscall
			
			#Print
			li $v0,4
			la $a0,nextLine
			syscall
			
			#Print selection prompt 
			li $v0,4
			la $a0,enterSelection
			syscall
			
			#Get selection
			li $v0,5
			syscall
			
			move $t0,$v0
			#if statements
			beq $t0,1,sel1
			beq $t0,2,sel2
			beq $t0,3,sel3
			beq $t0,4,exit
			
			
		sel1:
			move $t1,$s2
			#SumBigger message
			li $v0,4
			la $a0,sumBigger
			syscall
			
			#get limit
			li $v0,5
			syscall
			
			#limit is stored in $t3
			move $t3, $v0
			
			li $t0,0
			addi $t9,$zero,0
			
			while3:
				 
				 #sum is $t5
				 bgt $t9,$t1,while4
				 lw  $t4,myArray($t0)
				 
				 addi $t0,$t0,4
				 addi $t9,$t9,1
				 bgt $t4,$t3,sum
				 j while3
			while4:
				#Print sum
				li $v0,1
				la $a0,($t5)
				syscall
				#next line
				li $v0,4
				la $a0,nextLine
				syscall
				
				j while2
		sel2:
			move $t1,$s2
			#t5 odd
			#t6 even
			li $t5,0
			li $t6,0
			addi $t9,$zero,0
			addi $s6,$zero,1
			addi $t0,$zero,0
			addi $t7,$zero,2
			while5:
			
				#iterate myArray and check if even or odd
				
				bgt $t9,$t1,while6
				lw $t4,myArray($t0)
				div $t4,$t7
				mfhi $t8
				addi $t0,$t0,4
				addi $t9,$t9,1
				beq $t8,$s6,oddSum
				beq $t8,$zero,evenSum
				

			j while5
			
			while6:
				#Print even and odd numbers
				
				#Print odd
				li $v0,1
				move $a0,$t5
				syscall
				 
				li,$v0,4
				la $a0,nextLine
				syscall 
				
				#Print even
				li $v0,1
				move $a0,$t6
				syscall
				#next line
				li $v0,4
				la $a0,nextLine
				syscall
				
				j while2
		sel3:
			#Divisible by
			li $v0,4
			la $a0,enterNumOfEl
			syscall
			
			li $v0,5
			syscall
			
			move $s3,$v0   #divisivle by $s3
			
			li $t0,0
			li $t9,0
			li $t5,0
			while7:
				 move $t1,$s2
				 #sum is $t5
				 bgt $t9,$t1,while8
				 lw  $t4,myArray($t0)
				 
				 addi $t0,$t0,4
				 addi $t9,$t9,1
				 div $t4,$s3
				 mfhi $t8
				 beq $t8,0,divSum
				 							
			j while7
			
			while8:
				#print 
				li $v0,1
				move $a0,$t5
				syscall
				#next line
				li $v0,4
				la $a0,nextLine
				syscall
				
				j while2
		divSum:
			addi $t5,$t5,1
			j while7
			
		sum:	
			add $t5,$t5,$t4 
			j while3  	
		oddSum:
			add $t5,$t5,$t4	
			j while5	
		evenSum:
			add $t6,$t6,$t4
			j while5				
		exit:
			#End of program
			li $v0,10
			syscall
		
		
