.data

array: .word 2000 # Starting address of array
size: .word 256  # size of array in bytes, no. of elements = size/4 

.text

main:
# repetations => x13
# step size => x14
# option => x15
# initializing the variables rep count, step size, and opion
addi x13,x0,2
addi x14,x0,2
addi x15,x0,1
# size of array stored in size used in => x6
# start address of array stored in array used in => x3
la x6,size
lw x6,0(x6)
la x3,array
addi x5,x0,0
#jal ra,print
# running the outer loop
# here x13 = i = repetations
j outer
done:
# Return 0
addi a0,x0,10
ecall

# for each outer loop 
outer:
# initializing the array
# using x4 as j to check whether the j<size that is x4<x6 
la x6,size
la x3,array
addi x4,x0,0
lw x6,0(x6)
# if i == 0 return to the main else inner loop
bne x13,x0,inner
j done

# running the inner loop
inner:
# checking if option = 0
# if option = 0 going to the zero part
beq x15,x0,zero
# if option is not equal to zero then incrementing a[j] += 1
# loading the element
lw x17,0(x3)
# incrementing by one
addi x17,x17,1
# storing the element
sw x17,0(x3)

# back label is used for j += step 
back: 
# setting x18 = 0 and incrementing x3 that is j till x18 reaches step size
addi x18,x0,0
# running loop
loop:
beq x18,x14,stepdone
# incrementing j
# here 4 is incremented since the array size is given in bytes hence size/4 will be no. of elements
# if the array size is integer and not in bytes add 1 instead of 4 
addi x4,x4,4
# incrementing array adderss 
addi x3,x3,4
# incrementing x18 to check whether x18 is equal to step size
addi x18,x18,1
j loop
# checking if j < size
stepdone:
blt x4,x6,inner
# decrementing the value of i
addi x13,x13,-1
#jal ra,print
j outer

# here if option is zero then the element a[0] = 0
zero:
# accessing the array
la x2,array
# storing zero at a[0]
sw x0,0(x2)
j back

# this function is used for printing the array but when using this function more access were introduced hence this function is not used
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

