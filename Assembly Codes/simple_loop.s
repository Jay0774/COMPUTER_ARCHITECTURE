.data

array: .word 2000
size: .word 40

.text

main:
# size of array stored in size used in => x6
# start address of array stored in array used in => x3
# repetations => x4
# step size => x8
# option => x9
la x6,size
lw x6,0(x6)
la x3,array
addi x5,x0,0
loop:
beq x5,x6,done
sw x5,0(x3)
addi x3,x3,4
addi x5,x5,4
j loop
done:
jal ra,print
# Return 0
addi a0,x0,10
ecall

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

