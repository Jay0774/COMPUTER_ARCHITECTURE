.data

array: .word 2000
size: .word 24

.text

main:
# size of array stored in size used in => x6
# start address of array stored in array used in => x3
# repetations => x13
# step size => x14
# option => x15
la x6,size
lw x6,0(x6)
la x3,array
addi x5,x0,0
addi x13,x0,10
addi x14,x0,8
addi x15,x0,1
addi x5,x0,0
l:
beq x5,x6,initialise
sw x0,0(x3)
addi x3,x3,4
addi x5,x5,4
j l
initialise:
#jal ra,print
j outer
done:
# Return 0
addi a0,x0,10
ecall

outer:
la x6,size
la x3,array
addi x4,x0,0
lw x6,0(x6)
bne x13,x0,inner
j done

inner:
beq x15,x0,zero
lw x17,0(x3)
addi x17,x17,1
sw x17,0(x3)
back:
addi x18,x0,0
loop:
beq x18,x14,stepdone
addi x4,x4,1
addi x3,x3,4
addi x18,x18,1

j loop
stepdone:
blt x4,x6,inner
addi x13,x13,-1
#jal ra,print
j outer

zero:
la x2,array
sw x0,0(x2)
j back

print:
la x3,array
add x5,x0,x6
data:
lw x4,0(x3)
add a1,x4,x0
addi a0,x0,1
ecall
addi x5,x5,-4
addi x3,x3,4
bne x5,x0,data
ret

