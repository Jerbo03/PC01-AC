org 100h

; set video mode    
mov ax, 3     ; text mode 80x25, 16 colors, 8 pages (ah=0, al=3)
int 10h       ; do it!

; cancel blinking and enable all 16 colors:
mov ax, 1003h
mov bx, 0
int 10h


; set segment register:
mov     ax, 0b800h
mov     ds, ax

; color all characters: 
; 80 columnas
; 25 filas

mov di, 00h ; start from first char


; Primera linea
mov [di], 11001001b               
add di, 1
mov [di], 11111100b
add di, 1
  
mov cx, 78  ; number of characters
  
a:   
    mov [di], 11001101b              
    add di, 1
    mov [di], 11111100b                
    add di, 1 ; skip over next ascii code in vga memory.
    loop a

mov [di], 10111011b               
add di, 1
mov [di], 11111100b
add di, 1

; 9 lineas vacias
mov  dx, 9

b1:

mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 78  ; number of characters
  
b2:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop b2

dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  b1

; 2 lineas vacias con una raya amarilla en medio
mov  dx, 2

c1:

mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 26  ; number of characters
  
c2:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop c2

mov cx, 26  ; number of characters
  
c3:   
    mov [di], 11101100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop c3
    
mov cx, 26  ; number of characters
  
c4:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop c4
        
dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  c1


; linea con mi nombre
mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 26  ; number of characters
  
d1:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop d1
  
dec di
  
; 26 chars para mi nombre
mov dx, di ; Guardamos la posicion inicial

mov [di], 'P'                
add di, 2
mov [di], 'A'                
add di, 2
mov [di], 'R'                
add di, 2
mov [di], 'E'                
add di, 2
mov [di], 'D'                
add di, 2
mov [di], 'E'                
add di, 2
mov [di], 'S'                
add di, 2
mov [di], ' '                
add di, 2 
mov [di], 'Q'                
add di, 2
mov [di], 'U'                
add di, 2
mov [di], 'I'                
add di, 2
mov [di], 'S'                
add di, 2
mov [di], 'P'                
add di, 2  
mov [di], 'E'                
add di, 2
mov [di], ' '
add di, 2
mov [di], ' '                
add di, 2
mov [di], 'J'                
add di, 2
mov [di], 'O'                
add di, 2
mov [di], 'S'                
add di, 2
mov [di], 'E'                
add di, 2
mov [di], ' '                
add di, 2 
mov [di], 'A'                
add di, 2
mov [di], 'N'                
add di, 2
mov [di], 'D'                
add di, 2
mov [di], 'R'                
add di, 2
mov [di], 'E'                
add di, 2

mov di, dx ; Recuperamos el primer indice
add di, 1
mov cx, 26

d2: 
    mov [di], 11101100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop d2
    
mov cx, 26  ; number of characters
  
d3:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop d3

dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

; 2 lineas vacias con una raya amarilla en medio
mov  dx, 2

e1:

mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 26  ; number of characters
  
e2:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop e2

mov cx, 26  ; number of characters
  
e3:   
    mov [di], 11101100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop e3
    
mov cx, 26  ; number of characters
  
e4:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop e4
        
dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  e1

; 9 lineas vacias
mov  dx, 9

f1:

mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 78  ; number of characters
  
f2:   
    mov [di], 11111100b                
    add di, 2 ; skip over next ascii code in vga memory.
    loop f2

dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  f1

; Ultima linea
mov [di], 11001000b              
add di, 1
mov [di], 11111100b
add di, 1
  
mov cx, 78  ; number of characters
  
g:   
    mov [di], 11001101b              
    add di, 1
    mov [di], 11111100b                
    add di, 1 ; skip over next ascii code in vga memory.
    loop g

mov [di], 10111100b               
add di, 1
mov [di], 11111100b
add di, 1
    
;; wait for any key press:
;mov ah, 0
;int 16h

ret

      
      