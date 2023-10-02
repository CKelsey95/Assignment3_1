.data
database: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
database_size: .word 10
counter: .word 0

.text
    la $t0, database         # Load the base address of the array into $t0
    lw $t1, database_size    # Load the maximum number of elements in the array into $t1
    li $t2, 5                # Value to compare against (5)

for:
    lw $t3, 0($t0)           # Load the current array element into $t3
    bgt $t3, $t2, greater_than_5  # Branch to greater_than_5 if current array value > 5
    j loop                   # Else, continue to the next element in the loop

greater_than_5:
    lw $s0, counter          # Load the current counter value into $s0
    addi $s0, $s0, 1         # Increment the counter
    sw $s0, counter          # Store the updated counter value back in memory

loop:
    addi $t0, $t0, 4         # Move to the next array element (4 bytes per element)
    addi $t5, $t5, 1         # Increment the loop counter
    bne $t5, $t1, for        # If not at the end of the array, continue the loop

    # Print the counter value (number of elements greater than 5)
    lw $a0, counter
    li $v0, 1                # Print integer
    syscall

    li $v0, 10               # Exit the program
    syscall
