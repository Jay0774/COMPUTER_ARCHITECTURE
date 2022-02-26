# defining the strings
.data
input: .string "Enter Array Elements\n"
input1: .string "Enter the value of n:\n"
input2: .string "Enter the value of k:\n"
out: .string "Output is\n"
space: .string " "
# declaring the array having 0 as an element
data: .word 0

.text
# taking the values of n,k from user and calculating the result
# n is saved in a1
# k is saved in a2
takeinput:

la a0,input
addi a7,x0,4
ecall

addi x2,x0,5
la a0,data
add x1,a0,x0
l:
beq x2,x0,take_elements
addi a7,x0,5
ecall
sw a0,0(x1)
addi x1,x1,4
addi x2,x2,-1
j l

take_elements:
la a0, input1
addi a7,x0,4
ecall
addi a7,x0,5
ecall
add a1,a0,x0

la a0, input2
addi a7,x0,4
ecall
addi a7,x0,5
ecall
add a2,a0,x0


# storing the address of array in a0
la a0,data
# storing the return address in x1
la x1,output
# call to function
j swap
# return address has label output which shows output and exits the code 
output:
addi x2,x0,5
add x3,x0,a0
loop:
beq x2,x0,exit
lw a0,0(x3)
addi a7,x0,1
ecall
la a0,space
addi a7,x0,4
ecall
addi x3,x3,4
addi x2,x2,-1
j loop

swap:
slli x5,a1,2
slli x6,a2,2
add x5,x5,a0
add x6,x6,a0
lw x7,0(x5)
lw x8,0(x6)
sw x8,0(x5)
sw x7,0(x6)
jr x1

# function for exit
exit:
addi a7,x0,10
ecall

