; TEAM markoboquiñechainajesu

; ESTE CÓDIGO REALIZA UNA IMPRESION DEL MENSAJE "HOLA MUNDO" Y LUEGO DE UNA PAUSA IMPRIME EL MENSAJE "ADIOS MUNDO"

; 14 / 03 / 2025 - V. 2. 0. 0 - PROGRAMACION EN ENSAMBLADOR

	 JMP boot

stackTop    EQU 0xFF    ; Inicializa SP
txtDisplay  EQU 0x2E0

txtHola:    DB "Hola Mundo!"    ; Primera salida
            DB 0                ; Terminador de cadena

txtAdios:   DB "Adios Mundo!"   ; Segunda salida
            DB 0                ; Terminador de cadena

boot:
    MOV SP, stackTop    ; Configurar SP
    MOV C, txtHola      ; Apuntar C a "Hola Mundo!"
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print

    CALL delay          ; Esperar un momento

    MOV C, txtAdios     ; Apuntar C a "Adios Mundo!"
    MOV D, txtDisplay   ; Apuntar D a la salida
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

delay:                  ; Rutina de retardo
    PUSH A
    MOV A, 0xFF
.esperar:
    DEC A
    JNZ .wait
    POP A
    RET
