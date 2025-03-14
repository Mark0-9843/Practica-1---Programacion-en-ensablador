# TEAM markoboquiñechainajesu

# ESTE CÓDIGO REALIZA

# 14 / 03 / 2025 - V. 1. 0. 0 - PROGRAMACION EN ENSAMBLADOR

	JMP boot

stackTop    EQU 0xFF    ; Initial SP
txtDisplay  EQU 0x2E0

hello:	DB "Hello World!"	; Output string
		DB 0				; String terminator

boot:
	MOV SP, stackTop	; Set SP
	MOV C, hello		; Point register C to string
	MOV D, txtDisplay	; Point register D to output
	CALL print
	HLT				; Halt execution

print:				; Print string
	PUSH A
	PUSH B
	MOV B, 0
.loop:
	MOVB AL, [C]	; Get character
	MOVB [D], AL	; Write to output
	INC C
	INC D
	CMPB BL, [C]	; Check if string terminator
	JNZ .loop		; Jump back to loop if not

	POP B
	POP A
	RET
