.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER 1st NUMBER: $'  
    MSG2 DB CR, LF, 'ENTER 2nd NUMBER: $'
    MSGO DB CR, LF, 'ENTER OPERATOR: $'
    MSGR DB CR, LF, 'THE RESULT IS: $' 
    MSGW DB CR, LF, 'WRONG OPERATOR. $'
    MSGQ DB CR, LF, 'QUOTIENT IS :  $'
    MSGM DB CR, LF, 'REMAINDER IS:  $'
    NUM1 DW 0
    NUM2 DW 0
    NUM  DW 0
    OP   DB ?
    RES  DB 10 DUP ('$');for result's dec form
    REM  DW ?
    NG   DB 0
    NG1   DB 0
    NG2   DB 0 

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt----
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
;take num1  
    CALL INP
    MOV NUM1, DX
    CMP NG, 0
    JE  SKP
    NEG NUM1
    MOV NG1, 1
    MOV NG, 0

SKP:    
    LEA DX, MSGO
    MOV AH, 9
    INT 21H
    
;take operand
    MOV AH, 1
    INT 21H
    MOV OP, AL    
    
    CMP OP, 71H
    JE  EXIT
    
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;take num2
    CALL INP
    
   
    MOV NUM2, DX
    CMP NG, 0
    JE  SKP1
    NEG NUM2
    MOV NG2, 1
    MOV NG, 0
SKP1:    
     
    MOV AX, NUM1

    CMP OP, 2BH
    JE  ADDN
    CMP OP, 2DH
    JE  SUBN
    CMP OP, 2AH
    JE  MULN
    CMP OP, 2FH
    JE  DIVN
    JMP WRONG

ADDN:
    ADD AX, NUM2
    ;MOV NUM2, AX
    JMP PRINT
SUBN:
    SUB AX, NUM2
    ;MOV NUM2, AX
    JMP PRINT
MULN:
    MUL NUM2
    ;MOV NUM2, AX
    JMP PRINT
DIVN:       
    ;MOV AX, NUM2
    CMP NG1, 1
    JNE SK1
    NEG NUM1
    INC NG
SK1:
    CMP NG2, 1
    JNE SK2
    NEG NUM2
    INC NG
SK2:
    ;MOV BX, NUM1
    ;MOV CX, NUM2
    MOV AX, NUM1
    MOV DX, 0;dx NUM2 thake
    DIV NUM2
    MOV REM, DX
    
    MOV NUM2, AX
    LEA SI,RES
    CALL HEX2DEC
    
    LEA DX, MSGQ
    MOV AH, 9
    INT 21H
    
    CMP NG, 1
    JNE SK3
    MOV DX, 2DH
    MOV AH,2
    INT 21H
      
SK3:
    LEA DX,RES
    MOV AH,9
    INT 21H 
    
    MOV AX, REM
    LEA SI,RES
    CALL HEX2DEC
    LEA DX, MSGM
    MOV AH, 9
    INT 21H
    LEA DX,RES
    MOV AH,9
    INT 21H
    JMP EXIT
    
PRINT:
    MOV NUM2, AX
    LEA DX, MSGR
    MOV AH, 9
    INT 21H 
    
         
    
;PRINT THE DEC FORM
    MOV AX ,NUM2    
    
    ROL AX ,01 ; rotate left 01 
    JNC  SKP3  ; jumo not carry=1
    
    NEG NUM2
    
    MOV DX, 2DH
    MOV AH,2
    INT 21H 
SKP3:
    
    MOV AX,NUM2  
    
    LEA SI,RES;move the res pointer to source index
    CALL HEX2DEC
        
    LEA DX,RES
    MOV AH,9
    INT 21H 
;END PRINT  
        
    JMP EXIT

WRONG:
    LEA DX, MSGW
    MOV AH, 9
    INT 21H
    
EXIT:    
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

HEX2DEC PROC NEAR
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
       RET
HEX2DEC ENDP       
    
    
INP PROC NEAR
    
    PUSH AX
    PUSH BX
    MOV DX, 0
    MOV NUM, 0
   
  TAKE:    
    MOV AH, 1
    INT 21H
    CMP AL, 2DH
    JE  NT
              
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
    
NT: MOV NG, 1
    JMP TAKE    
    
END:    
    POP BX
    POP AX
    
    RET
    
INP ENDP  




END MAIN