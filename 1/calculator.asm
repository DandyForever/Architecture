      .data
#sequence: .word  '+', '*', 4, 2, 3
#size: .word  5
#sequence: .word  '+', '*', 56, 11, 77
#size: .word  5
sequence: .word  '+', '*', '*', '-', '+', '+', '*', 3, 10, 4, 1, 10, 4, 3, 1
size: .word  15
#sequence: .word  '+', '*', '*', 7, 5, 14, 3
#size: .word  7
      .text
      la $a1, sequence
      la $t0, size
      lw $a2, 0($t0)
      li $a3, 0
      jal calc
      add $a0, $zero, $v0
      li $v0, 1
      syscall
      li $v0, 10
      syscall
      
calc: add $t0, $zero, $a1 #address of sequence begin
      add $t1, $zero, $a3 #index of current node
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
      jal calc
      lw $ra, 12($sp)
      lw $t2, 8($sp)
      lw $t1, 4($sp)
      lw $t0, 0($sp)
      addi $sp, $sp, 16
      addi $t2, $t2, 1
      bge $t2, $a2, ch2
      #handle dfs for second child
      subi $sp, $sp, 20
      sw $t0, 0($sp)
      sw $t1, 4($sp)
      sw $t2, 8($sp)
      sw $v1, 12($sp)
      sw $ra, 16($sp)
      add $a3, $zero, $t2
      jal calc
      lw $ra, 16($sp)
      lw $v1, 12($sp)
      lw $t2, 8($sp)
      lw $t1, 4($sp)
      lw $t0, 0($sp)
      addi $sp, $sp, 20
      sll $t4, $t1, 2
      add $t0, $t0, $t4
      lw $a0, 0($t0)
      bne $a0, 42, plus
      mult $v0, $v1
      mflo $t5
      j handl
plus: bne $a0, 43, minus
      add $t5, $v0, $v1
      j handl
minus:sub $t5, $v1, $v0
handl:and $t3, $t1, 0x01
      beqz $t3, neve
      add $v1, $zero, $t5
      j ddo
neve:  add $v0, $zero, $t5
ddo:   jr $ra
ch2:  sll $t4, $t1, 2
      add $t0, $t0, $t4
      and $t3, $t1, 0x01
      beqz $t3, even
      lw $v1, 0($t0)
      j odd
even: lw $v0, 0($t0)
odd:   
      #lw $a0, 0($t0)
      #li $v0, 1
      #syscall
      #li $a0, ' '
      #li $v0, 11
      #syscall
      jr $ra
