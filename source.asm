; TEAM markoboquiñechainajesu

; ESTE CÓDIGO REALIZA UNA IMPRESION DE UN MENSAJE, LUEGO UNA ANIMACION SIMPLE Y AL FINAL OTRO MENSAJE.

; 14 / 03 / 2025 - V. 3. 0. 0 - PROGRAMACION EN ENSAMBLADOR

    JMP boot

stackTop    EQU 0xFF    ; Inicializa SP
txtDisplay  EQU 0x2E0    ;Dirección de la pantalla o buffer de salida

txtIntro:   DB "Esto es una animacion simple"  ; Mensaje inicial
            DB 0    ;Terminador de cadena

txtClear:   DB "                                "  ; Mensaje para limpiar pantalla (32 espacios)
            DB 0                                    ;Terminador de cadena

txtSmile:   DB ":)"  ; Primera fase de la animación
            DB 0      ;Terminador de cadena

txtNeutral: DB ":|"  ; Segunda fase de la animación
            DB 0        ;Terminador de cadena

txtSad:     DB ":("  ; Tercera fase de la animación
            DB 0        ;Terminador de cadena

txtEnd:     DB "le gusto la animacion?"  ; Mensaje final
            DB 0        ;Terminador de cadena

boot:
    MOV SP, stackTop    ; Configurar SP
    MOV C, txtIntro     ; Apuntar C a "Esto es una animacion simple"
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print          ;llama a la accion print

    CALL espera_larga     ; Esperar un poco

    MOV C, txtClear     ; Apuntar C a los espacios en blanco
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print          ; Limpiar pantalla

    MOV C, txtSmile     ; Apuntar C a ":)" Cargar la primera fase de la animación
    MOV D, txtDisplay    ; Apuntar D a la salida
    CALL print            ;Imprimir la carita sonriente
    CALL espera_corta    ; Pequeña pausa

    MOV C, txtNeutral   ; Apuntar C a ":|" Cargar la segunda fase de la animación
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print            ;Imprimir la carita neutral
    CALL espera_corta    ; Pequeña pausa

    MOV C, txtSad       ; Apuntar C a ":(" Cargar la tercera fase de la animación
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print        ;Imprimir la carita triste
    CALL espera_larga     ; Pausa más larga

    MOV C, txtEnd       ; Apuntar C a "le gusto la animacion?"
    MOV D, txtDisplay   ; Apuntar D a la salida
    CALL print           ;Imprimir la carita triste

    HLT                 ; Detener ejecución

print:                  ; Imprimir cadena
    PUSH A              ; Guardar valor de A en la pila
    PUSH B              ; Guardar valor de B en la pila
    MOV B, 0           ;Mueve el valor 0 al registro B.
.loop:
    MOVB AL, [C]        ; Obtener carácter
    MOVB [D], AL        ; Escribir en la salida
    INC C               ; Apuntar al siguiente carácter
    INC D               ; Avanzar en la pantalla
    CMPB BL, [C]        ; Verificar si es el terminador
    JNZ .loop           ; Repetir si no lo es

    POP B               ;Extrae el valor en la cima de la pila y lo almacena en el registro B.
    POP A               ;Extrae el valor en la cima de la pila y lo almacena en el registro A.
    RET                 ;Retorna de la subrutina, tomando la dirección de retorno de la pila

espera_corta:            ; Rutina de espera corto
    PUSH A               ; Guardar valor de A en la pila
    MOV A, 0x50          ;Carga el valor 0x50 (80 en decimal) en el registro A.
    CALL esperar        ; Pausa 
    RET                ; ;Retorna de la subrutina, tomando la dirección de retorno de la pila

espera_larga:             ; Rutina de espera larga
    PUSH A               ; Guardar valor de A en la pila
    MOV A, 0xFF          ; Carga el valor 0xFF (255 en decimal) en el registro A
    CALL esperar         ;pausa 
    RET                ; ;Retorna de la subrutina, tomando la dirección de retorno de la pila
    
esperar:
    DEC A              ; Decrementa el valor del registro A en 1.
    JNZ esperar        ; Saltar si no es cero a espera
    POP A              ;Extrae el valor en la cima de la pila y lo almacena en el registro A.
    RET                ; ;Retorna de la subrutina, tomando la dirección de retorno de la pila
