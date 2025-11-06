.data
msg1: .asciiz "Digite um numero decimal: "
msg2: .asciiz "\nPasso: "
msg3: .asciiz " / 2 = "
msg4: .asciiz " resto "
msg5: .asciiz "\nResultado (base 2): "
novaLinha: .asciiz "\n"
vetor: .space 64

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

loop_div:
    beq $t0, $zero, mostra
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
    j loop_div

mostra:
    li $v0, 4
    la $a0, msg5
    syscall

    addi $t2, $t2, -1

mostra_loop:
    blt $t1, $zero, fim
    lb $a0, 0($t2)
    li $v0, 11
    syscall
    addi $t2, $t2, -1
    addi $t1, $t1, -1
    j mostra_loop

fim:
    li $v0, 10
    syscall
