.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER A NUMBER: $'  
    
    NUM  DW 0
    RES  DB 10 DUP ('$');for result's dec form

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt----
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
;take num  
    CALL INP
    MOV NUM, DX
    
    MOV DL, 10
    MOV AH, 2
    INT 21H
    
    MOV BX, 1
PRNT:    
    
    CMP BX, NUM
    JG EXIT
    MOV AX,0
    PUSH BX
    CALL FIBO   ;--------------
	
	LEA SI,RES  ;AX has the fibo value
    CALL HEX2DEC
        
    LEA DX,RES
    MOV AH,9
    INT 21H 
	    
	MOV DL, 32
    MOV AH, 2
    INT 21H
	
	INC BX
	JMP PRNT
	

EXIT:    
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

HEX2DEC PROC NEAR
    PUSH BX
    PUSH CX
    PUSH AX
    MOV CX,0
    MOV BX,10
   
LOOP1: MOV DX,0
       DIV BX
       ADD DL,30H
       PUSH DX
       INC CX
       CMP AX,9
       JG LOOP1
     
       ADD AL,30H
       MOV [SI],AL
     
LOOP2: POP AX
       INC SI
       MOV [SI],AL
       LOOP LOOP2
       POP AX
       POP CX
       POP BX
       RET
HEX2DEC ENDP       

FIBO PROC NEAR
		
		PUSH BP
		MOV BP, SP
		
		CMP WORD PTR[BP+4],1
		JG  NXT
		ADD AX, 0
		JMP RTN
		NXT:
		CMP WORD PTR[BP+4],2
		JG  END_IF
		ADD AX, 1
		JMP RTN
		 
END_IF:	
        MOV	CX, [BP+4]
		DEC CX
		PUSH CX
		CALL FIBO 
        MOV	CX, [BP+4]
		SUB CX, 2
		PUSH CX
		CALL FIBO
		
RTN:	
        POP	BP
		RET	2
FIBO ENDP    

INP PROC NEAR
    
    PUSH AX
    PUSH BX
    
    MOV DX, 0
    MOV NUM, 0
   
  TAKE:    
    MOV AH, 1
    INT 21H
    
              
    MOV BL, AL
    
    CMP BX, 21H
    JL  END
    CMP BX, 7EH
    JG  END
    CMP BX, 30H
    JL TAKE
    CMP BX, 39H
    JG TAKE
    
    SUB BL, 30H
    MOV DX, NUM
    MOV AX, 10
    MUL NUM
    ADD AX, BX
    MOV NUM, AX
    MOV DX, NUM
    JMP TAKE 
        
END:    
    POP BX
    POP AX
    
    RET
    
INP ENDP  




END MAIN