# defining the data section which contain the data variables/labels
.data
input: .string "What would you like to convert?\n"
check: .string "Entered Input is\n"
length: .string "Enter input has length\n"
out: .string "Output is\n"
g: .string "GoodBye\n"
nl: .string "\n"
data: .string "\n"
.text

# taking input from user
takeinput:
# defining the values of ascii letters 
addi x9,x0,101
addi x20,x0,57
addi x23,x0,96
# using x1 to check whether entered input is e or not which is stored in x9
loop:
la a0,input
addi a7,x0,4
ecall
la a0,data
addi a1,x0,100
addi a7,x0,8
ecall
lb x1,0(a0)
beq x1,x9,exit
bne x1,x9,printinput

# currenly ont prinint input as not required by program is required one statement need to be added
printinput: 
addi x2,x0,0
la x4,data
l1:
lb x3,0(x4)
beq x3,x0,printlength
addi x4,x4,1
addi x2,x2,1
j l1

# currently not printing length which is stored in x2
printlength:
addi x4,x4,-2
addi x2,x2,-1

# checking the first character to get the conversion
# d -> decimal to hex input format (d h number)
# h -> hex to decimal (h d 0xnumber)
# these two were asked in the problem
la a0,data
lb x3,0(a0)
addi x5,x0,100
beq x3,x5,decimal_to_hex
addi x5,x0,104
beq x3,x5,hex_to_decimal

# converting hex decimal to hex output is in x24 
decimal_to_hex:
addi x25,x0,10
addi x26,x0,1
addi x24,x0,0
addi x28,x0,1
la x3,data
addi x3,x3,4
addi x4,x2,-5
addi x2,x2,-4
p1:
beq x4,x0,l2
mul x26,x26,x25
addi x4,x4,-1
j p1
l2:
beq x2,x0,outputh
lb x19,0(x3)
addi x19,x19,-48
mul x19,x19,x26
div x26,x26,x25
add x24,x24,x19
addi x3,x3,1
addi x2,x2,-1
j l2

# converting from hexadecimal to decimal used
# 0x123 => 1*16^2 + 2*16^1 + 3 
hex_to_decimal:
addi x22,x0,16
addi x27,x0,1
addi x24,x0,0
la x3,data
addi x3,x3,6
addi x4,x2,-7
addi x2,x2,-6
p2:
beq x4,x0,l3
mul x27,x27,x22
addi x4,x4,-1
j p2
l3:
beq x2,x0,outputd
lb x19,0(x3)
bgt x19,x23,o1
addi x19,x19,-48
j o2
o1:
addi x19,x19,-87
o2:
mul x19,x19,x27
div x27,x27,x22
add x24,x24,x19
addi x3,x3,1
addi x2,x2,-1
j l3

# use x24 to print the output
outputd:
add a0,x0,x24
addi a7,x0,1
ecall
la a0,nl
addi a7,x0,4
ecall
j loop

outputh:
add a0,x0,x24
addi a7,x0,34
ecall
la a0,nl
addi a7,x0,4
ecall
j loop

# exiting the code
exit:
la a0,g
addi a7,x0,4
ecall
addi a7,x0,10
ecall

