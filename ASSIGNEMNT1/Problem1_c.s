# Defining the string required for taking input and prviding output
.data
input: .string "Enter a string\n"
check: .string "Entered Input is\n"
length: .string "Enter input has length\n"
y: .string "Entered input is Pallindrome"
n: .string "Entered input is not Pallindrome"
nl: .string "\n"

.text

# created take input function which takes a string as input
takeinput:
la a0, input
addi a7,x0,4
ecall
addi a1,x0,100
addi a7,x0,8
ecall

# created print input which prints the input string
printinput: 
add a4,x0,a0
la a0,check
addi a7,x0,4
ecall
add a0,x0,a4
addi a7,x0,4
ecall
addi x2,x0,-1
add x4,x0,a0

# running the loop to calculate the length of the string using the *b==0 property
loop:
lb x3,0(x4)
beq x3,x0,printlength
addi x2,x2,1
addi x4,x4,1
jal loop

# prints the length of the string
printlength:
mv a6,a0
addi x4,x4,-2
la a0,length
addi a7,x0,4
ecall
mv a0,x2
addi a7,x0,1
ecall
la a0,nl
addi a7,x0,4
ecall

# function that checks for pallindrome
pallindrome:
addi x3,x0,1
# if length of input = 1 it is pallindrome
beq x2,x3,yes
addi x3,x0,2
# dividing the length by 2 so that middle elements can be checked
div x1,x2,x3
addi x3,x0,0
addi x5,x0,0
add x3,x0,a6

# running the loop till middle element
l:
lb x2,0(x3)
lb x5,0(x4)
# subtracting the ascii values of s[i] and s[n-i-1] if equal to 0 then characters are same
sub x6,x2,x5
bne x6,x0,no
addi x4,x4,-1
addi x3,x3,+1
addi x1,x1,-1
beq x1,x0,yes
bne x1,x0,l

# prints if the string is a pallindrome
yes:
la a0,y
addi a7,x0,4
ecall
j exit

# prints if the string is not pallindrome
no:
la a0,n
addi a7,x0,4
ecall
j exit

# exits the program 
exit:
addi a7,x0,10
ecall

