.data
#variables of Min,Max,sum,average,sort
	array:       .space  40  #(up to 10 items) * (4 bytes)
	arraySize:   .word   0   #array length
	
	#Answers
	theAverage:  .word  0
	theSum:      .word  0
	theMax:      .word  0
	theMin:      .word  0
	
	#Messages
	newline: .asciiz  "\n"
	point:   .asciiz  "."
	spacing: .asciiz  ","
	colon:   .asciiz  " :"
	
	Message:       .asciiz  "\nEnter size of the array " 
	promptMessage: .asciiz  "\nEnter numbers " 
	Input: 	       .asciiz  "\nThe numbers in descending order are " 
	Average:       .asciiz  "\nThe Average is  "
	Sum:           .asciiz  "\nThe Sum is  "
	Min:           .asciiz  "\nThe Min is  "
	Max:           .asciiz  "\nThe Max is  "
	
	
	
   mess1:  .asciiz  "\nplease Enter either\nNumber (1): for min,max,sum,average,descending sort of digits of an array \nNumber (2): for calculating nCr \nNumber (3): for caluclating the factorial of intger number\nNumber (4): for calcuating Fibonacci sequence\nNumber (5): for decimal to binary conversion\nNumber (6): to quit\n"  
  #main
  valid1:  .asciiz "\n**********Please enter a valid input.**********\n"
  line:  .asciiz "\n*****************************************************************************************\n"
   
 #---------------------------------------------------------------------------------------------------------------------------------
   
  #nCr
   promptMessage1: .asciiz "\nEnter n: "	  #.asciiz for string
   promptMessage2: .asciiz "Enter r: "
   errorMsg: 	   .asciiz "out of range"
   errorMsg2:	   .asciiz "invaild input"
   resultMessage:  .asciiz "C"
   resultmessage2: .asciiz " = "
   n:     	   .word   0			  #.word for integer
   r:              .word   0
   theAnswer:      .word   0
   max1:	    .word   10000000000	  #must  be less than 4294967295(2^32 - 1) 
   
 #---------------------------------------------------------------------------------------------------------------------------------
   
  #Fibonacci sequence
  prompt1: .asciiz "Enter the sequence index/n "
  prompt2: .asciiz "The Fibonacci value is: "
  nl:         .asciiz     "\n"
  
  
 #---------------------------------------------------------------------------------------------------------------------------------
 
 
  # Factorial
  popMessage: .asciiz "Enter a anumber to find its factorial:  "
  resultMassege: .ascii "\n The factorial of number is "
  theNumber: .word 0

 #---------------------------------------------------------------------------------------------------------------------------------
  
  #Binary
  mess7: .asciiz "\nenter a decimal number\n"

 #---------------------------------------------------------------------------------------------------------------------------------
 
 
   #Main Function
.text
  main:
  
    li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
  la $a0, line         # Load address of the string "line" into register $a0
  syscall              # Execute the system call to print the string

  li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
  la $a0, mess1        # Load address of the string "mess1" into register $a0
  syscall              # Execute the system call to print the string

  # Take 1, 2, 3 , 4 , 5 or 6 from the user.
  li $v0, 5            # Load immediate value 5 into register $v0 (system call code for reading an integer)
  syscall              # Execute the system call to read an integer

  beq $v0, 1, func3    # Branch to "func3" if the value in register $v0 is equal to 1
  beq $v0, 2, func1    # Branch to "func1" if the value in register $v0 is equal to 2
  beq $v0, 3, func4    # Branch to "func4" if the value in register $v0 is equal to 3
  beq $v0, 4, func2    # Branch to "func2" if the value in register $v0 is equal to 4
  beq $v0, 5, func5    # Branch to "func5" if the value in register $v0 is equal to 5
  beq $v0, 6, quit     # Branch to "quit" if the value in register $v0 is equal to 6

invalid:              # Label for the invalid option
  li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
  la $a0, valid1       # Load address of the string "valid1" into register $a0
  syscall              # Execute the system call to print the string
  j main               # Unconditional jump to the "main" label (to start the main part of the program)

  
 #---------------------------------------------------------------------------------------------------------------------------------
 #nCr
 
 func1:    
	# call input function
     		jal input1
	# call the nCr function
  		jal nCr			
      	# call the Display function
     		jal Display   
 	# end the program
 		jal endProgram	
#---------------------------------------------------------------------------------------------------------------------------------
	input1:
	  	addi $sp, $sp, -4		# allocate one more free space
		sw   $ra, 0($sp)      		# store the return address in a free location
    	#display the prompt message
     		li $v0, 4    		        # 4 to tell the system to print a string text that located in $a0
     		la $a0, promptMessage1         #load the message from the golbal vriable "prommptMessage1" from the ram into $a0 in order to print it
   		syscall			        # execute the system call specified by the value in $v0  
 	# read the number from the user
  		li $v0,5		        # 5 to tell the system to read an integer value from the user that would be saved in $v0
  		syscall			        # execute the system call specified by the value in $v0
   		sw $v0, n  		        # store the value from the user in the gobal variable n
  	#display the prompt message
     		li $v0, 4    		        # 4 to tell the system to print a string text that located in $a0
     		la $a0, promptMessage2         # load the message from the golbal vriable "prommptMessage2" from the ram into $a0 in order to print it
   		syscall                        # execute the system call specified by the value in $v0
    	# read the number from the user
  		li $v0,5		        # 5 to tell the system to read an integer value from the user that would be saved in $v0
  		syscall			        # execute the system call specified by the value in $v0
  		sw $v0, r 		        #store the value from the user in the gobal variable r
        # check for invalid input
		jal invalid1
		lw   $ra, 0($sp)        	# get back the value $ra to return back to  the caller function
		addi $sp, $sp, 4 		# free the  space locations	 
	#return to the caller function
  		jr $ra		
#---------------------------------------------------------------------------------------------------------------------------------
	invalid1:	
	   lw $a0,n			# load n from the ram into the argument regiser $a0 to pass it to the function
  	   lw $a1,r			# load r from the ram into the argument regiser $a1 to pass it to the function	
	#check for invaild input
	   slt 	$t0,$a0,$a1		# check if  n < r		  --> $t0 =1
	   slt 	$t1,$a0,$zero		# check if  n is a negative value --> $t1 =1
	   slt 	$t2,$a1,$zero		# check if  r is a negative value --> $t2 =1
	   or  	$t3,$t0,$t1		# check if  n < r or n is a negative value  --> $t3 =1	
	   or  	$t1,$t2,$t3		# check if  (n < r or n is a negative vaule) or (r is a negative vaule) --> $t1 =1
	   beq 	$t1,$zero,pass		# check for invaild input ($t1 = 1) or to pass and continue the function
	   li 	$v0,4			# 4 to print a string text that is located in $ a0
  	   la 	$a0,errorMsg2   	# to print the rest of the result message
  	   syscall	
  	   j func1			# execute the system call specified by the value in $v0
	    pass:			# end of the program
	    jr $ra				# return to the caller function
		
#---------------------------------------------------------------------------------------------------------------------------------
 
 overflow:
 		lw 	$t3,max1			# load the maximum value in the $t3
		slt 	$t1,$v0,$zero		# check if  $v0 is a negative value
  		slt     $t2,$t3,$v0		# check if $v0 is greater than the maximum value
  		or	$t3,$t1,$t2		# check of $v0 is a negative value or greater than the maximum value
  		beq	$t3,$zero,valid		# if $v0 is postive value and less than the maximum value then would jump to valid label
  		li 	$v0,4			# 4 to print a string text that is located in $ a0
  		la 	$a0,errorMsg    	# to print the string located in the golbal variable $a0
  		syscall				# execute the system call specified by the value in $v0
  		j 	func1		# return to the calelr fucntion		 
		valid:	
		jr $ra				# return to the caller function 
#---------------------------------------------------------------------------------------------------------------------------------

	nCr:				# n = $a0   r = $a1 
		addi $sp, $sp, -12	# allocate three more free space
		sw   $ra, 0($sp)      	# store the return address in a free location
		sw   $s0, 4($sp)      	# store the value of  $s0 in a free location
		sw   $s1, 8($sp)      	# store the value of  $s1 in a free location
		
		lw $a0,n		# load n from the ram into the argument regiser $a0 to pass it to the function
  		lw $a1,r		# load r from the ram into the argument regiser $a1 to pass it to the function
				
		#get nPr	
		jal check		# to check if r > n/2  if so then it would be set to n-r to avoid over flow in bigger r
		jal nPr			# call the function
		add $s0,$v0,$zero     	# save the rsult in $s0
	
		# get rPr
		move $a0,$a1		# load n in argument register $a0 to pass it to function and set it to the value of r
		jal nPr			# call the function
		add $s1,$v0,$zero	# save the resutl in $s1
	
		#get the answer [nCr = (nPr)/(rPr)]
		div $v0,$s0,$s1
		
		sw $v0,theAnswer	# store the value in theAnswer 
		
		# ending the function
		lw   $ra, 0($sp)        # get back the value $ra to return back to  the caller function
		lw   $s0, 4($sp)        # get back the value of $s0
		lw   $s1, 8($sp)        # get back the value of $s1
		addi $sp, $sp, 12 	# free the  space locations	 
	     
		#return to the caller fucntion
		jr $ra
		
#---------------------------------------------------------------------------------------------------------------------------------
	check:					# $a0 = n , $a1 = r
		
		#check for overflow:
		div   $t2,$a0,2			# $t2 = n/2
		slt   $t1,$a1,$t2		# check if the r is biger than n/2
		bne   $t1,$zero end		# if r < n/2 then  to the caller function
		sub   $t3,$a0,$a1		# nCr = (n-r)Cr then if r > n/2 would be set to n-r to avoid overflow in large numbers
		add   $a1,$t3,$zero		# r = n-r
		end:				# end of the program
		jr    $ra			# return back to the caller function	
			
#---------------------------------------------------------------------------------------------------------------------------------

		
	nPr:					# $a0 = n    ,  $a1 = r     $t0= counter   $v0 = result  
	     	addi $sp, $sp, -4		# allocate one more free space
		sw   $ra, 0($sp)      		# store the return address in a free location
	     	
	     	addi  $v0,$zero,1   		# give inital value to $v0 = 1
	     	add   $t0,$zero,$zero 		# use $t0 as counter in the loop
	     	loop:				# the begining of the loop --> for(int c = 0; c<r; c++)
	     	beq   $t0,$a1,endloop		# if (counter == r) end	  
	     	mul   $v0,$v0,$a0		# $v0 = $v0 * $a0
	     	jal   overflow			# check if there is an over flow
	     	addi  $a0,$a0,-1		# decrease the value on n by 1
	     	addi  $t0,$t0,1			# increase the counter by one
	 	j     loop			# return back to the loop
	        endloop:			# the end of the loop
	   
	   	lw   $ra, 0($sp)        	# get back the value $ra to return back to  the caller function
		addi $sp, $sp, 4 		# free the  space locations	 
	        # end of the loop
	     	jr    $ra		        # retun to the caller funtion 
		
#---------------------------------------------------------------------------------------------------------------------------------

	Display:
	# Display the result
		
		li	$v0,1 			# 1 to print an integer value that is located in $ a0
  		lw  	$a0,n			# to print the number
  		syscall				# execute the system call specified by the value in $v0
		        	
  		li 	$v0,4			# 4 to print a string text that is located in $ a0
  		la 	$a0,resultMessage    	# to print the string located in the golbal variable $a0
  		syscall				# execute the system call specified by the value in $v0
  	
  		li 	$v0,1 			# 1 to print an integer value that is located in $ a0
  		lw 	$a0,r			# to print the value of global vriable "theAnswer"
  		syscall				# execute the system call specified by the value in $v0
  	  		
  		li 	$v0,4			# 4 to print a string text that is located in $ a0
  		la 	$a0,resultmessage2   	# to print the rest of the result message
  		syscall				# execute the system call specified by the value in $v0
  		
  		li 	$v0,1 			# 1 to print an integer value that is located in $ a0
  		lw 	$a0,theAnswer		# to print the value of global vriable "theAnswer"
  		syscall				# execute the system call specified by the value in $v0
  		
  		jr $ra				#return to the caller function
  		


#-----------------------------------------------------------------------------------------------------------------------------------
 	endProgram:	
 	       j main	        
 #--------------------------------------------------------------------------------------------------------------------------------- 	
 
 
 
# Fiboniciaa sequance
    
 func2:
 # Message: "Enter the index"
    li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
    la $a0, prompt1      # Load address of the string "prompt1" into register $a0
    syscall              # Execute the system call to print the string
    
 # Read input from the user
    li $v0, 5            # Load immediate value 5 into register $v0 (system call code for reading an integer)
    syscall              # Execute the system call to read an integer

 # Call the fibonacci function
    move $a0, $v0        # Move the user input value to register $a0 (function argument)
    jal fib              # Jump and link to the "fib" function
    move $a1, $v0        # Move the return value of fibonacci to register $a1

# Print "prompt2"
    li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
    la $a0, prompt2      # Load address of the string "prompt2" into register $a0
    syscall              # Execute the system call to print the string

# Print the result
    li $v0, 1            # Load immediate value 1 into register $v0 (system call code for printing an integer)
    move $a0, $a1        # Move the value in register $a1 (fibonacci result) to register $a0 (function argument)
    syscall              # Execute the system call to print the integer

# Exit the program
    li $v0, 10           # Load immediate value 10 into register $v0 (system call code for program termination)
    syscall              # Execute the system call to terminate the program

# Function: int fibonacci(int n)
fib:
  # Save registers
  addi $sp, $sp, -16    # Allocate space on the stack for saving registers
  sw $ra, 0($sp)        # Save the return address on the stack
  sw $s0, 4($sp)        # Save register $s0 on the stack
  sw $s1, 8($sp)        # Save register $s1 on the stack
  sw $s2, 12($sp)       # Save register $s2 on the stack

  # Check base cases
  beq $a0, 0, fib_return_0     # Branch to "fib_return_0" if the value in register $a0 is equal to 0
  bne $a0, 1, fib_check_2      # Branch to "fib_check_2" if the value in register $a0 is not equal to 1
  li $v0, 1                   # Load immediate value 1 into register $v0 (base case: fibonacci(1) = 1)
  j fib_return                # Jump to "fib_return"

fib_check_2:
    bne $a0, 2, fib_recursive  # Branch to "fib_recursive" if the value in register $a0 is not equal to 2
    li $v0, 1                 # Load immediate value 1 into register $v0 (base case: fibonacci(2) = 1)
    j fib_return              # Jump to "fib_return"

fib_recursive:
    addi $sp, $sp, -4    # Allocate space on the stack for saving register
    sw $a0, 0($sp)       # Save the value of register $a0 on the stack
    addi $a0, $a0, -1    # Decrement the value in register $a0 by 1 (fibonacci(n-1))
    jal fib              # Jump and link to the "fib" function (recursive call)
    move $s0, $v0        # Move the return value of the recursive call to register $s0

    lw $a0, 0($sp)       # Load the original value of register $a0 from the stack
    addi $a0, $a0, -2    # Decrement the value in register $a0 by 2 (fibonacci(n-2))
    jal fib              # Jump and link to the "fib" function (recursive call)
    move $s1, $v0        # Move the return value of the recursive call to register $s1

    add $v0, $s0, $s1    # Add the values in $s0 and $s1 and store the result in $v0 (fibonacci(n) = fibonacci(n-1) + fibonacci(n-2))

    addi $sp, $sp, 4     # Deallocate the space on the stack used for saving register $a0

fib_return:
    # Restore registers and return
    lw $s2, 12($sp)      # Restore the value of register $s2 from the stack
    lw $s1, 8($sp)       # Restore the value of register $s1 from the stack
    lw $s0, 4($sp)       # Restore the value of register $s0 from the stack
    lw $ra, 0($sp)       # Restore the return address from the stack
    addi $sp, $sp, 16    # Deallocate the space on the stack used for saving registers
    jr $ra               # Jump to the return address

fib_return_0:
    li $v0, 0            # Load immediate value 0 into register $v0 (base case: fibonacci(0) = 0)
    j fib_return         # Jump to "fib_return"

# Print a new line
    li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
    la $a0, nl           # Load address of the string "nl" (newline) into register $a0
    syscall              # Execute the system call to print the newline

j main                 # Unconditional jump to the "main" label (to start the main part of the program)
      # Exit the program
    #__________________________________________________________________________________________________________#
    
    #Min,Max,sum,average,sort
    func3:#print prompt message
		li $v0, 4
		la $a0, Message
		syscall
		li $v0, 4
		la $a0, newline
		syscall 
		
		#read int from the keyboard
		li $v0, 5 
		syscall
		######################
		sw $v0, arraySize # store given int in the $v0
		mul $v1, $v0, 4
		######################
		add  $t0, $t0, $v1  #array size const
		addi $t4, $t4, 90   #loop counter
		addi $t9, $t9, 1    #input counter
		add  $s5, $s5, $v0  #division  s5 = no of elements
		
		#print prompt message
		li $v0, 4
		la $a0, promptMessage
		syscall
		li $v0, 4
		la $a0, newline
		syscall 
		
		#read int from the keyboard
		input:
			beq $t1, $t0, continue
			
			move $a0, $t9 # display num from 1 to 3 to input number
			
			li $v0, 1 
			syscall 
			li $v0, 4
			la $a0, colon
			syscall 
			
			#read int from the keyboard
			li $v0, 5 
			syscall 
			move $t2, $v0 
			
			sw   $t2, array($t1)
			addi $t1, $t1, 4     # next position in the array
			addi $t9, $t9, 1     # update input counter
			
			j input #loop 3 times
			
	continue:
		#reinitialize register 
		move $t1, $zero #for array[x]
		
		move $t2, $zero	
		addi $t2, $t2, 4 #for array[x+1]
		
		move $s0, $zero	
		addi $s0, $s0, 1 #condition check
			
			
	sorting:
		beq $t3, $t4, calculation  #finish loop if($t3 == $t4) t3 loop counter $t4 = go to calc
		beq $t2, $t0, continue     #reinitialize array offset for looping
		
		lw $t5, array($t1) # $t5 = array[x]
		lw $t6, array($t2) # $t6 = array[x+1]
		
		addi $t3, $t3, 1 
		
		slt $t7, $t5, $t6 # if ($t5 < $t6) $t7 = 1
		beq $t7, $s0, rearrange
		
		#increament
		addi $t1, $t1, 4
		addi $t2, $t2, 4
		
		j sorting			
			
	rearrange:
		sw $t5, array($t2) # $t5 = array[x+1]
		sw $t6, array($t1) # $t6 = array[x]	
			
		addi $t1, $t1, 4
		addi $t2, $t2, 4
		
		j sorting
	
	calculation:
		#reinitialize register 
		move $t1, $zero  #array element
		move $t2, $zero	 #temp holder
		move $t3, $zero	 #first array element
		move $t4, $zero
		addi $v1,$v1,-4 #mario	
		add  $t4, $t4, $v1 #last array element
		
		move $t5, $zero	  # min
		move $t6, $zero  # max
		move $t7, $zero				
			
		
	total:
		beq  $t1, $t0, average  #if (t1 == t2 ) go to avg after gettting the sum    t1 offset    t2 = 12
		lw   $t2, array($t1)
		addi $t1, $t1, 4        #update array increament
		add  $s1, $s1, $t2	#t2 new array element s2 
		
		j total		
		
				
	average:
		#div  $s1, $s5 #$s1 / $s5 = array size     divide summation by arraysize
		#mfhi $s2      #s2 = remainder
		#mflo $s3      #s3 = quotient	 
		mtc1 $s1, $f0 		#move to coprocessor
		cvt.s.w $f0, $f0 	#convert to float
		#addi $t5, $zero, 3
		mtc1 $s5, $f2 		#move to coprocessor
		cvt.s.w $f2, $f2 	#convert to float
		div.s $f12, $f0, $f2 
					
#PRINTING								
	output:
		li $v0, 4
		la $a0, newline
		syscall 
		# 0 4 8 12... after sorting 
		lw $t5, array($t3) # $t5 = array[0] max 
		lw $t6, array($t4) # $t6 = array[8] min
		
		li $v0, 4
		la $a0, Input
		syscall 
		
	#print elements of an array in descending order
	element: 
		 beq  $t7, $t0, next
		 lw   $t8, array($t7)
		 addi $t7, $t7, 4
		 
		 #print the value
		 move $a0, $t8
		 li   $v0, 1
		 syscall
		  
		 beq $t7, $t0, element # if t0 != 12
		 
		 #print a comma
		 li $v0, 4
		 la $a0, spacing
		 syscall
		 j element 
	next:	 
	#print sum
	
		#display result message for user
		li $v0, 4
		la $a0, Sum
		syscall
		
		move $a0, $s1 # display sum num 
		li   $v0, 1 
		syscall 
		
	#print average
	
		#display result message for user
		li $v0, 4
		la $a0, Average
		syscall
		
		# display max num 
		#move $a0, $s3
		#li   $v0, 1 
		#syscall 
		
		#li $v0, 4
		#la $a0, point
		#syscall
		
		# display avg num fraction
		#move $a0, $s2 
		#mario
		li   $v0, 2 
		syscall

	#print min
		#display result message for user
		li $v0, 4
		la $a0, Min
		syscall
		
		# display min num 
		move $a0, $t6 
		li   $v0, 1 
		syscall 
				
		
	#print max
		#display result message for user
		li $v0, 4
		la $a0, Max
		syscall
		
		# display max num 
		move $a0, $t5 
		li   $v0, 1 
		syscall  
   j main
#---------------------------------------------------------------------------------------------------------------

 #Factorial
 
  func4:
 .text 
      li $v0, 4            # Load immediate value 4 into register $v0 (system call code for printing a string)
      la $a0, popMessage   # Load address of the string "popMessage" into register $a0
      syscall              # Execute the system call to print the string

      li $v0, 5            # Load immediate value 5 into register $v0 (system call code for reading an integer)
      syscall              # Execute the system call to read an integer
      sw $v0, theNumber    # Store the read integer value into the memory location "theNumber"

     # Call the factorial function.
     lw $a0, theNumber     # Load the value from memory location "theNumber" into register $a0 (function argument)
     jal findFactorial     # Jump and link to the "findFactorial" function
     sw $v0, theAnswer     # Store the result of the factorial function in the memory location "theAnswer"

    # Display the results.
    li $v0, 4             # Load immediate value 4 into register $v0 (system call code for printing a string)
    la $a0, resultMassege # Load address of the string "resultMessage" into register $a0
    syscall               # Execute the system call to print the string
    li $v0, 1             # Load immediate value 1 into register $v0 (system call code for printing an integer)
    lw $a0, theAnswer     # Load the value from memory location "theAnswer" into register $a0 (function argument)
    syscall               # Execute the system call to print the integer

 # Tell the OS that this is the end of the program.
   li $v0, 10            # Load immediate value 10 into register $v0 (system call code for program termination)
   syscall               # Execute the system call to terminate the program

.globl findFactorial
  findFactorial:
  subu $sp, $sp, 8      # Subtract 8 from the stack pointer to allocate space for the return address and saved registers
  sw $ra, ($sp)         # Save the return address on the stack
  sw $s0, 4($sp)        # Save the value of register $s0 on the stack

# Base case.
  li $v0, 1             # Load immediate value 1 into register $v0 (base case for factorial)
  beq $a0, 0, factorialDone   # Branch to "factorialDone" if the value in register $a0 is equal to 0

  move $s0, $a0         # Move the value in register $a0 to register $s0 (current factorial value)
  sub $a0, $a0, 1       # Subtract 1 from the value in register $a0 (decrement for recursive call)
  jal findFactorial     # Jump and link to the "findFactorial" function (recursive call)

  mul $v0, $s0, $v0     # Multiply the value in register $s0 (current factorial value) with the return value ($v0) of the recursive call
factorialDone:
  lw $ra, ($sp)         # Load the return address from the stack into register $ra
  lw $s0, 4($sp)        # Load the value of register $s0 from the stack
  addu $sp, $sp, 8      # Add 8 to the stack pointer
# Return from factorial.
  jr $ra              # Jump to the address stored in register $ra (return from the function)

j main               # Unconditional jump to the "main" label (to start the main part of the program)
#################

#-------------------------------------------------------------------------------------------------------------------------

#conversion from decimal to binary
   func5:
    jal binary          # calling the function
    j main              
    

    binary:
   #print message eneter the number
    li $v0,4            # print_string 
    la $a0,mess7        # load address of the string (printing enter a decimal number)
    syscall
    # to take the num from the user
    li $v0,5            #load data from user( input INTEGER)
    syscall             # Read int input
    move $a1, $v0       # Store user input in $a1
   addiu $t0,$zero,31   #set value 31 to register t0
   addiu $t1,$zero,0    #set value 0 to register t1
   
  loop1:
    srlv $t2,$a1,$t0    #place  n/2^i in $t2 (n>>i)
    and $t3,$t2, 1      #do and operator of each bit with 1
     li $v0,1           #print an integer number($t3)
    add $a0,$t3,$zero   
    syscall
    addi $t0,$t0,-1      #decrease the number by one
    bge $t0,$zero,loop1  #if (i) greater than or equal 0 repeat loop1
    jr $ra               #return to the�caller�function
  
#---------------------------------------------------------------------------------------------------------------------------------

#quit 
   quit: 
    li $v0,10
    syscall



