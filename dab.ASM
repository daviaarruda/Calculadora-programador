.data
msg1: .asciiz "Digite um numero decimal: "
msg2: .asciiz "\nPasso: "
msg3: .asciiz " / 2 = "
msg4: .asciiz " resto "
msg5: .asciiz "\nResultado (base 2): "
msg6: .asciiz "\n\n--- Conversao para base 8 ---\n"
msg7: .asciiz "\nPasso: "
msg8: .asciiz " / 8 = "
msg9: .asciiz " resto "
msg10: .asciiz "\nResultado (base 8): "
novaLinha: .asciiz "\n"
vetor: .space 64
vetor8: .space 64

.text
main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0
    move $t1, $zero
    la $t2, vetor

loop_div2:
    beq $t0, $zero, mostra2
    li $t3, 2
    div $t0, $t3
    mfhi $t4
    mflo $t5

    li $v0, 4
    la $a0, msg2
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg3
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, msg4
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, novaLinha
    syscall

    addi $t4, $t4, 48
    sb $t4, 0($t2)
    addi $t2, $t2, 1
    addi $t1, $t1, 1
    move $t0, $t5
    j loop_div2

mostra2:
    li $v0, 4
    la $a0, msg5
    syscall
    addi $t2, $t2, -1
mostra_loop2:
    blt $t1, $zero, base8
    lb $a0, 0($t2)
    li $v0, 11
    syscall
    addi $t2, $t2, -1
    addi $t1, $t1, -1
    j mostra_loop2

base8:
    li $v0, 4
    la $a0, msg6
    syscall
    li $v0, 4
    la $a0, msg1
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    move $t1, $zero
    la $t2, vetor8

loop_div8:
    beq $t0, $zero, mostra8
    li $t3, 8
    div $t0, $t3
    mfhi $t4
    mflo $t5

    li $v0, 4
    la $a0, msg7
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg8
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, msg9
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, novaLinha
    syscall

    addi $t4, $t4, 48
    sb $t4, 0($t2)
    addi $t2, $t2, 1
    addi $t1, $t1, 1
    move $t0, $t5
    j loop_div8

mostra8:
    li $v0, 4
    la $a0, msg10
    syscall
    addi $t2, $t2, -1
mostra_loop8:
    blt $t1, $zero, fim
    lb $a0, 0($t2)
    li $v0, 11
    syscall
    addi $t2, $t2, -1
    addi $t1, $t1, -1
    j mostra_loop8

fim:
    li $v0, 10
    syscall
