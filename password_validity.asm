.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER PASSWORD: $'
    MSGV DB CR, LF, 'VALID PASSWORD $'  
    MSGI DB CR, LF, 'INVALID PASSWORD $'
    
    U  DB 0
    L  DB 0
    D  DB 0
    

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt for X
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    

;input password

INPUT:     
    MOV AH, 1
    INT 21H
    
    CMP AL, 21H
    JL  PRINT
    CMP AL, 7EH
    JG  PRINT

;digit check----------
CHKD: 
    CMP AL, 30H
    JL  INPUT
    CMP AL, 39H
    JG  CHKDU
    CMP D, 1
    JE  INPUT
    MOV D,  1
    JMP INPUT 
    ;MOV X, AL    
        
;upper case check-----
CHKDU:
    CMP AL, 41H
    JL  INPUT
    CMP AL, 5AH
    JG  CHKL
    CMP U,  1
    JE  INPUT
    MOV U,  1
    JMP INPUT 
    ;MOV X, AL
    
;lower case check-----
CHKL:
    CMP AL, 61H
    JL  INPUT
    CMP AL, 7AH
    JG  INPUT
    CMP L, 1
    JE  INPUT
    MOV L,  1
    JMP INPUT 
    ;MOV X, AL    


;calc+print result 
PRINT:
    MOV AL, U
    ADD AL, L
    ADD AL, D
    CMP AL, 3
    
    ;MOV AH, 2
    ;MOV DL, U
    ;INT 21H
    JE  PRINTV
    LEA DX, MSGI
    MOV AH, 9
    INT 21H
    JMP EXIT    
    
PRINTV:
    LEA DX, MSGV
    MOV AH, 9
    INT 21H  
    
 
;DOX exit
EXIT:
    
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN