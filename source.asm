; TEAM markoboquiñechainajesu

; ESTE CÓDIGO REALIZA UNA ANIMACION SIMPLE Y REALIZA UNA PREGUNTA

; 14 / 03 / 2025 - V. 1. 0. 0 - PROGRAMACION EN ENSAMBLADOR

    JMP boot

stackTop    EQU 0xFF    ; Inicializa SP
txtDisplay  EQU 0x2E0

txtIntro:   DB "Esto es una animacion simple"  ; Mensaje inicial
            DB 0

txtClear:   DB "                                "  ; Mensaje para limpiar pantalla (32 espacios)
            DB 0

txtSmile:   DB ":)"  ; Primera fase de la animación
            DB 0

txtNeutral: DB ":|"  ; Segunda fase de la animación
            DB 0

txtSad:     DB ":("  ; Tercera fase de la animación
            DB 0

txtEnd:     DB "le gusto la animacion?"  ; Mensaje final
            DB 0

boot:
    MOV SP, stackTop    ; Configurar SP
    MOV C, txtIntro     ; Apuntar C a "Esto es una animacion simple"
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print

    CALL espera_larga     ; Esperar un poco

    MOV C, txtClear     ; Apuntar C a los espacios en blanco
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print          ; Limpiar pantalla

    MOV C, txtSmile     ; Apuntar C a ":)"
    MOV D, txtDisplay
    CALL print
    CALL espera_corta    ; Pequeña pausa

    MOV C, txtNeutral   ; Apuntar C a ":|"
    MOV D, txtDisplay
    CALL print
    CALL espera_corta    ; Pequeña pausa

    MOV C, txtSad       ; Apuntar C a ":("
    MOV D, txtDisplay
    CALL print
    CALL espera_larga     ; Pausa más larga

    MOV C, txtEnd       ; Apuntar C a "le gusto la animacion?"
    MOV D, txtDisplay
    CALL print

    HLT                 ; Detener ejecución

print:                  ; Imprimir cadena
    PUSH A
    PUSH B
    MOV B, 0
.loop:
    MOVB AL, [C]        ; Obtener carácter
    MOVB [D], AL        ; Escribir en la salida
    INC C
    INC D
    CMPB BL, [C]        ; Verificar si es el terminador
    JNZ .loop           ; Repetir si no lo es

    POP B
    POP A
    RET

espera_corta:            ; Rutina de espera corto
    PUSH A
    MOV A, 0x50
    CALL esperar
    RET

espera_larga:             ; Rutina de espera larga
    PUSH A
    MOV A, 0xFF
    CALL esperar
    RET
    
esperar:
    DEC A
    JNZ esperar
    POP A
    RET
