org 100h

; Invierta el estado de los bits impares desde el D5 hasta el D1
mov ax, 0F0h ;0000 0000 1111 0000
xor ax, 02Ah ;0000 0000 0010 1010
             ; Con XOR: Si se evalua D con 0, devuelve D.
             ;          Si se evalua D con 1, devuelve -D.                    
;R: AX: 0DAh  0000 0000 1101 1010

; Borre los bits pares desde el D6 hasta el D2
mov ax, 0F0h ;0000 0000 1111 0000
and ax, 0ABh ;0000 0000 1010 1011
;R: AX: 0A0h  0000 0000 1010 0000 

; Coloque en 1 los bits D7 y D0
mov ax, 0F0h ;0000 0000 1111 0000
or  ax, 081h ;0000 0000 1000 0001
;R: AX: 0F1h  0000 0000 1111 0001

ret
