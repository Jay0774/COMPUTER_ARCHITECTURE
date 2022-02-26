# Defining the string required for taking input and prviding output
.data
input: .string "Enter a string\n"
check: .string "Entered Input is\n"
length: .string "Enter input has length\n"
out: .string "Output is\n"
sign: .word 1,-1
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

# defining the atoi function as
# if s[i] > 47 and s[i] < 58  then r = r * 10 + s[i]-'0'
# else r = 0
# also if s[0] = - then r = r * -1
# 0 to 9 = > 48 to 57 and space = 32 and - = 45 in ascii is used
atoi:
addi x1,x0,0
add x3,x0,a6
addi x5,x0,10
addi x7,x0,47
addi x8,x0,58
addi x9,x0,45
addi x6,x0,1
addi x11,x0,32
addi x12,x0,0
l:
lb x4,0(x3)
r:
beq x2,x0,output
beq x4,x11,b1
beq x4,x9,b3
blt x4,x7,output
blt x8,x4,output
mul x1,x1,x5
addi x4,x4,-48
add x1,x1,x4
b3:
addi x6,x0,-1
addi x3,x3,1
addi x2,x2,-1
lb x4,0(x3)
beq x4,x11,output
j r
b1:
addi x3,x3,1
addi x2,x2,-1
j l

# printing the output
output:
la a0,out
addi a7,x0,4
ecall
mul x1,x1,x6
mv a0,x1
addi a7,x0,1
ecall

# function for exit
exit:
addi a7,x0,10
ecall

