; ------------------------------------------------------------------
; Autor: Davi Arruda
; [06/11/2025 09:39] -> conversão didática de decimal para binário
; [10/11/2025 18:07] -> Adição da conversão para base 8
; [11/11/2025 15:23] -> Adição da conversão para base 16 
; [13/11/2025 21:25] -> Adição da conversão BCD 
; ------------------------------------------------------------------

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

msg16: .asciiz "\n\n--- Conversao para base 16 ---\n"
msg17: .asciiz "\nPasso: "
msg18: .asciiz " / 16 = "
msg19: .asciiz " resto "
msg20: .asciiz "\nResultado (base 16): "

msg_bcd: .asciiz "\n\n--- Conversao para BCD ---\n"
msg_bcd_result: .asciiz "\nResultado (BCD): "

novaLinha: .asciiz "\n"

vetor: .space 64
vetor8: .space 64
vetor16: .space 64
vetor_bcd: .space 128

hex_table: .asciiz "0123456789ABCDEF"

bcd_table:
    .asciiz "0000"   # 0
    .asciiz "0001"   # 1
    .asciiz "0010"   # 2
    .asciiz "0011"   # 3
    .asciiz "0100"   # 4
    .asciiz "0101"   # 5
    .asciiz "0110"   # 6
    .asciiz "0111"   # 7
    .asciiz "1000"   # 8
    .asciiz "1001"   # 9

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
    blt $t1, $zero, base16
    lb $a0, 0($t2)
    li $v0, 11
    syscall
    addi $t2, $t2, -1
    addi $t1, $t1, -1
    j mostra_loop8

base16:
    li $v0, 4
    la $a0, msg16
    syscall
    li $v0, 4
    la $a0, msg1
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    move $t1, $zero
    la $t2, vetor16

loop_div16:
    beq $t0, $zero, mostra16
    li $t3, 16
    div $t0, $t3
    mfhi $t4
    mflo $t5

    li $v0, 4
    la $a0, msg17
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg18
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, msg19
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, novaLinha
    syscall

    la $t6, hex_table
    add $t6, $t6, $t4
    lb $t7, 0($t6)
    sb $t7, 0($t2)

    addi $t2, $t2, 1
    addi $t1, $t1, 1
    move $t0, $t5
    j loop_div16

mostra16:
    li $v0, 4
    la $a0, msg20
    syscall
    addi $t2, $t2, -1

mostra_loop16:
    blt $t1, $zero, bcd
    lb $a0, 0($t2)
    li $v0, 11
    syscall
    addi $t2, $t2, -1
    addi $t1, $t1, -1
    j mostra_loop16

bcd:
    li $v0, 4
    la $a0, msg_bcd
    syscall

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    move $t1, $zero
    la $t2, vetor_bcd

separa_digitos:
    beq $t0, $zero, imprime_bcd
    li $t3, 10
    div $t0, $t3
    mfhi $t4
    mflo $t0

    la $t5, bcd_table
    mul $t6, $t4, 5
    add $t5, $t5, $t6

    lb $t7, 0($t5)
    sb $t7, 0($t2)
    lb $t7, 1($t5)
    sb $t7, 1($t2)
    lb $t7, 2($t5)
    sb $t7, 2($t2)
    lb $t7, 3($t5)
    sb $t7, 3($t2)
    lb $t7, 4($t5)
    sb $t7, 4($t2)

    addi $t2, $t2, 5
    addi $t1, $t1, 1
    j separa_digitos

imprime_bcd:
    li $v0, 4
    la $a0, msg_bcd_result
    syscall

    addi $t2, $t2, -5

loop_bcd_print:
    blt $t1, $zero, fim

    lb $a0, 0($t2)
    li $v0, 4
    syscall
    lb $a0, 1($t2)
    li $v0, 4
    syscall
    lb $a0, 2($t2)
    li $v0, 4
    syscall
    lb $a0, 3($t2)
    li $v0, 4
    syscall
    lb $a0, 4($t2)
    li $v0, 4
    syscall

    addi $t2, $t2, -5
    addi $t1, $t1, -1
    j loop_bcd_print

fim:
    li $v0, 10
    syscall
