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
    NUM1 DB ?
    NUM2 DB ?
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
    
;input a number
    
    MOV AH, 1
    INT 21H
    
  
           
    MOV NUM1, AL

;print user prompt----
    LEA DX, MSG2
    MOV AH, 9
    INT 21H

;input a number     
    MOV AH, 1
    INT 21H
           
    MOV NUM2, AL 
    
;print user prompt----
    LEA DX, MSG3
    MOV AH, 9
    INT 21H

;input a number     
    MOV AH, 1
    INT 21H
           
    MOV NUM3, AL
    
;comp n1 n2    
    MOV AL, NUM1    
    CMP AL, NUM2
    JE  COMP1 ;N1=N2
    JG  COMP2 ;N1>N2  
    JL  COMP4 ;N1<N2

COMP1:
    CMP AL, NUM3
    JE PRINTE
    JG PRINT3
    JL PRINT2    
    
COMP2:
    CMP AL, NUM3
    JE  PRINT2
    JG  COMP3
    JL  PRINT1    


COMP3:
    MOV AL,NUM2
    CMP AL,NUM3
    JL  PRINT3
    ;JE PRINT2 JG PRINT2
    JMP PRINT2


COMP4:
    CMP AL, NUM3
    JL  COMP5
    ;JE PRINT1 JG PRINT1
    JMP PRINT1

COMP5:
    MOV AL,NUM2
    CMP AL,NUM3
    JE  PRINT1
    JG  PRINT3
    JL  PRINT2

PRINT1:
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    
;print n1    
    MOV AH, 2
    MOV DL, NUM1
    INT 21H
    
    JMP EXIT
    

PRINT2:
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    
;print n2    
    MOV AH, 2
    MOV DL, NUM2
    INT 21H
    
    JMP EXIT
    
    
PRINT3:
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    
;print n3    
    MOV AH, 2
    MOV DL, NUM3
    INT 21H
    
    JMP EXIT
    
PRINTE:
    LEA DX, MSGE
    MOV AH, 9
    INT 21H
    
EXIT:    
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN