.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER X: $'
    MSG2 DB CR, LF, 'PREVIOUS LOWERCASE IS: $'
    MSG3 DB CR, LF, '1s COMPLEMENT IS: $'
    CHAR DB ?

.CODE

MAIN PROC
;initialize
    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

;input a upper case character     
    MOV AH, 1
    INT 21H
    
;Get the lower format    
    ADD AL, 1FH
    MOV CHAR, AL
    
;display
    LEA DX, MSG2
    MOV AH, 9
    INT 21H  
    
;display the lower case character  
    MOV AH, 2
    MOV DL, CHAR
    INT 21H
    
;1s COMPLEMENT
    SUB CHAR, 1FH
    ;NOT
    NEG CHAR
    SUB CHAR, 1        
    
    
;display result
    LEA DX, MSG3
    MOV AH, 9
    INT 21H  
    
;display the lower case character  
    MOV AH, 2
    MOV DL, CHAR
    INT 21H
    
    
;DOX exit
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN