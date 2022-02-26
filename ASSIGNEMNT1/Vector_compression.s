# defining the strings for taking input and other requirements
.data
i: .word 0
input: .string "Enter the size of vector:\n"
elements: .string "Entered the vector elements, one integer per line:\n"
out1: .string "The Non zero elements are:\n"
out2: .string "The Non zero indices are:\n"
nl: .string "\n"
space: .string "  "
d: .word 0


.text
# taking the value of n
takeinput:
la a0, input
addi a7,x0,4
ecall
addi a7,x0,5
ecall

# storing the value of n in x1
mv x1,a0

# taking the elements
take_elements: 
addi x2,x0,0
addi x5,x0,0
la a0,d
mv x3,a0
la a0,i
mv x4,a0
la a0,elements
addi a7,x0,4
ecall
# starting the loop
loop:
beq x2,x1,output
addi a7,x0,5
ecall
# checking if the value of entered input is 0 
# if a[i[ = 0 store it in data
# if a[i[ = 0 store index i in i
beq a0,x0,notfound
addi x3,x3,4
sw a0,0(x3)
addi x4,x4,4
sw x2,0(x4)
addi x2,x2,1
addi x5,x5,1
j loop
notfound:
addi x2,x2,1
j loop


# printing the output
# printing new line then printing the elements of compressed
# then printing the compressed indices
output:
la a0,nl
addi a7,x0,4
ecall
la a0,out1
addi a7,x0,4
ecall
addi x1,x0,0
la x6,d

l1:
beq x1,x5,s
lw x7,4(x6)
mv a0,x7
addi a7,x0,1
ecall
la a0,space
addi a7,x0,4
ecall
addi x6,x6,4
addi x1,x1,1
j l1
# for compresssed indices
s:
la a0,nl
addi a7,x0,4
ecall
la a0,out2
addi a7,x0,4
ecall

addi x1,x0,0
la x6,i

l2:
beq x1,x5,exit
lw x7,4(x6)
mv a0,x7
addi a7,x0,1
ecall
la a0,space
addi a7,x0,4
ecall
addi x6,x6,4
addi x1,x1,1
j l2


exit:
addi a7,x0,10
ecall

