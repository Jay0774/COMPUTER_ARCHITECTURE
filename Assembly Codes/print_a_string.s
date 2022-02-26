.data
length: .word 97  #legs size
star:  .string "hello world\n"
spa:  .string " "

.text

print:
la a1, star
addi a0,x0,4
addi a7,x0,64
ecall
# Return 0
addi a0,x0,10
ecall