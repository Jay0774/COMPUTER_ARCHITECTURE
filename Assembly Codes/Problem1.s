.data

array: .word 0
size: .word 20

.text

main:
# reps => x2
# steps => x3
# options => x4
# start address of array => x5
# size of array => x6
li x2,10
li x3,2
li x4,0
la x5,array
lw x6,size

initialise:
sw x0,0(x5)
slli x5,x5,2
addi x6,x6,-1
bne x6,x0,initialise
la x5,array
lw x6,size
jal ra,outer
# Return 0
addi a0,x0,10
ecall


outer:
lw x6,size
bgt x2,x0,inner
ret
inner:
bgt x6,x0,option
j outer
option:
beq x4,x0,zero
lw x8,0(x5)
addi x8,x8,1
sw x8,0(x5)
jal ra,print
next:
sll x5,x5,x3
sub x6,x6,x3
addi x2,x2,-1
j inner
zero:
la x9,array
sw x0,0(x9)
j next

print:
# printing the value 
add a1,x0,x8
addi a0,x0,1
ecall
ret