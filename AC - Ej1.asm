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

; Datos de la pantalla 
; 80 columnas (chars)
; 25 filas    (chars)

mov di, 00h ; Empezar desde el primer char en pantalla


; Primera linea
mov [di], 11001001b  ; Simbolo de la esquina del marco             
add di, 1            ; Cambiar de char a estilo en la memoria VGA
mov [di], 11111100b  ; Fondo blanco (1111) char rojo claro (1100)
add di, 1            ; Cambiar de estilo a char en la memoria VGA
  
mov cx, 78  ; Si son 80 chars por fila y 2, de los extremos, son reservador para esquinas
            ; del marco se rellenan los otros 78 con caracteres de char borde de marco
  
a:   
    mov [di], 11001101b  ; Simbolo del marco            
    add di, 1            ; Cambiar de char a estilo en la memoria VGA
    mov [di], 11111100b  ; Fondo blanco (1111) char rojo claro (1100)              
    add di, 1            ; Cambiar de estilo a char en la memoria VGA
    loop a

mov [di], 10111011b  ; Simbolo de la esquina del marco             
add di, 1            ; Cambiar de char a estilo en la memoria VGA
mov [di], 11111100b  ; Fondo blanco (1111) char rojo claro (1100)
add di, 1            ; Cambiar de estilo a char en la memoria VGA

; 9 lineas vacias: bucle anidado
mov  dx, 9  ; Se itinera por 9 lineas

b1:
    mov [di], 10111010b  ; Simbolo del borde del marco            
    add di, 1
    mov [di], 11111100b  ; Fondo blanco (1111) char rojo claro (1100)
    add di, 2            ; Cambiar de estilo del anterior char a estilo del siguiente char
                         ; en la memoria VGA, porque no hay caracteres en medio
      
    mov cx, 78  ; numero de espacios en blanco
      
    b2:   
        mov [di], 11111100b ; Fondo blanco (1111) char rojo claro (1100)               
        add di, 2        ; Cambiar de estilo del anterior char a estilo del siguiente char
        loop b2
    
    dec di
    mov [di], 10111010b  ; Simbolo del borde del marco             
    add di, 1
    mov [di], 11111100b  ; Fondo blanco (1111) char rojo claro (1100)
    add di, 1

dec  dx
jnz  b1

; 2 lineas vacias con una raya amarilla en medio: bucles anidados
mov  dx, 2  ; itinerar por 2 lineas

c1:

mov [di], 10111010b  ; Simbolo del borde del marco            
add di, 1
mov [di], 11111100b  ; Fondo blanco (1111) char rojo claro (1100)
add di, 2
  
mov cx, 26  ; numero de caracteres en blanco
  
c2:   
    mov [di], 11111100b                
    add di, 2
    loop c2

mov cx, 26  ; numero de caracteres en amarillo
  
c3:   
    mov [di], 11101100b                
    add di, 2
    loop c3
    
mov cx, 26  ; numero de caracteres en blanco
  
c4:   
    mov [di], 11111100b                
    add di, 2
    loop c4
        
dec di
mov [di], 10111010b  ; Simbolo del borde del marco             
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  c1


; linea con mi nombre
mov [di], 10111010b  ; Simbolo del borde del marco            
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 26  ; numero de caracteres en blanco
  
d1:   
    mov [di], 11111100b                
    add di, 2
    loop d1
  
dec di
  
; 26 chars para mi nombre
mov dx, di ; Guardamos la posicion inicial

mov [di], 'P'                
add di, 2 ; salto al siguiente caracter en la memoria VGA
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

; 26 chars para mi nombre, ahora le damos formato
mov cx, 26

d2: 
    mov [di], 11101100b  ; Fondo amarillo (1110) char rojo claro (1100)              
    add di, 2 ; salto al siguiente estilo de char en la memoria VGA
    loop d2
    
mov cx, 26  ; numero de caracteres en blanco
  
d3:   
    mov [di], 11111100b                
    add di, 2
    loop d3

dec di
mov [di], 10111010b ; Simbolo del borde del marco              
add di, 1
mov [di], 11111100b
add di, 1

; 2 lineas vacias con una raya amarilla en medio (igual que arriba)
mov  dx, 2

e1:

mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 26
  
e2:   
    mov [di], 11111100b                
    add di, 2
    loop e2

mov cx, 26
  
e3:   
    mov [di], 11101100b                
    add di, 2
    loop e3
    
mov cx, 26
  
e4:   
    mov [di], 11111100b                
    add di, 2
    loop e4
        
dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  e1

; 9 lineas vacias (igual que arriba)
mov  dx, 9

f1:

mov [di], 10111010b              
add di, 1
mov [di], 11111100b
add di, 2
  
mov cx, 78
  
f2:   
    mov [di], 11111100b                
    add di, 2
    loop f2

dec di
mov [di], 10111010b               
add di, 1
mov [di], 11111100b
add di, 1

dec  dx
jnz  f1

; Ultima linea (casi igual que arriba)
mov [di], 11001000b ; Simbolo de la esquina inferior del marco             
add di, 1
mov [di], 11111100b
add di, 1
  
mov cx, 78
  
g:   
    mov [di], 11001101b              
    add di, 1
    mov [di], 11111100b                
    add di, 1
    loop g

mov [di], 10111100b ; Simbolo de la esquina inferior del marco              
add di, 1
mov [di], 11111100b
add di, 1
   
ret

      
      