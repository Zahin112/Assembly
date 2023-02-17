.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    
    MSG1 DB 'ENTER X: $'
    MSG2 DB CR, LF, 'ENTER Y: $'  
    RES1 DB CR, LF, 'X - 2Y = $'
    RES2 DB CR, LF, '25 - (X + Y) = $'
    RES3 DB CR, LF, '2X - 3Y = $'
    RES4 DB CR, LF, 'Y - X + 1= $'
    X  DB ?
    Y  DB ?
    Z  DB ?

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt for X
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    

;input a digit     
    MOV AH, 1
    INT 21H
    
    MOV X, AL
    ;MOV X, AX
    SUB X, 30H
    
;print user prompt for Y
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    

;input a digit     
    MOV AH, 1
    INT 21H
    
    MOV Y, AL
    ;MOV Y,AX
    SUB Y, 30H
       
;Get the RES1:    
    MOV AL, X
    SUB AL, Y
    SUB AL, Y
    MOV Z, AL
    ADD Z, 30H
    
    
;display on the next line
    LEA DX, RES1
    MOV AH, 9
    INT 21H  
    
;display the result  
    MOV AH, 2
    MOV DL, Z
    INT 21H
    
;-------------------------------------------
;Get the RES2:
    MOV AL, X
    ADD AL, Y
    NEG AL
    ADD AL, 25
    ADD AL, 30H
    MOV Z, AL
      
    
;display on the next line
    LEA DX, RES2
    MOV AH, 9
    INT 21H  
    
;display the result  
    MOV AH, 2
    MOV DL, Z
    INT 21H


;-------------------------------------------          
;Get the RES3:
    MOV AL, X
    ADD AL, X
    SUB AL, Y
    SUB AL, Y
    SUB AL, Y
    ADD AL, 30H
    MOV Z, AL
         
    
;display on the next line
    LEA DX, RES3
    MOV AH, 9
    INT 21H  
    
;display the  result 
    MOV AH, 2
    MOV DL, Z
    INT 21H


;------------------------------------------- 
;Get the RES4:
    MOV AL, Y
    SUB AL, X
    ADD AL, 1
    MOV Z, AL
    ADD Z, 30H
    
    
;display on the next line
    LEA DX, RES4
    MOV AH, 9
    INT 21H  
    
;display the result  
    MOV AH, 2
    MOV DL, Z
    INT 21H
     
 
;DOX exit
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN