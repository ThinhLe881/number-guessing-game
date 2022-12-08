; Number-guessing game

extern printf
extern scanf
extern exit
extern time
extern srand
extern rand                                 ; return to rax

global main

section .text

main:
    mov rbx, 0                              ; range

    mov rdi, titleLabel
    mov rax, 0
    push rbx
    call printf
    pop rbx

newRound:
    add rbx, 5                              ; start range (0-4)

    mov r15, [round]

    mov rdi, roundLabel
    mov rsi, r15
    mov rax, 0
    push rbx
    call printf
    pop rbx

    inc r15
    mov [round], r15

    mov r15, 4                              ; r15 = attempts, 5 attempts in total

    ; generate random number
    push 0
    call time
    add rsp, 8
    push rax
    call srand
    add rsp, 8
    call rand
    mov rdx, 0
    div rbx
    mov r14, rdx                            ; the target number is the remainder (rdx)

guess:
    mov rdi, prompt
    mov rsi, rbx
    mov rax, 0
    push rbx
    call printf
    pop rbx

    mov rdi, inputFormat
    mov rsi, input
    mov rax, 0
    push rbx
    call scanf
    pop rbx

    cmp r14, [input]
    je right

    cmp r15, 0
    je outOfGuess

    cmp r14, [input]
    jl wrongDown

wrongUp:
    mov rdi, wrongMesUp
    mov rsi, r15
    mov rax, 0
    push rbx
    call printf
    pop rbx

    jmp nextGuess

wrongDown:
    mov rdi, wrongMesDown
    mov rsi, r15
    mov rax, 0
    push rbx
    call printf
    pop rbx

nextGuess:
    dec r15
    jmp guess

right:
    mov rdi, rightMes
    mov rsi, r14
    mov rax, 0
    push rbx
    call printf
    pop rbx

    inc r15
    jmp newRound

outOfGuess:
    mov rdi, loseMes
    mov rax, 0
    push rbx
    call printf
    pop rbx

end:
    mov rdi, endMes
    mov rax, 0
    push rbx
    call printf
    pop rbx

    ; exit(0)
    mov rax, 0
    call exit

section .data
    titleLabel db "Welcome to Guess That Number!", 0ah, 0dh, 0ah, 0dh, 0
    roundLabel db "Round: %d", 0ah, 0dh, 0

    prompt db "Guess a number less than %d: ", 0
    inputFormat db "%d", 0

    rightMes db "Correct! The number is %d", 0ah, 0dh, 0ah, 0dh, 0
    wrongMesUp db "Incorrect! Try a larger number (%d tries remaining)", 0ah, 0dh, 0
    wrongMesDown db "Incorrect! Try a smaller number (%d tries remaining)", 0ah, 0dh, 0

    loseMes db "Incorrect! Out of guesses :(", 0ah ,0dh, 0ah, 0dh, 0
    endMes db "Game Over!!!", 0ah, 0dh, 0

    input dq 0
    round dq 1                              ; first round
