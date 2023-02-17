.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER 1st NUMBER: $'  
    MSG2 DB CR, LF, 'ENTER 2nd NUMBER: $'
    MSG3 DB CR, LF, 'ENTER 3rd NUMBER: $'
    MSG4 DB CR, LF, '2nd HIGHEST NUMBER IS: $' 
    MSGE DB CR, LF, 'ALL NUMBERS ARE EQUAL. $'
    NUM1 DW 0
    NUM2 DW 0
    NUM3 DB ?
    ;BUFR DB ?
    ;EQL  DB ?

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt----
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
  
    CALL INP
    MOV NUM2, DX
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    CALL INP
    
    ADD NUM2, DX
    ;ADD NUM2, 30H
    ;MOV NUM2, DX 
    MOV DX, NUM2
    
PRINT:
    LEA DX, MSG2
    MOV AH, 9
    INT 21H 
    
    ;MOV AH, 9
    ;NEG NUM1
    MOV DX, NUM2
    MOV AH, 9
    INT 10H
    
    JMP EXIT


    
EXIT:    
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

      
    
    
INP PROC NEAR
    
    PUSH AX
    PUSH BX
    MOV DX, 0
    MOV NUM1, 0
   
  TAKE:    
    MOV AH, 1
    INT 21H
    
    
    MOV BL, AL
    ;SUB BL, 30H
    ;CBW
    CMP BX, 21H
    JL  END
    CMP BX, 7EH
    JG  END
    CMP BX, 30H
    JL TAKE
    CMP BX, 39H
    JG TAKE
    
    SUB BL, 30H
    MOV DX, NUM1
    MOV AX, 10
    MUL NUM1
    ADD AX, BX
    MOV NUM1, AX
    MOV DX, NUM1
    JMP TAKE 
    
    
    
END:    
    POP BX
    POP AX
    
    RET
    
INP ENDP  

INP2 PROC NEAR
    
    PUSH AX
    PUSH BX
    MOV DX, 0
   
  TAKE2:    
    MOV AH, 1
    INT 21H
    
    
    MOV BL, AL
    ;SUB BL, 30H
    ;CBW
    CMP BX, 21H
    JL  END
    CMP BX, 7EH
    JG  END
    CMP BX, 30H
    JL TAKE
    CMP BX, 39H
    JG TAKE
    
    SUB BL, 30H
    MOV Dl, NUM3
    MOV AX, 10
    MUL NUM1
    ADD AX, BX
    MOV NUM1, AX
    MOV DX, NUM1
    JMP TAKE2 
    
    
    
END2:    
    POP BX
    POP AX
    
    RET
    
INP2 ENDP

END MAIN