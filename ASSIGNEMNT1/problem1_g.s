# defining the strings
.data
input1: .string "Enter the value of i:\n"
input2: .string "Enter the value of j:\n"
input3: .string "Enter the value of g:\n"
input4: .string "Enter the value of h:\n"
out: .string "Output is\n"
nl: .string "\n"

.text
# taking the values of i ,j ,g, h, from user and calculating the result
# i is saved in a1
# j is saved in a2
# g is saved in a3
# h is saved in a0
takeinput:

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

la a0, input3
addi a7,x0,4
ecall
addi a7,x0,5
ecall
add a3,a0,x0

la a0, input4
addi a7,x0,4
ecall
addi a7,x0,5
ecall

# storing the return address in x1
la x1,output
# call to function
j example
# return address has label output which shows output and exits the code 
output:
addi a7,x0,1
ecall
j exit

# function example defined in this first i + j is done that is a1 + a2 and g + h => a0 + a3
# then (g+h)-(i+j) is done using a0 - a1 and a0 is returned.
example:
addi x2,x0,0
add a0,a0,a3
add a1,a1,a2
sub x2,a0,a1
mv a0,x2
jr x1

# function for exit
exit:
addi a7,x0,10
ecall

