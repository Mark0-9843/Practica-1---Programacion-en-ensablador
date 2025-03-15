; TEAM markoboquiñechainajesu

; ESTE CÓDIGO REALIZA UNA IMPRESION DEL MENSAJE "HOLA MUNDO" Y LUEGO DE UNA PAUSA IMPRIME EL MENSAJE "ADIOS MUNDO"

; 14 / 03 / 2025 - V. 2. 0. 0 - PROGRAMACION EN ENSAMBLADOR

	 JMP boot

stackTop    EQU 0xFF    ; Inicializa SP
txtDisplay  EQU 0x2E0	; Dirección de la salida de texto

txtHola:    DB "Hola Mundo!"    ; Primera salida
            DB 0                ; Terminador de cadena

txtAdios:   DB "Adios Mundo!"   ; Segunda salida
            DB 0                ; Terminador de cadena

boot:
    MOV SP, stackTop    ; Configurar SP
    MOV C, txtHola      ; Apuntar C a "Hola Mundo!"
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print		; llama a la rutina de impresión

    CALL delay          ; Esperar un momento

    MOV C, txtAdios     ; Apuntar C a "Adios Mundo!"
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print		;llama a la rutina de impresión

    HLT                 ; Detener ejecución

print:                  ; Imprimir cadena
    PUSH A		;Guarda el valor de A en la pila
    PUSH B		;Guarda el valor de B en la pila
    MOV B, 0		;Iniializa B en 0 para comparación
.loop:
    MOVB AL, [C]        ; Obtener carácter
    MOVB [D], AL        ; Escribir en la salida
    INC C		;Mover al siguiente carácter en la cadena
    INC D		;Mover a la siguiente posición en la salida
    CMPB BL, [C]        ; Verificar si es el terminador
    JNZ .loop           ; Repetir si no lo es

    POP B		;Restaurar el valor original de B desde la pila
    POP A		;Restaurar el valor original de A desde la pila
    RET			;Retornar desde la subrutina

delay:                  ; Rutina de retardo
    PUSH A		; Guardar el valor de A en la pila
    MOV A, 0xFF		;Inicializar A con 0xFF
.esperar:
    DEC A		;Decrementar A
    JNZ .wait		;Si A no es cero, continuar en el bucle
    POP A		;Restarurar el valor original de A desde la pila
    RET			;Retornar desde la subrutina
