      .data
#sequence: .word  1
#size: .word  1
#sequence: .word  1, 2
#size: .word  2
#sequence: .word  1, 2, 3
#size: .word  3
#sequence: .word  1, 2, 3, 4
#size: .word  4
#sequence: .word  1, 2, 3, 4, 5
#size: .word  5
#sequence: .word  1, 2, 3, 4, 5, 6
#size: .word  6
#sequence: .word  1, 2, 3, 4, 5, 6, 7
#size: .word  7
#sequence: .word  1, 2, 3, 4, 5, 6, 7, 8, 9, 10
#size: .word  10
#sequence: .word  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
#size: .word  15
sequence: .word  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
size: .word  20
      .text
      la $a1, sequence
      la $t0, size
      lw $a2, 0($t0)
      li $a3, 0
      jal dfs
      li $v0, 10
      syscall
      
dfs:  add $t0, $zero, $a1
      add $t1, $zero, $a3
      sll $t2, $t1, 1
      addi $t2, $t2, 1
      bge $t2, $a2, ch2
      #handle dfs for first child
      subi $sp, $sp, 16
      sw $t0, 0($sp)
      sw $t1, 4($sp)
      sw $t2, 8($sp)
      sw $ra, 12($sp)
      add $a3, $zero, $t2
      jal dfs
      lw $ra, 12($sp)
      lw $t2, 8($sp)
      lw $t1, 4($sp)
      lw $t0, 0($sp)
      addi $sp, $sp, 16
      addi $t2, $t2, 1
      bge $t2, $a2, ch2
      #handle dfs for second child
      subi $sp, $sp, 16
      sw $t0, 0($sp)
      sw $t1, 4($sp)
      sw $t2, 8($sp)
      sw $ra, 12($sp)
      add $a3, $zero, $t2
      jal dfs
      lw $ra, 12($sp)
      lw $t2, 8($sp)
      lw $t1, 4($sp)
      lw $t0, 0($sp)
      addi $sp, $sp, 16
ch2:  sll $t1, $t1, 2
      add $t0, $t0, $t1
      lw $a0, 0($t0)
      li $v0, 1
      syscall
      li $a0, ' '
      li $v0, 11
      syscall
      jr $ra
