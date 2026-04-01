include stringC.lib
include video.lib
include function.lib
include mouse.lib
include archivos.lib



;--------------------------------------------------------
; Definicion de stack
STACKSG segment para stack 'stack'
    DB 20 DUP (0)
STACKSG ENDS

;--------------------------------------------------------
; Definicion de datos
DATASG SEGMENT PARA 'DATA'

;___________________________  Variables para el mouse ________________________

    
mouse   dw 0000000110000000b
        dw 0000001001000000b
        dw 0000010000100000b
        dw 0000100000010000b
        dw 0001001001001000b
        dw 0001000000001000b
        dw 0000010110100000b
        dw 0000101001010000b
        dw 0001010110101000b
        dw 0000101001010000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b

        dw 0000000000000000b
        dw 0000000110000000b
        dw 0000001111000000b
        dw 0000011111100000b
        dw 0000110110110000b
        dw 0000111111110000b
        dw 0000001001000000b
        dw 0000010110100000b
        dw 0000101001010000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        dw 0000000000000000b
        
        play_base dw 26
        play_altura dw 7
        exit_base dw 26
        exit_altura dw 7
        
        x_mouse dw 182
        y_mouse dw 58
        
        x_mouse_aux dw 0
        y_mouse_aux dw 0
        
        x_play dw 146
        y_play dw 60
        x_exit dw 146
        y_exit dw 140
        modo db 0

;____________________________________________ Palabras en matrices para el dise?o _______________________________

score_matriz db  1,1,1,1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0      
             db  1,1,1,1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0 
             db  1,1,0,0,0,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1 
             db  1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 
             db  0,0,0,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 
             db  0,0,0,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,0,0,0 
             db  1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 
             db  1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 

lives_matriz db  1,1,0,0,0,0, 1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0      
             db  1,1,0,0,0,0, 1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0 
             db  1,1,0,0,0,0, 0,0,0, 1,1,0,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,0,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,0,1,1,0, 1,1,0,1,1,0, 1,1,0,0,0 
             db  1,1,0,0,0,0, 1,1,0, 1,1,0,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 0,0,0,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,1,1,1,0, 1,1,0,0,0,0, 0,0,0,1,1 
             db  1,1,1,1,1,0, 1,1,0, 0,1,1,1,0,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,1,1,1,0, 1,1,0, 0,0,1,0,0,0, 1,1,1,1,1,0, 1,1,1,1,1 

play_matriz  db  1,1,1,1,0,0,0, 1,0,0,0,0,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1     
             db  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  0,1,0,1,0,0,0, 1,0,0,0,1
             db  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,1,0,1,0
             db  1,1,1,1,0,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0
             db  1,0,0,0,0,0,0, 1,0,0,0,0,0,0,  1,1,1,1,1,0,0, 0,0,1,0,0
             db  1,0,0,0,0,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0 
             db  1,0,0,0,0,0,0, 1,1,1,1,1,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0 
             
             
points_matriz  db  1,1,1,1,0,0,0, 0,1,1,1,0,0,0,  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  1,1,1,1,1,0,0,  0,1,1,1,0
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,1,0,0,1,0,0,  0,0,1,0,0,0,0,  1,0,0,0,0
               db  1,1,1,1,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,1,0,1,0,0,  0,0,1,0,0,0,0,  0,1,1,1,0
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,1,1,0,0,  0,0,1,0,0,0,0,  0,0,0,0,1
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0,  1,0,0,0,1
               db  1,0,0,0,0,0,0, 0,1,1,1,0,0,0,  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0,  0,1,1,1,0
              
               
space_matriz  db  0,1,1,1,0,0,0, 1,1,1,1,0,0,0,  0,0,1,0,0,0,0, 0,1,1,1,0,0,0,  1,1,1,1,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  0,1,0,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,0
               db  0,1,1,1,0,0,0, 1,1,1,1,0,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,1,1,1,0
               db  0,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,1,1,1,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,0
               db  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0
               db  0,1,1,1,0,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,1,1,1,0,0,0,  1,1,1,1,1 
               
invaders_matriz  db  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0,0,0, 1,1,1,1,0,0,0,  1,1,1,1,1,0,0,  1,1,1,1,0,0,0,  0,1,1,1,0
                 db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 0,1,0,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,0,0,1,0,0,  1,0,0,0,1
                 db  0,0,1,0,0,0,0, 1,1,0,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,0,0,1,0,0,  1,0,0,0,0
                 db  0,0,1,0,0,0,0, 1,0,1,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,1,1,1,0,0,0,  1,1,1,1,0,0,0,  0,1,1,1,0
                 db  0,0,1,0,0,0,0, 1,0,0,1,1,0,0,  1,0,0,0,1,0,0, 1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,1,0,0,0,0,  0,0,0,0,1
                 db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  0,1,0,1,0,0,0, 1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,0,1,0,0,0,  1,0,0,0,1
                 db  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1,0,0, 1,1,1,1,0,0,0,  1,1,1,1,1,0,0,  1,0,0,0,1,0,0,  0,1,1,1,0            

exit_matriz    db  1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  0,1,1,1,0,0,0, 1,1,1,1,1
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
               db  1,0,0,0,0,0,0, 0,1,0,1,0,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
               db  1,1,1,1,0,0,0, 0,0,1,0,0,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0             
               db  1,0,0,0,0,0,0, 0,1,0,1,0,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
               db  1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  0,1,1,1,0,0,0, 0,0,1,0,0
   
You_matriz     db  1,0,0,0,1,0,0, 0,1,1,1,1,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1
               db  0,1,0,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1
               db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1             
               db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1
               db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1 
               db  0,0,1,0,0,0,0, 0,1,1,1,0,0,0,  0,1,1,1,0 
               
Win_matriz     db  1,0,0,0,1,0,0, 0,1,1,1,0,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 0,0,1,0,0,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 0,0,1,0,0,0,0,  1,1,0,0,1
               db  1,0,1,0,1,0,0, 0,0,1,0,0,0,0,  1,0,1,0,1             
               db  1,1,0,1,1,0,0, 0,0,1,0,0,0,0,  1,0,0,1,1
               db  1,0,0,0,1,0,0, 0,0,1,0,0,0,0,  1,0,0,0,1 
               db  1,0,0,0,1,0,0, 0,1,1,1,0,0,0,  1,0,0,0,1 
               
Game_matriz    db  1,1,1,1,1,0,0, 0,0,1,0,0,0,0,  1,0,0,0,1,0,0, 1,1,1,1,1
               db  1,0,0,0,1,0,0, 0,1,0,1,0,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  1,1,0,1,1,0,0, 1,0,0,0,0
               db  1,0,1,1,1,0,0, 1,0,0,0,1,0,0,  1,0,1,0,1,0,0, 1,1,1,1,0             
               db  1,0,0,0,1,0,0, 1,1,1,1,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0
               db  1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 1,1,1,1,1
               
Over_matriz    db  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  1,1,1,1,1,0,0, 1,1,1,1,0
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0, 1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0, 1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,1,1,1,0,0,0, 1,1,1,1,0             
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0, 1,0,1,0,0
               db  1,0,0,0,1,0,0, 0,1,0,1,0,0,0,  1,0,0,0,0,0,0, 1,0,0,1,0
               db  0,1,1,1,0,0,0, 0,0,1,0,0,0,0,  1,1,1,1,1,0,0, 1,0,0,0,1
               
diez_matriz    db  0,0,1,0,0,0,0,0,1,1,1,0
               db  0,1,1,0,0,0,0,1,0,0,0,1
               db  0,0,1,0,0,0,0,1,0,0,0,1
               db  0,0,1,0,0,0,0,1,0,0,0,1             
               db  0,0,1,0,0,0,0,1,0,0,0,1
               db  0,0,1,0,0,0,0,1,0,0,0,1
               db  0,1,1,1,0,0,0,0,1,1,1,0
           
n20_matriz     db  0,1,1,1,0,0,0,0,1,1,1,0
               db  1,0,0,0,1,0,0,1,0,0,0,1
               db  0,0,0,0,1,0,0,1,0,0,0,1
               db  0,0,0,1,0,0,0,1,0,0,0,1             
               db  0,0,1,0,0,0,0,1,0,0,0,1
               db  0,1,0,0,0,0,0,1,0,0,0,1
               db  1,1,1,1,1,0,0,0,1,1,1,0
         
n30_matriz     db  1,1,1,1,1,0,0,0,1,1,1,0
               db  0,0,0,0,1,0,0,1,0,0,0,1
               db  0,0,0,1,0,0,0,1,0,0,0,1
               db  0,0,1,1,0,0,0,1,0,0,0,1             
               db  0,0,0,0,1,0,0,1,0,0,0,1
               db  1,0,0,0,1,0,0,1,0,0,0,1
               db  0,1,1,1,0,0,0,0,1,1,1,0            
               
igual_matriz   db  0,0,0,0,0
               db  0,0,0,0,0
               db  1,1,1,1,1
               db  0,0,0,0,0             
               db  1,1,1,1,1
               db  0,0,0,0,0
               db  0,0,0,0,0
  

;___________________________-- Matrices para dibujar los invasores y al jugador -- _____________________           
invasorA  db 0,0,0,0,0,1,1,0,0,0,0,0
          db 0,0,0,0,1,1,1,1,0,0,0,0
          db 0,0,0,1,1,1,1,1,1,0,0,0
          db 0,0,1,1,0,1,1,0,1,1,0,0
          db 0,0,1,1,1,1,1,1,1,1,0,0
          db 0,0,0,0,1,0,0,1,0,0,0,0
          db 0,0,0,1,0,1,1,0,1,0,0,0
          db 0,0,1,0,1,0,0,1,0,1,0,0
          
invasorB  db 0,0,0,0,1,1,1,1,0,0,0,0
          db 0,1,1,1,1,1,1,1,1,1,1,0
          db 1,1,1,1,1,1,1,1,1,1,1,1
          db 1,1,1,0,0,1,1,0,0,1,1,1
          db 1,1,1,1,1,1,1,1,1,1,1,1
          db 0,0,0,1,1,0,0,1,1,0,0,0
          db 0,0,1,1,0,1,1,0,1,1,0,0
          db 1,1,0,0,0,0,0,0,0,0,1,1
                    
invasorC  db 0,0,1,0,0,0,0,0,1,0,0,0
          db 0,0,0,1,0,0,0,1,0,0,0,0
          db 0,0,1,1,1,1,1,1,1,0,0,0
          db 0,1,1,0,1,1,1,0,1,1,0,0
          db 1,1,1,1,1,1,1,1,1,1,1,0
          db 1,0,1,1,1,1,1,1,1,0,1,0
          db 1,0,1,0,0,0,0,0,1,0,1,0
          db 0,0,0,1,1,0,1,1,0,0,0,0
          
player  db 0,0,0,0,1,1,1,0,0,0,0
        db 0,0,0,1,0,0,0,1,0,0,0
        db 0,0,1,0,0,0,0,0,1,0,0
        db 1,1,1,1,1,1,1,1,1,1,1
        db 0,1,0,1,0,1,0,1,0,1,0
        db 0,0,1,1,1,1,1,1,1,0,0
        db 0,1,0,1,1,1,1,1,0,1,0
        db 1,0,0,0,0,1,0,0,0,0,1  
 
disparo db 1
        db 1
        db 1
        

escudo  db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0
        db 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0
        db 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
        db 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        db 1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1
        db 1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1
        db 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
        db 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
        
impacto db 1,0,0,0,0,1,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,1,0,0,0,0
        db 0,0,0,0,0,1,0,0,1,0,0,0
        db 0,0,0,0,1,0,0,1,0,1,0,1
        db 0,1,0,1,0,0,0,0,0,1,0,0
        db 0,0,0,0,0,0,1,0,1,0,0,0
        db 1,0,0,1,0,1,0,0,0,0,0,0
        db 0,1,0,0,0,0,0,1,0,0,1,0

     
;__________________ Variables del apartado del juego _________________________________   
colorA db 0cH
colorB db 0AH
colorC db 0BH
colorP db 0FH
colorE db 04H
player_time dw 0040
invader_time dw 0080
x_player dw 154
y_player dw 180     
x_invasorA dw 82
y_invasorA dw 40  

x_invasorB  dw 82
y_invasorB  dw 52

x_invasorC dw 82
y_invasorC dw 76  

x_escudo dw 71
y_escudo dw 150
lives db 3
valor_inicial db '000'
valor_invasor db '000'

invasorA_estado db 10 dup(1)
        
invasorB_estado db 20 dup(1)
                                  
invasorC_estado db 20 dup(1)

ancho_invasor dw 16
alto_invasor dw 12

x_impacto dw 0
y_impacto dw 0

columna dw 0
fila dw 0
x_lives dw 205
y_lives dw 5
x_live dw 241
y_live dw 7
ancho_live dw 15
x_disparo dw 159
y_disparo dw 176

x_disparoInv dw 0
y_disparoInv dw 0

x_aux dw 0
y_aux dw 0

x_auxL dw 0
y_auxL dw 0

x_anim          dw 73
y_anim          dw 30
x_invasor dw 82
y_invasor dw 40
x_invasorAux dw 0
y_invasorAux dw 0

disparo_activo        db 0
izquierda_activo      db 0
tecla_actual          db 0
tecla_anterior        db 0
num_animaciones db 0
color db 0
color_aux db 0

invasoresEliminados db 0
numDesplazamientos db 6
num_animacionesIzq db 0
num_animacionesDer db 0
activado db 0

;_______________Registro _____________

        usuario db 'Usuario: $',0
        letra db 0
        len dw 10
        log_in db 'log in$'
        logIn db 'Log In $'
        x_puntero db 0
        y_puntero db 0
        x_form dw 0
        y_form dw 0
        color_form db 8
        base_form dw 0
        altura_form dw 0
     
; --------- Varibles para registrar al jugador --------      
              
    name_archivo  db "data.txt",0
    id_usuario      db 8, 0, 8 dup(0)   
    name_usuario    db 11, 0, 11 dup(0)
    id              db "Id: $"
    texto_usuario   db "   Usuario: $"
    texto_score     db "   Puntaje: $"
    salto_linea     db 13,10,"$"
    msg_exito       db "Registro guardado con exito$"
    msg_error       db "Error en operacion de archivo$"
    score           db "0000$"  ; --Score para guardar la suma de mi puntos
    cadena_final    db 80 dup(0)
    handle          dw 0
    longitud dw 0
    
    
DATASG ENDS

;---------------------  Codigo -----------------
CODESG SEGMENT PARA 'CODE'

PRINCI PROC FAR
    ASSUME SS:STACKSG, DS:DATASG, CS:CODESG
    PUSH DS
    XOR AX,AX
    PUSH AX
    MOV AX, SEG DATASG
    MOV DS, AX

;--Iniciar Programa 
    obtener_modo_video ; obtiene el modo actual y lo guarda en al
    mov modo,al
    
    call ingresarUsuario ; Registramos al usuario
 
    
    ;--------------------------- Inicio del menu Juego --------------
    modo_video 13h
    MOV AX,0A000h
    MOV ES,AX
 
inicio_del_juego:
call main_menu   ;-----> menu del juego: funciona con el mouse

  ; -----------------------Bucle Principal    ------------------------
  retardo 6,3600
bucle_principal_del_juego:
    
    call dibujar_lives
    call shift_invaders  ; encargado de desplazar los invaders de izq a right
    call disparar_invasor 
    call leer_tecla_juego;encargado de dectetar la tecla presiona disparar _, right -> , left <-
     
    cmp lives, 0
    je fin_por_muerte      
    cmp invasoresEliminados, 50
    je fin_por_victoria   
      dibujar_matriz player,x_player,y_player,11,8,colorP
      retardo 0,6000h
    jmp bucle_principal_del_juego ; Repetir

fin_por_muerte:
    call perdiste
    jmp inicio_del_juego   

fin_por_victoria:
    call ganaste
    jmp inicio_del_juego
        

PRINCI ENDP


;------------------------------------ Inicio de todos lo procedimientoos --------------------------------------


esperar_vsync proc
    push ax dx
    mov dx, 03DAh        

retrace_fin:
    in al, dx
    test al, 8           
    jnz retrace_fin      

retrace_inicio:
    in al, dx
    test al, 8
    jz retrace_inicio    

    pop dx ax
    
    ret
esperar_vsync endp
ambientacion_juego proc
push bx cx

    dibujar_matriz score_matriz,35,5,29,10,0CH       
    dibujar_matriz lives_matriz,x_lives,5,26,10,0CH 
    dibujar_matriz escudo,x_escudo,y_escudo,17,12,colorE 
    add x_escudo,40
    dibujar_matriz escudo,x_escudo,y_escudo,17,12,colorE
    add x_escudo,40
    dibujar_matriz escudo,x_escudo,y_escudo,17,12,colorE
    add x_escudo,40
    dibujar_matriz escudo,x_escudo,y_escudo,17,12,colorE
    add x_escudo,40
    dibujar_matriz escudo,x_escudo,y_escudo,17,12,colorE 

    MOV BX, OFFSET score
    MOV CX, 4 
    call imprimir_resultado 
    
pop cx bx
ret
ambientacion_juego endp

dibujar_invaders proc
call invasoresA
call invasoresB
call invasoresC
ret
dibujar_invaders endp
;---------   menu utilizado con el mouse    --------------------------
main_menu proc
push ax bx cx
    limpiar_modo_grafico
    call dibujar_menu
    mostrar_puntero
     fijar_limites_verticales  190,0
     fijar_limites_horizontales  610,0
    mov ax,x_mouse
    shl ax,1
    mov x_mouse_aux,ax
    
    posicionar_puntero x_mouse_aux,y_mouse

      enmascarar_mouse mouse

    
rastrearMouse:   
            rastrear_mouse
            shr cx, 1
            mov x_mouse,cx
            mov y_mouse,dx
            cmp bx,1h
            jne rastrearMouse
            mov cx,x_mouse
             mov dx,y_mouse
            verificar_area_click x_play,y_play,play_base,play_altura
            cmp al, 1
            je iniciar_play
            mov cx,x_mouse
            mov dx,y_mouse
            verificar_area_click x_exit,y_exit,exit_base,exit_altura
            cmp al,1
            je EXIT
            jmp rastrearMouse
       
        EXIT:   
                ocultar_puntero
                limpiar_modo_grafico
                habilitar_mouse 
                modo_video modo 
                call guardar_datos
                
                call sal_a_dos
                  
            iniciar_play:
                posicionar_puntero 0,0
                ocultar_puntero
                limpiar_modo_grafico
                call reset_play
                retardo 04,60000 
                call ambientacion_juego
                call dibujar_invaders
                
                        
   
 pop cx bx ax   
ret
main_menu endp


dibujar_menu proc
    
 dibujar_matriz player,290,20,11,8,08h

  dibujar_matriz space_matriz,110,30,33,7,0CH 
  dibujar_matriz invaders_matriz,152,30,54,7,0CH
  dibujar_matriz play_matriz,146,60,26,7,0AH 
  ;invasorA
  dibujar_matriz invasorA,116,89,12,8,colorA
  dibujar_matriz igual_matriz,132,90,5,7,0EH
  dibujar_matriz n30_matriz,141,90,12,7,0EH
  dibujar_matriz points_matriz,163,90,40,7,0EH
  
  ;invasorB
  dibujar_matriz invasorB,116,104,12,8,colorB
  dibujar_matriz igual_matriz,132,105,5,7,0EH
  dibujar_matriz n20_matriz,141,105,12,7,0EH
  dibujar_matriz points_matriz,163,105,40,7,0EH
  ;invasorC
  dibujar_matriz invasorC,116,119,12,8,colorC
  dibujar_matriz igual_matriz,132,120,5,7,0EH
  dibujar_matriz diez_matriz,141,120,12,7,0EH
  dibujar_matriz points_matriz,163,120,40,7,0EH
 
  
  dibujar_matriz exit_matriz,146,140,26,7,0dH  

ret
dibujar_menu endp

;--------------Procedimiento por si el jugador decide jugar de nuevo -----------------
reset_play proc
push ax cx si
    mov colorA ,0cH 
    mov colorB,0AH
    mov colorC,0BH
    mov colorP ,0FH
    mov colorE ,04H
    mov player_time , 0040
    mov invader_time , 0080
    mov x_player ,154
    mov y_player , 180     
    mov x_invasorA , 82
    mov y_invasorA , 40  

    mov x_invasorB  , 82
    mov y_invasorB  , 52

    mov x_invasorC , 82
    mov y_invasorC , 76  

    mov x_escudo ,71
    mov y_escudo , 150
    mov lives , 3
    mov valor_inicial[0] , '0'
    mov valor_inicial[1] , '0'
    mov valor_inicial[2] , '0'
    
    mov valor_invasor[0] , '0'
    mov valor_invasor[0] , '0'
    mov valor_invasor[0] , '0'
    
      
    mov cx,10
    mov al,1
    lea si,invasorA_estado
activarA:
    mov [si],al
    inc si
    loop activarA
    
    mov cx,20
    lea si,invasorB_estado
activarB:
    mov [si],al
    inc si
    loop activarB
    
      mov cx,20
      lea si,invasorC_estado
activarC:
      mov [si],al
    inc si
    loop activarC
    


    mov ancho_invasor ,16
    mov alto_invasor , 12

    mov x_impacto ,0
    mov y_impacto , 0

    mov columna ,0
    mov fila ,0
    mov x_lives , 205
    mov y_lives , 5
    mov x_live , 241
    mov y_live , 7
    mov ancho_live , 15
    mov x_disparo , 159
    mov y_disparo , 176

    mov x_disparoInv , 0
    mov y_disparoInv , 0

    mov x_aux ,0
    mov y_aux , 0

    mov x_auxL , 0
    mov y_auxL , 0

    mov x_anim  ,73
    mov y_anim , 30
    mov x_invasor , 82
    mov y_invasor , 40
    mov x_invasorAux , 0
    mov y_invasorAux , 0

    mov disparo_activo       , 0
    mov izquierda_activo      , 0
    mov tecla_actual         , 0
    mov tecla_anterior        , 0
    mov num_animaciones ,0
    mov color ,0
    mov color_aux , 0

    mov invasoresEliminados ,0
    mov numDesplazamientos , 6
    mov num_animacionesIzq , 0
    mov num_animacionesDer,  0
    mov activado , 0



    mov score[0]   , '0'  ; --Score para guardar la suma de mi puntos
    
    mov score[1]   , '0' 
    mov score[2]   , '0' 
    mov score[3]   , '0' 
    mov score[4]   , '$' 

pop si cx ax
ret
reset_play endp
;--------------Procedimiento por si el jugador pierde -----------------
perdiste proc
push ax
        retardo 3,6000
        dibujar_matriz Game_matriz,130,80,26,7,0EH
        dibujar_matriz Over_matriz,166,80,26,7,0EH
        retardo 8,6000
        MOV AH,07H      
        INT 21h 
        
        
pop ax      
ret
perdiste endp

;------------------ Procedimiento por si el jugador gana ------------------
ganaste proc
push ax
    retardo 3,6000
    dibujar_matriz You_matriz,130,70,19,7,0EH
    dibujar_matriz Win_matriz,159,70,19,7,0EH
    retardo 8,6000
    MOV AH,07H      
    INT 21h 

pop ax
    ret
ganaste endp
;__________________________________Leemos que tecla fue presionada ____________________
leer_tecla_juego PROC
push ax bx 

    mov ah, 01h
    int 16h
    jz sin_tecla
    
    mov ah, 00h
    int 16h
    mov tecla_actual, ah
    
    mov bl,tecla_anterior
    cmp tecla_actual, bl
    je salida
    cmp tecla_actual, 39h
    jne no_disparo
    call disparar_player
    jmp set_anterior
    
    no_disparo:
        cmp tecla_actual, 4Bh
        jne no_izq
        call mover_izquierda
        jmp set_anterior
        no_izq:
            cmp tecla_actual, 4Dh
            jne salida
            call mover_derecha

set_anterior:
    mov bl,tecla_actual
    mov tecla_anterior, bl

sin_tecla:
    mov tecla_anterior, 0
salida:
    pop bx ax
    ret
leer_tecla_juego ENDP


;------------------------ Procedimiento para leer los datos del usuario ---------------------
ingresarUsuario proc
push ax bx cx
modo_video 12h
    call dibujar_formulario
     habilitar_mouse
     mostrar_puntero
    fijar_limites_verticales  470,0
    fijar_limites_horizontales  630,0
     posicionar_puntero 310,300  
    mov x_form ,262
    mov y_form ,211
    call dibujar_linea
    ;---------Leermo el id del usuario de tres digitos -----------
    posicionar_cursor 12,34
    leer_cadena id_usuario    
    
    mov color_form,0
    mov x_form ,262
    mov y_form ,211
    call dibujar_linea
    mov color_form,08h
    mov x_form ,262
    mov y_form ,242
    call dibujar_linea
    ;---------Leermo nombre del usuario de caracteres como maximo -----------
    posicionar_cursor 14,34
    leer_cadena name_usuario
    ;-----------------Esperamos para que el usuario presione el boton para registrarse -----------
rastrearBoton:   
            rastrear_mouse
            cmp bx,1h         
            jne rastrearBoton
         
            verificar_area_click 365,280,base_form,altura_form
            cmp al, 1
            je iniciarP
            jmp rastrearBoton
     iniciarP:            
            ocultar_puntero
            limpiar_modo_grafico  
            retardo 07,60000
                        
   
 pop cx bx ax 

ret
ingresarUsuario endp


; ----------------  Procedimiento para dibujar el formulario en donde pediremos los datos del usuario ------------
dibujar_formulario proc

;dibujamos el cuadro
mov x_form ,115
mov y_form,115
mov base_form ,400
mov altura_form, 0220
call dibujar_casilla

;Ponemos Log in como titulo
mov color_form,02h
mov x_puntero,36
mov y_puntero,9   
mov len ,7
lea bx,logIn
call despliegar_cadena
   
;Dibujamos el boton 
mov x_form ,365
mov y_form ,280
mov base_form ,100
mov altura_form, 30
call dibujar_casilla  
mov color_form,0ah
;escribimos: id :
mov x_puntero,28
mov y_puntero,12   
mov len ,4
lea bx,id
call despliegar_cadena
;escribimos: usuario :
mov x_puntero,23
mov y_puntero,14
mov len ,9
lea bx,usuario
call despliegar_cadena
;escribimos: log in ->para el boton
mov x_puntero,49
mov y_puntero,18
mov len ,6
lea bx,log_in
mov color_form,08h
call despliegar_cadena

ret
dibujar_formulario endp

;___________________________________ Despliegamos una cadena con color___________________________________________________________
 
despliegar_cadena proc
push di
mov di,0
mov dx,len
despliegar:
posicionar_cursor y_puntero,x_puntero
        despliegar_caracter [bx][di],color_form,1
        inc x_puntero
        inc di
       dec dx
      cmp dx,0
      jne despliegar
pop di
ret
despliegar_cadena endp
; Procedimiento para dibujar una linea 
dibujar_linea proc
push cx
mov cx, 130

right_l:
    dibujar_punto color_form,x_form,y_form
    inc x_form
            dec cx
            jnz right_l
            
pop cx
ret
dibujar_linea endp
; Procedimiento para dibujar una casilla o cuadro
dibujar_casilla proc
        
    push ax
    push bx
    push cx
    push dx


    mov cx, base_form

        right:
    dibujar_punto color_form,x_form,y_form
    inc x_form
            dec cx
            jnz right
           
            mov cx,altura_form

        down:
            dibujar_punto color_form,x_form,y_form
            inc y_form
            dec cx
            jnz down
          
            mov cx,base_form
        left:
            dibujar_punto color_form,x_form,y_form
            dec x_form
            dec cx
            jnz left
          
            mov cx,altura_form
       up:
           dibujar_punto color_form,x_form,y_form
           dec y_form
           dec cx
           jnz up

    pop dx
    pop cx
    pop bx
    pop ax
    ret
dibujar_casilla endp

;______________________________________ Protocolos para mover al jugador __________________________________

mover_izquierda proc
    ; Borramos al jugador y avanzamos
    dibujar_matriz player,x_player,y_player,11,8,0
    cmp x_player,61
    jle fuera_rango_Izq
    sub x_disparo,5
    sub x_player,5
fuera_rango_Izq:
    ret
mover_izquierda endp


mover_derecha proc
; Borramos al jugador y avanzamos
    dibujar_matriz player,x_player,y_player,11,8,0
    cmp x_player,247
    jge fuera_rango_Der
    add x_player,5
    add x_disparo,5
fuera_rango_Der:
    ret
mover_derecha endp

shift_invaders proc
    right_Shift:  
        cmp activado,1
        je left_Shift
        call desplazamiento_der
        jmp fin_Shift
    left_Shift:
        call desplazamiento_izq
        mov numDesplazamientos,12
    
    fin_Shift:
ret
shift_invaders endp
;___________ Guardamos los datos en en archivo llamado data ____________________
guardar_datos proc
push ax bx cx dx ds es

mov ax, SEG DATASG
mov ds, ax
mov es, ax  
       cld
    
    abrir_archivo name_archivo,2
    jnc abrir_listo              

    ; Crear archivo si no existe
    crear_archivo name_archivo
    jnc seguir
    jmp error                    

seguir:
    mov handle, ax
    jmp construir_cadena

abrir_listo:
    mov handle, ax

    ;Posicionar al final del archivo
   posicionar_al_final handle

construir_cadena:
    lea di, cadena_final

    ; copiamos linea: Id: 
    copiar_cadena_con id

    ; 
    mov al, [id_usuario+1]      
    cmp al, 7
    jae copiar_id                ; Saltar si ya tiene 7 digitos
    mov bl, 7
    sub bl, al
    mov cx, bx
    jcxz copiar_id               
    mov al, '0'
    rep stosb

copiar_id:
    copiar_buffer id_usuario

    ; Agregar:    Usuario: 
    copiar_cadena_con texto_usuario

    ; Copiar nombre de usuario
    copiar_buffer name_usuario

    ; Agregar: Puntaje: 
    copiar_cadena_con texto_score

    ; Copiar score
    copiar_cadena_con score

    ; Salto de linea
    mov ax, 0A0Dh                
    stosw

    ; Calcular longitud de la cadena final
    mov cx, di
    lea dx, cadena_final
    sub cx, dx                   ; CX = bytes a escribir

    mov longitud,cx
    escribir_archivo  cadena_final,longitud,handle
   
    cerrar_archivo

   
    imprimir_cadena msg_exito
    imprimir_cadena salto_linea
    jmp exit

error:
    imprimir_cadena msg_error
    imprimir_cadena salto_linea

exit:
    pop es ds dx cx bx ax
        ret
guardar_datos endp




;____________________________________ Protocolos para dibujar los invasores _______________________________

  ;________INVASOR: A -> color: 0CH
  
  

invasoresA proc
push ax bx cx dx si

    mov cx,10

    lea si,invasorA_estado
    mov ax,x_invasorA
    mov x_aux,ax
    mov dx,y_invasorA
    mov y_aux,dx
    
dibujar_invasorA:
    mov bl,[si]
    cmp bl,1
    jne invasorA_eliminado
    dibujar_matriz invasorA,x_aux,y_aux,12,8,colorA
    
    invasorA_eliminado:
            inc si
            add x_aux,16
            loop dibujar_invasorA
pop si dx cx bx ax    
ret
invasoresA endp
;__________________Invasor: B  -> Color:0AH

invasoresB proc
push ax bx cx dx si

    mov cx,20

    lea si,invasorB_estado
    mov ax,x_invasorA
    mov x_aux,ax
    mov dx,y_invasorB
    mov y_aux,dx
    
dibujar_invasorB:
    mov bl,[si]
    cmp bl,1
    jne invasorB_eliminado
    dibujar_matriz invasorB,x_aux,y_aux,12,8,colorB
    
    invasorB_eliminado:
            inc si
            add x_aux,16
            cmp cx,11
            jne mismo_renglonB
            add y_aux,12
            mov x_aux,ax
            
     mismo_renglonB: loop dibujar_invasorB
            
pop si dx cx bx ax    
ret
invasoresB endp

;_________________Invasor : C -> Color : 0BH______________________

invasoresC proc
push ax bx cx dx si

    mov cx,20

    lea si,invasorC_estado
    mov ax,x_invasorA
    mov x_aux,ax
    mov dx,y_invasorC
    mov y_aux,dx
    
dibujar_invasorC:
    mov bl,[si]
    cmp bl,1
    jne invasorC_eliminado
    dibujar_matriz invasorC,x_aux,y_aux,12,8,colorC
    
    invasorC_eliminado:
            inc si
            add x_aux,16
            cmp cx,11
            jne mismo_renglonC
            add y_aux,12
            mov x_aux,ax
            
            mismo_renglonC: loop dibujar_invasorC
            
pop si dx cx bx ax    
ret
invasoresC endp

;------- desplazamiento  a la izquierda -----------
desplazamiento_izq proc
push ax

mov al,colorA
mov bl,colorB
mov cl,colorC
mov colorA,0
mov colorB,0
mov colorC,0
call dibujar_invaders
sub x_invasorA,2
mov colorA,al
mov colorB,bl
mov colorC,cl
call dibujar_invaders
inc num_animacionesIzq
mov bl,numDesplazamientos
cmp num_animacionesIzq,bl
jne Izquierda_activado
mov activado,0
mov num_animacionesIzq,0

Izquierda_activado:

pop ax
ret
desplazamiento_izq endp
;------- desplazamiento  a la izquierda -----------
desplazamiento_der proc
push ax
mov al,colorA
mov bl,colorB
mov cl,colorC
mov colorA,0
mov colorB,0
mov colorC,0
call dibujar_invaders
add x_invasorA,2
mov colorA,al
mov colorB,bl
mov colorC,cl
call dibujar_invaders
inc num_animacionesDer
mov bl,numDesplazamientos
cmp num_animacionesDer,bl
jne Derecha_activado
mov activado,1
mov num_animacionesDer,0
Derecha_activado:
 
pop ax
ret
desplazamiento_der endp



;_------------------ Procedimiento para dibujar las vidas que tiene el jugador --------------------------
dibujar_lives proc
push ax cx
mov cl,lives
mov ax,x_lives
mov x_auxL,ax
add x_auxL,36
mov ax,y_lives
mov y_auxL,ax
add y_auxL,2
lives_loop:
    dibujar_matriz player,x_auxL,y_auxL,11,8,colorP
    add x_auxL,15
    loop lives_loop
pop cx ax
ret

dibujar_lives endp

;_______________________________________________________________________________________________


;_________________________ protocolo de disparar para el jugador______________________
;------   Procedimiento para procesar que colision hubo por color 
procesar_colision_color proc
push ax bx cx dx si di

    mov al,color
    cmp al, colorA       
    je buscar_invasor_A
    cmp al, colorB       
    je buscar_invasor_B
    cmp al, colorC       
    je buscar_invasor_C
    jmp abortar_colision

;------------------------------
buscar_invasor_A:
    mov al,'3'  
    mov valor_invasor + 1,al
    mov al,'0'
    mov valor_invasor + 2,al
    lea bx,invasorA_estado  
    call calcular_columna
    mov si,ax
    mov fila,0
    mov columna,ax
    mov al,0
    mov [bx][si], al
    call borrar_invasor_visual
    jmp fin_colision

;------------------------------

buscar_invasor_B:
       mov al,'2'  
       mov valor_invasor + 1,al
    mov al,'0'
    mov valor_invasor + 2,al
    
    call calcular_columna
    mov columna,ax
    call calcular_fila
    mov fila,ax
    sub ax,1
    mov bx,10
    mul bx
   add ax,columna
   lea bx,invasorB_estado  
   mov si,ax
    mov al,0
    mov [bx][si], al
    call borrar_invasor_visual
    jmp fin_colision
buscar_invasor_C:
    mov al,'1'  
    mov valor_invasor +1 ,al
    mov al,'0'
    mov valor_invasor + 2,al
    call calcular_columna
    mov columna,ax
    call calcular_fila
    mov fila,ax
    sub ax,3
    mov bx,10
    mul bx
   add ax,columna
   lea bx,invasorC_estado  
   mov si,ax
    mov al,0
    mov [bx][si], al
    call borrar_invasor_visual
    jmp fin_colision
;------------------------------

    ; No hacer nada si no es invasor

fin_colision:
    inc invasoresEliminados
    lea di,valor_inicial
    lea si,score
    inc si
    mov cx,3
copiar_num:
    mov al,[si]
    mov [di],al
    inc si
    inc di
    loop copiar_num
    
    
    call sumar_bcd
abortar_colision:
    MOV BX, OFFSET score
    MOV CX, 4  
    call imprimir_resultado
   pop di si dx cx bx ax
    ret
procesar_colision_color endp

;----------------- borramos al invasor que fue eliminado --------------
borrar_invasor_visual proc
    push ax bx dx
    mov ax, columna
    mov bx, ancho_invasor
    mul bx
    add ax, x_invasorA
    mov x_aux, ax

    xor ax,ax
    mov ax, fila
    mov bx, alto_invasor
    mul bx
    add ax, y_invasorA
    mov y_aux, ax


    dibujar_matriz invasorA,x_aux,y_aux,12,8,0

    dibujar_matriz impacto,x_aux,y_aux,12,8,0Eh
    retardo 1,100h
    dibujar_matriz impacto,x_aux,y_aux,12,8,0

    pop dx bx ax
    ret
borrar_invasor_visual endp

;-------------------------procedimiento para disparar para el jugador-------------------
disparar_player proc
push ax bx cx dx bp si di 

  mov ax,x_disparo
  mov bx,y_disparo
  mov x_aux,ax
  mov y_aux,bx
          
dispararPlayer:            
             calcular_posicion x_aux,y_aux
             mov al,es:[di]
             cmp al,0
             je sin_colision
             jmp colision
             
             sin_colision:  call borrar_disparoP
                            sub y_aux,1
                            cmp y_aux,30
                            jle dejar_disparar
                            jmp dispararPlayer
                            colision:     
                            
                                mov color,al
                                call borrar_disparoP
                                mov bx,x_aux
                                mov x_impacto,bx
                                mov bx,y_aux
                                mov y_impacto,bx
                                call procesar_colision_color
                            
                             
         dejar_disparar:
             
                   
pop di si bp dx cx bx ax
ret
disparar_player endp

borrar_disparoP proc
dibujar_matriz disparo,x_aux,y_aux,1,3,0FH
retardo 00000,player_time
dibujar_matriz disparo,x_aux,y_aux,1,3,0H
ret
borrar_disparoP endp

;---------------------- Subrutinas para calcular que fila y columna fue eliminado el invasor ---------------------------
calcular_columna proc
push bx
    mov ax, x_impacto
    sub ax, x_invasorA
    xor dx,dx
    mov bx, ancho_invasor
    div bx         ; AX = columna (0-9)
pop bx
    ret
calcular_columna endp

calcular_fila proc
push bx
    mov ax, y_impacto
    sub ax, y_invasorA
    xor dx,dx
    mov bx, alto_invasor
    div bx         ; AX = fila  (0-4)
pop bx
    ret
calcular_fila endp


;---------------------- procedimiento para muestra suma en bcd para sumar el score -----------------------
sumar_bcd proc 
    
    push ax bx cx dx si di     
   CLC  
   LEA SI, valor_inicial + 2
   LEA DI, valor_invasor + 2
   LEA BX, score + 3
   MOV CX, 3  

SALTA:
    MOV AH, 00  
    MOV AL, [SI]
    ADC AL, [DI]
    AAA         
    MOV [BX], AL
    DEC SI
    DEC DI
    DEC BX
LOOP SALTA

MOV [BX], AH  

LEA BX, score + 3
convertir_ascii 4

   pop di si dx cx bx ax 
    ret 
sumar_bcd endp

imprimir_resultado proc
posicionar_cursor 1,10
    imprime:
        
    imprimir_caracter [BX]
        INC BX
        LOOP imprime
ret
imprimir_resultado endp
;______________________________________________invasor -> disparo____________________________--

;------------------ Obtenemos aleatoriamente el invasor que va disparar (0 - 49) ----------------------
disparar_invasor proc
push ax bx cx dx 
    ramdon 0,50
    mov ax,dx
    xor dx,dx
    xor bx,bx
    mov bx,10
    div bx
    mov x_disparoInv,dx
    mov y_disparoInv,ax
    call buscarEstadoInvasor
    cmp al,0
    jne seguir_disparando
    jmp no_Disparar
seguir_disparando:
    xor dx,dx
    xor ax,ax
    xor bx,bx
    mov ax,ancho_invasor
    mul x_disparoInv
    add ax,x_invasorA;variable_De inicio
    add ax,5
    mov x_disparoInv,ax
    xor dx,dx
    xor ax,ax
    xor bx,bx
    mov ax,alto_invasor
    mul y_disparoInv 
    add ax,y_invasorA
    add ax,9
    mov y_disparoInv,ax
    
    call dispararInv
    
no_Disparar:
    pop dx cx bx ax   
ret
disparar_invasor endp


dispararInv proc
push ax bx cx dx bp si di 


  mov ax,x_disparoInv
 
  mov x_invasorAux,ax
   mov bx,y_disparoInv
  mov y_invasorAux,bx
          
dispararInvasorM:  

  calcular_posicion x_invasorAux,y_invasorAux
             mov al,es:[di]             
             cmp al,colorP
             je colisionPlayer
             cmp al,colorE
             je colisionPlayer    
             sin_colisionPlayer: 
                            call sinColisionPlayer
                            add y_invasorAux,1
                            cmp y_invasorAux,190
                            jge dejar_dispararPlayer
                            jmp dispararInvasorM
                        colisionPlayer:
                            mov color,al
                            call sinColisionPlayer
                            call procesar_colision_enemigo
                        dejar_dispararPlayer:
             
                   
pop di si bp dx cx bx ax
ret
dispararInv endp

sinColisionPlayer proc
dibujar_matriz_negativo disparo,x_invasorAux,y_invasorAux,1,3,0dH
retardo 0000,invader_time
dibujar_matriz_negativo disparo,x_invasorAux,y_invasorAux,1,3,0H
ret
sinColisionPlayer endp

;--------- Procesar la colision sobre el jugador --------------------
procesar_colision_enemigo proc
push ax bx cx dx bp si di

    mov al,color
    cmp al, colorP      
    je buscar_player
    jmp abortar_colisionE
buscar_player:
    call impactar_player
    dec lives
    call borrar_live
    jne abortar_colisionE

abortar_colisionE:
    
pop di si bp dx cx bx ax
ret
procesar_colision_enemigo endp

;---------------------- borramos la vida que haya perdido el jugador ----------------  
borrar_live proc
push ax cx 
    mov ax,x_live
    mov x_auxL,ax
    xor cx,cx
    mov cl,lives
    mov ax,ancho_live
    mul cl
    add x_auxL,ax
    mov ax,y_live
    mov y_auxL,ax
    dibujar_matriz player,x_auxL,y_auxL,11,8,0h
pop cx ax   
ret
borrar_live endp

;------------------- dibujamos el impacto sobre el jugador -------
impactar_player proc
    dibujar_matriz impacto,x_player,y_player,12,8,0eh
    retardo 06,60000
    dibujar_matriz impacto,x_player,y_player,12,8,0
ret
impactar_player endp


;------------------------ Verificar que solo los invasores vivos disparen ------------------------
buscarEstadoInvasor proc
mov di,x_disparoInv
mov al,0
cmp y_disparoInv,0
    je estadoA
    cmp y_disparoInv,1
    je estadoBF1
    cmp y_disparoInv,2
    je estadoBF2
    cmp y_disparoInv,3
    je estadoCF1
    cmp y_disparoInv,4
    je estadoCF2
estadoA:
    lea bx,invasorA_estado
    cmp [bx][di],al
    je eliminado
    jmp No_eliminado
    
estadoBF1:
    lea bx,invasorB_estado
    cmp [bx][di],al
    je eliminado
    jmp No_eliminado    
estadoBF2:
    lea bx,invasorB_estado
    add si,10
    cmp [bx][di],al
    je eliminado
    jmp No_eliminado  

estadoCF1:
    lea bx,invasorC_estado
    cmp [bx][di],al
    je eliminado
    jmp No_eliminado    
estadoCF2:
    lea bx,invasorC_estado
    add si,10
    cmp [bx][di],al
    je eliminado
    jmp No_eliminado  
 
eliminado:
 mov al,0
 jmp revisado
No_eliminado:
 mov al,1
revisado:
 

ret
buscarEstadoInvasor endp


sal_a_dos PROC
push ax
    MOV AH,4CH  
    INT 21h
pop ax
    RET
sal_a_dos ENDP
CODESG ENDS
END PRINCI
