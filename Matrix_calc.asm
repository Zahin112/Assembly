.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER 1st MATRIX:',CR,LF, '$'  
    MSG2 DB CR, LF, 'ENTER 2nd MATRIX:',CR,LF, '$'
    MSGR DB CR, LF, 'THE RESULT IS: ',CR,LF, '$' 
    
    MAT1 DB 4  DUP ('$')
    MAT2 DB 4  DUP ('$')
    RES  DB 10 DUP ('$');for result's dec form
     

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt----
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
;take mat1  
    MOV CX, 4
    LEA SI, MAT1
    
    INP:
    MOV DL, 32   ;SPACE
    MOV AH, 2
    INT 21H 
    MOV AH, 1
    INT 21H
    
    MOV [SI],AL
    INC SI
    
    CMP CX, 3 ;NEW LINE
    JNE S1
    MOV DL, 13
    MOV AH, 2
    INT 21H
    MOV DL, 10
    MOV AH, 2
    INT 21H
    S1:
    ;DEC CX
    LOOP INP
        
;print user prompt----
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
;take mat2
    MOV CX, 4
    LEA SI, MAT2
    
    INP1:
    MOV DL, 32
    MOV AH, 2
    INT 21H 
    MOV AH, 1
    INT 21H
    
    MOV [SI],AL
    INC SI
    
    CMP CX, 3 ;NEW LINE
    JNE S2
    MOV DL, 13
    MOV AH, 2
    INT 21H
    MOV DL, 10
    MOV AH, 2
    INT 21H
    S2:
    ;DEC CX
    LOOP INP1
  


    ;MOV NUM2, AX
    LEA DX, MSGR
    MOV AH, 9
    INT 21H

ADDN:
    MOV CL, 4             
    LEA SI, MAT1              
    LEA DI, MAT2              

;Matrix Adiition Part
    L1:
    MOV AL,[SI]
    SUB AL, 30H
    MOV BL,[DI]
    SUB BL, 30H
    ADD AL, BL              ; Add the Matrices
    
    MOV [SI],AL                                  
                            ;DAA-Adjust the Result to show Decimal Value
    
    
    ;PUSH AX                ; Push the result for storing Operations, Since both SI and DI is used
    INC SI
    INC DI
    LOOP L1
    
    LEA DI, MAT1
    MOV CX, 4
    
    JMP PRINT
    
        
    
PRINT:
     
    MOV AX ,[DI]
    MOV AH, 0
    ;MOV RES, BL
    
    ;MOV AX, 
    LEA SI, RES ;move the res pointer to source index
    CALL HEX2DEC
        
    LEA DX,RES
    MOV AH,9
    INT 21H
    
    MOV DL, 32
    MOV AH, 2
    INT 21H
    
    INC DI
    
    CMP CX, 3 ;NEW LINE
    JNE SKP
    MOV DL, 13
    MOV AH, 2
    INT 21H
    MOV DL, 10
    MOV AH, 2
    INT 21H
    SKP:
    LOOP PRINT
     
;END PRINT  
        
    JMP EXIT

    
EXIT:    
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP 




HEX2DEC PROC NEAR
    PUSH CX
    
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
       
       POP CX
       RET
HEX2DEC ENDP       
    
  




END MAIN