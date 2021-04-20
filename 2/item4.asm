.text
main:
    li      $t3, 1
    li      $t4, 0
    li      $t1, 0
loop:
    beq     $t4, 0, magic_br_1 # branch #1
    addi    $t4, $t4, 0
magic_br_1:
    nop
    nop
    nop
    nop
    nop
    beq     $t3, 0, magic_br_2 # branch #2
    addi    $t3, $t3, 0
magic_br_2:

# ****** ADD HERE ******
    nop
    nop
    nop
    nop
    nop
    beq	    $t3, 0, flaky_br_1 #my branch 1
    addi    $t4, $t4, 0
flaky_br_1:
    nop
    nop
    nop
    nop
    nop
    beq     $t4, 0, flaky_br_2 #my branch 2
    addi    $t3, $t3, 0
flaky_br_2:
# **********************

    addi    $t1, $t1, 1
    bne     $t1, 10000, loop

    li      $v0, 10
    syscall
