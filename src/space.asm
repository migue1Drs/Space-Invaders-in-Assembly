include stringC.lib
include video.lib
include function.lib
include mouse.lib
include archivos.lib

;--------------------------------------------------------
; Definicion de stack
STACKSG segment para stack 'stack'
    DB 512 DUP (0)
STACKSG ENDS

;--------------------------------------------------------
; Definicion de datos
DATASG SEGMENT PARA 'DATA'

;------------  Variables para RegisterUser -----------

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
    score_str        db "0000$"  ; --Score para guardar la suma de mi puntos
    cadena_final    db 80 dup(0)
    handle          dw 0
    longitud dw 0
    
    


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
        
        mouse_x dw 182
        mouse_y dw 58
        
        mouse_aux_x dw 0
        mouse_aux_y dw 0
        
        x_play dw 146
        y_play dw 60
        x_exit dw 146
        y_exit dw 140


;___________________________  Matrices para el menu ________________________
    
PLAY_WORD    db  1,1,1,1,0,0,0, 1,0,0,0,0,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1     
             db  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  0,1,0,1,0,0,0, 1,0,0,0,1
             db  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,1,0,1,0
             db  1,1,1,1,0,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0
             db  1,0,0,0,0,0,0, 1,0,0,0,0,0,0,  1,1,1,1,1,0,0, 0,0,1,0,0
             db  1,0,0,0,0,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0 
             db  1,0,0,0,0,0,0, 1,1,1,1,1,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0 
             
             
POINTS_WORD  db  1,1,1,1,0,0,0, 0,1,1,1,0,0,0,  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  1,1,1,1,1,0,0,  0,1,1,1,0
             db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0,  1,0,0,0,1
             db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,1,0,0,1,0,0,  0,0,1,0,0,0,0,  1,0,0,0,0
             db  1,1,1,1,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,1,0,1,0,0,  0,0,1,0,0,0,0,  0,1,1,1,0
             db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,1,1,0,0,  0,0,1,0,0,0,0,  0,0,0,0,1
             db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0,  1,0,0,0,1
             db  1,0,0,0,0,0,0, 0,1,1,1,0,0,0,  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0,  0,1,1,1,0
              
SPACE_WORD   db  0,1,1,1,0,0,0, 1,1,1,1,0,0,0,  0,0,1,0,0,0,0, 0,1,1,1,0,0,0,  1,1,1,1,1
             db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  0,1,0,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0
             db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,0
             db  0,1,1,1,0,0,0, 1,1,1,1,0,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,1,1,1,0
             db  0,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,1,1,1,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,0
             db  1,0,0,0,1,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0
             db  0,1,1,1,0,0,0, 1,0,0,0,0,0,0,  1,0,0,0,1,0,0, 0,1,1,1,0,0,0,  1,1,1,1,1 
             
EXIT_WORD    db  1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  0,1,1,1,0,0,0, 1,1,1,1,1
             db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
             db  1,0,0,0,0,0,0, 0,1,0,1,0,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
             db  1,1,1,1,0,0,0, 0,0,1,0,0,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0             
             db  1,0,0,0,0,0,0, 0,1,0,1,0,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
             db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 0,0,1,0,0
             db  1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  0,1,1,1,0,0,0, 0,0,1,0,0
     
SCORE_WORD   db  1,1,1,1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0      
             db  1,1,1,1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0 
             db  1,1,0,0,0,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1 
             db  1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 
             db  0,0,0,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 
             db  0,0,0,1,1,0, 1,1,0,0,0,0, 1,1,0,1,1,0, 1,1,0,0,0,0, 1,1,0,0,0 
             db  1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 
             db  1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 1,1,0,0,0,0, 1,1,1,1,1 

LIVES_WORD   db  1,1,0,0,0,0, 1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0      
             db  1,1,0,0,0,0, 1,1,0, 0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0,0 
             db  1,1,0,0,0,0, 0,0,0, 1,1,0,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,0,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,0,1,1,0, 1,1,0,1,1,0, 1,1,0,0,0 
             db  1,1,0,0,0,0, 1,1,0, 1,1,0,1,1,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,1,1,1,0, 1,1,1,1,1,0, 0,0,0,1,1 
             db  1,1,0,0,0,0, 1,1,0, 1,1,1,1,1,0, 1,1,0,0,0,0, 0,0,0,1,1 
             db  1,1,1,1,1,0, 1,1,0, 0,1,1,1,0,0, 1,1,1,1,1,0, 1,1,1,1,1 
             db  1,1,1,1,1,0, 1,1,0, 0,0,1,0,0,0, 1,1,1,1,1,0, 1,1,1,1,1 
             
INVADERS_WORD db  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 0,0,1,0,0,0,0, 1,1,1,1,0,0,0,  1,1,1,1,1,0,0,  1,1,1,1,0,0,0,  0,1,1,1,0
              db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 0,1,0,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,0,0,1,0,0,  1,0,0,0,1
              db  0,0,1,0,0,0,0, 1,1,0,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,0,0,1,0,0,  1,0,0,0,0
              db  0,0,1,0,0,0,0, 1,0,1,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,1,1,1,0,0,0,  1,1,1,1,0,0,0,  0,1,1,1,0
              db  0,0,1,0,0,0,0, 1,0,0,1,1,0,0,  1,0,0,0,1,0,0, 1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,1,0,0,0,0,  0,0,0,0,1
              db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  0,1,0,1,0,0,0, 1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0,  1,0,0,1,0,0,0,  1,0,0,0,1
              db  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  0,0,1,0,0,0,0, 1,0,0,0,1,0,0, 1,1,1,1,0,0,0,  1,1,1,1,1,0,0,  1,0,0,0,1,0,0,  0,1,1,1,0            

YOU_WORD       db  1,0,0,0,1,0,0, 0,1,1,1,1,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1
               db  0,1,0,1,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1
               db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1             
               db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1
               db  0,0,1,0,0,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1 
               db  0,0,1,0,0,0,0, 0,1,1,1,0,0,0,  0,1,1,1,0 
               
WIN_WORD       db  1,0,0,0,1,0,0, 0,1,1,1,0,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 0,0,1,0,0,0,0,  1,0,0,0,1
               db  1,0,0,0,1,0,0, 0,0,1,0,0,0,0,  1,1,0,0,1
               db  1,0,1,0,1,0,0, 0,0,1,0,0,0,0,  1,0,1,0,1             
               db  1,1,0,1,1,0,0, 0,0,1,0,0,0,0,  1,0,0,1,1
               db  1,0,0,0,1,0,0, 0,0,1,0,0,0,0,  1,0,0,0,1 
               db  1,0,0,0,1,0,0, 0,1,1,1,0,0,0,  1,0,0,0,1 
               
GAME_WORD      db  1,1,1,1,1,0,0, 0,0,1,0,0,0,0,  1,0,0,0,1,0,0, 1,1,1,1,1
               db  1,0,0,0,1,0,0, 0,1,0,1,0,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0
               db  1,0,0,0,0,0,0, 1,0,0,0,1,0,0,  1,1,0,1,1,0,0, 1,0,0,0,0
               db  1,0,1,1,1,0,0, 1,0,0,0,1,0,0,  1,0,1,0,1,0,0, 1,1,1,1,0             
               db  1,0,0,0,1,0,0, 1,1,1,1,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 1,0,0,0,0
               db  1,1,1,1,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,1,0,0, 1,1,1,1,1
               
OVER_WORD      db  0,1,1,1,0,0,0, 1,0,0,0,1,0,0,  1,1,1,1,1,0,0, 1,1,1,1,0
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0, 1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0, 1,0,0,0,1
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,1,1,1,0,0,0, 1,1,1,1,0             
               db  1,0,0,0,1,0,0, 1,0,0,0,1,0,0,  1,0,0,0,0,0,0, 1,0,1,0,0
               db  1,0,0,0,1,0,0, 0,1,0,1,0,0,0,  1,0,0,0,0,0,0, 1,0,0,1,0
               db  0,1,1,1,0,0,0, 0,0,1,0,0,0,0,  1,1,1,1,1,0,0, 1,0,0,0,1
               
GLYPH_EQUAL   db  0,0,0,0,0
              db  0,0,0,0,0
              db  1,1,1,1,1
              db  0,0,0,0,0             
              db  1,1,1,1,1
              db  0,0,0,0,0
              db  0,0,0,0,0
  

             
DIGIT_GLYPHS  db 0,1,1,1,0, 1,0,0,0,1, 1,0,0,0,1, 1,0,0,0,1, 1,0,0,0,1, 1,0,0,0,1, 0,1,1,1,0           
              db 0,0,1,0,0, 0,1,1,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,1,1,1,0              
              db 0,1,1,1,0, 1,0,0,0,1, 0,0,0,0,1, 0,0,0,1,0, 0,0,1,0,0, 0,1,0,0,0, 1,1,1,1,1  
              db 1,1,1,1,1, 0,0,0,0,1, 0,0,0,1,0, 0,0,1,1,0, 0,0,0,0,1, 1,0,0,0,1, 0,1,1,1,0  
              db 0,0,0,1,1, 0,0,1,0,1, 0,1,0,0,1, 1,1,1,1,1, 0,0,0,0,1, 0,0,0,0,1, 0,0,0,0,1               
              db 1,1,1,1,1, 1,0,0,0,0, 1,0,0,0,0, 1,1,1,1,1, 0,0,0,0,1, 0,0,0,0,1, 1,1,1,1,1               
              db 0,1,1,1,0, 1,0,0,0,1, 1,0,0,0,0, 1,1,1,1,0, 1,0,0,0,1, 1,0,0,0,1, 0,1,1,1,0               
              db 1,1,1,1,1, 0,0,0,0,1, 0,0,0,0,1, 0,0,0,0,1, 0,0,0,0,1, 0,0,0,0,1, 0,0,0,0,1               
              db 0,1,1,1,0, 1,0,0,0,1, 1,0,0,0,1, 0,1,1,1,0, 1,0,0,0,1, 1,0,0,0,1, 0,1,1,1,0              
              db 0,1,1,1,0, 1,0,0,0,1, 1,0,0,0,1, 0,1,1,1,1, 0,0,0,0,1, 0,0,0,0,1, 0,0,0,0,1
                
INVADER_A db 0,0,0,0,0,1,1,0,0,0,0,0
          db 0,0,0,0,1,1,1,1,0,0,0,0
          db 0,0,0,1,1,1,1,1,1,0,0,0
          db 0,0,1,1,0,1,1,0,1,1,0,0
          db 0,0,1,1,1,1,1,1,1,1,0,0
          db 0,0,0,0,1,0,0,1,0,0,0,0
          db 0,0,0,1,0,1,1,0,1,0,0,0
          db 0,0,1,0,1,0,0,1,0,1,0,0
          
INVADER_B db 0,0,0,0,1,1,1,1,0,0,0,0
          db 0,1,1,1,1,1,1,1,1,1,1,0
          db 1,1,1,1,1,1,1,1,1,1,1,1
          db 1,1,1,0,0,1,1,0,0,1,1,1
          db 1,1,1,1,1,1,1,1,1,1,1,1
          db 0,0,0,1,1,0,0,1,1,0,0,0
          db 0,0,1,1,0,1,1,0,1,1,0,0
          db 1,1,0,0,0,0,0,0,0,0,1,1
                    
INVADER_C db 0,0,1,0,0,0,0,0,1,0,0,0
          db 0,0,0,1,0,0,0,1,0,0,0,0
          db 0,0,1,1,1,1,1,1,1,0,0,0
          db 0,1,1,0,1,1,1,0,1,1,0,0
          db 1,1,1,1,1,1,1,1,1,1,1,0
          db 1,0,1,1,1,1,1,1,1,0,1,0
          db 1,0,1,0,0,0,0,0,1,0,1,0
          db 0,0,0,1,1,0,1,1,0,0,0,0
          
PLAYER    db 0,0,0,0,1,1,1,0,0,0,0
          db 0,0,0,1,0,0,0,1,0,0,0
          db 0,0,1,0,0,0,0,0,1,0,0
          db 1,1,1,1,1,1,1,1,1,1,1
          db 0,1,0,1,0,1,0,1,0,1,0
          db 0,0,1,1,1,1,1,1,1,0,0
          db 0,1,0,1,1,1,1,1,0,1,0
          db 1,0,0,0,0,1,0,0,0,0,1 
        
SHIELD    db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0
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
        
HIT       db 1,0,0,0,0,1,0,0,0,1,0,1
          db 0,0,0,1,0,0,0,1,0,0,0,0
          db 0,1,0,0,0,1,0,0,1,0,1,0
          db 0,0,0,0,0,0,0,1,0,0,0,1
          db 0,1,0,1,0,1,0,0,0,1,0,0
          db 0,0,0,0,0,0,0,0,1,0,0,1
          db 0,0,0,1,0,1,0,0,0,0,0,0
          db 1,0,0,0,0,0,0,1,0,0,1,0

        
PLAYER_SHOT    db 1
               db 1
               db 1
        
shields db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0, 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1, 1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
        db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0, 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1, 1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
        db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0, 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1, 1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
        db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0, 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1, 1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
        db 0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0, 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1, 1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
                                    
        


;----      Colors  ----


COLOR_A db 0CH
COLOR_B db 0AH
COLOR_C db 0BH
PLAYER_COLOR db 0FH
SHIELD_COLOR db 04H
SCORE_COLOR  db 0FH
HIT_COLOR    db 0

;----- Variables ------
video_mode db 0

;------Coordenadas ------
;?+
invaderA_x    dw 82
invaderA_y   dw 40  
invaderB_x    dw 82
invaderB_y    dw 52
invaderB2_y    dw 64
invaderC_x    dw 82
invaderC_y    dw 76  
invaderC2_y    dw 88 
player_x     dw 154
player_y      dw 180

player_shot_x dw 159
player_shot_y dw 176
invader_shot_x    dw 0
invader_shot_y    dw 0




shield1_x dw 70
shield2_x  dw 110
shield3_x  dw 150 
shield4_x dw 190 
shield5_x  dw 230 
shield_y  dw 150

impacter_x    dw 0
impacter_y    dw 0

lives_word_x    dw 205
lives_word_y    dw 5
live_x    dw 241
live_y     dw 7 

score_x dw 73
score_y dw 7 


invader_actual_y dw 0 

;+

; ------- Flags --------

isRightShift db 1
isInvaderShotActive db 0
isPlayerImpacter db 0
isLimitY db 0
isInvaderImpacter db 0
isPlayerShotActive db 0
;--------- count and other variables
num_shift db 12
score dw 0
temp_score dw 0
lives db 3
num_invaders dw 50
player_impacter_timer db 0
invader_impacter_timer db 0
position_shield dw 0
num_col_shield dw 0
last_row dw 4
num_loops dw 100
limit_y dw 141
state_row dw 0
state_col dw 0

invaders_state db 50 dup(1)


;keys

tecla_actual db 0
tecla_anterior db 0


DATASG ENDS


BUFFSEG SEGMENT PARA STACK 'BUFFER'  ; 'STACK' 
    db 64000 dup(0)
    db 1024 dup(0)  ; Margen de error (Slack)
BUFFSEG ENDS


;---------------------  Codigo -----------------
CODESG SEGMENT PARA 'CODE'

PRINCI PROC FAR
    ASSUME SS:STACKSG, DS:DATASG, CS:CODESG
    PUSH DS
    XOR AX,AX
    PUSH AX
    MOV AX, SEG DATASG
    MOV DS, AX

    obtener_modo_video ; obtiene el modo actual y lo guarda en al
    mov [video_mode],al
    call registerUser

APP_LOOP:    
    modo_video 13h
    call showMainMenu
    
    GAME_LOOP:
    ; leer_tecla
    call handleInput
    ;movimientos:
    call shiftInvaders
    call invaderShoot
    ;actualizar_la pantalla
    call drawToBuffer 
    call updateDisplay
    
    cmp isLimitY,1
    je game_over
    cmp lives,0
    je game_over
    cmp num_invaders, 0
    je you_win
    
    jmp GAME_LOOP
    
game_over:
    call gameOver
    jmp APP_LOOP
you_win:
    call youWin
    jmp APP_LOOP

    call exitToDos
    
   

PRINCI ENDP

;------------------------------------ Inicio de todos lo procedimientoos --------------------------------------

drawToBuffer proc
    limpiar_buffer
    dibujar_matriz SCORE_WORD, 35, 5, 29, 10, 0CH 
    dibujar_matriz LIVES_WORD, lives_word_x, 5, 26, 10, 0CH 
    call drawScore 
    call drawLives
    call drawInvadersA
    call drawInvadersB
    call drawInvadersC
    dibujar_matriz PLAYER, player_x, player_y, 11, 8, PLAYER_COLOR
    call drawShields
    call drawInvaderShoot
    call drawPlayerShoot 
    call drawColision
    call drawColisionPlayer
    RET
drawToBuffer endp

wait_vsync proc
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
wait_vsync endp

;--------------Procedimiento por si el jugador pierde -----------------
gameOver proc
push ax
        retardo 3,6000
        dibujar_matriz GAME_WORD,130,80,26,7,0EH
        dibujar_matriz OVER_WORD,166,80,26,7,0EH
        call updateDisplay
        retardo 8,6000
        call saveData
        MOV AH,07H      
        INT 21h 
        
        
pop ax      
    RET
gameOver endp

;------------------ Procedimiento por si el jugador gana ------------------
youWin proc
push ax
    retardo 3,6000
    dibujar_matriz YOU_WORD,130,70,19,7,0EH
    dibujar_matriz WIN_WORD,159,70,19,7,0EH
    call updateDisplay
    retardo 8,6000
    call saveData
    MOV AH,07H      
    INT 21h 

pop ax
    RET
youWin  endp

leftShiftPlayer proc

    cmp player_x,61
    jle isLeftOutOfRange
    sub player_x,5    
    isLeftOutOfRange:
        
    RET
leftShiftPlayer endp


rightShiftPlayer proc

    cmp player_x,247
    jge isRightOutOfRange
    add player_x,5
    isRightOutOfRange:
        
    RET
rightShiftPlayer endp


shiftInvaders proc
   call downShiftInvader
   
   cmp isRightShift,1
    je isRight
        call leftShiftInvader 
    jmp fin_shift
    isRight:
        call rightShiftInvader

    fin_shift:
        RET
shiftInvaders endp

leftShiftInvader proc


    sub invaderA_x,3
    sub invaderB_x,3
    sub invaderC_x,3
    dec num_shift
    cmp num_shift,0
    jne isLeft
        mov isRightShift,1
        mov num_shift,24

    isLeft:

    RET
leftShiftInvader endp

rightShiftInvader proc


    add invaderA_x,3
    add invaderB_x,3
    add invaderC_x,3
    dec num_shift
    cmp num_shift,0
    jne notIsLeft
        mov isRightShift,0
        mov num_shift,24

    notIsLeft:

    RET
rightShiftInvader endp

downShiftInvader proc
   dec num_loops
   cmp num_loops,0
   jne not_down
   
   mov num_loops,100
   add invaderA_y, 12
   add invaderB_y, 12
   add invaderB2_y, 12
   add invaderC_y, 12
   add invaderC2_y, 12
   call updatePositionYInvaders 
   cmp invader_actual_y,141
   jl not_down
   mov isLimitY, 1
   
not_down:
   
    RET
downShiftInvader endp

updatePositionYInvaders proc
push ax bx cx dx di es
    
    mov ax, ds
    mov es, ax
    
    
    mov ax, 10
    mul last_row
    lea di,invaders_state
    add di, ax
    
    mov al, 0
    mov cx,10
    cld
    REPE scasb
    jnz calculate_y
    
    cmp last_row,0
    je calculate_y
        dec last_row
calculate_y:
     cmp last_row, 4
    je row_4
    cmp last_row, 3
    je row_3
    cmp last_row, 2
    je row_2
    cmp last_row, 1
    je row_1
    cmp last_row, 0
    je row_0

row_4:
    mov bx, invaderC2_y
    jmp  udpate_row_actual
       
row_3:
    mov bx, invaderC_y
    jmp  udpate_row_actual
    
row_2:
    mov bx, invaderB2_y
jmp udpate_row_actual

row_1:
mov bx, invaderB_y
jmp  udpate_row_actual
row_0:
mov bx, invaderA_y
jmp udpate_row_actual

     

udpate_row_actual:
mov invader_actual_y,bx
pop es di dx cx bx ax 
   RET
updatePositionYInvaders endp

playerShoot proc
push ax bx 
cmp isPlayerShotActive, 1
je not_player_shot
    mov ax, player_y
    sub ax, 4            ; Aparece justo arriba de la nave
    mov player_shot_y,ax
    mov ax, player_x
    add ax, 5            ; Aparece justo arriba de la nave
    mov player_shot_x,ax
    mov isPlayerShotActive, 1
not_player_shot:
pop bx ax
RET
playerShoot endp


drawPlayerShoot proc
push ax bx 
  
    cmp isPlayerShotActive, 1
    je draw_shot_player
    jmp not_update_position
draw_shot_player:
    sub player_shot_y, 3
    cmp player_shot_y, 25
    jle shot_inactive
    calcular_posicion player_shot_x, player_shot_y
        mov al,es:[di]
        cmp al,0
        je draw_player_shot
        mov HIT_COLOR,al 
        call colision_invader
                            
shot_inactive:            
    mov isPlayerShotActive, 0  
    jmp   not_update_position 
draw_player_shot:
    cmp isPlayerShotActive, 0 
    je not_update_position 
        dibujar_matriz_negativo PLAYER_SHOT, player_shot_x, player_shot_y, 1, 3, 0dH
not_update_position  :
 pop bx ax
    RET
drawPlayerShoot endp

colision_invader proc 
push ax

    mov al,HIT_COLOR
    cmp al,COLOR_A
    je typeA
    cmp al,COLOR_B
    je typeB
    cmp al,COLOR_C
    je typeC
    cmp al,SHIELD_COLOR
    je shieldE
    jmp fin_colision
typeA:
    add score,30
    jmp draw_colision_color
typeB:
    add score,20
    jmp draw_colision_color
typeC:
    add score,10
draw_colision_color:
    
    dec num_invaders
    mov isInvaderImpacter, 1  
    call calcular_columna
    call calcular_fila
    call updateInvadersState
    call activeColision
    jmp fin_colision
shieldE:
    M_CalculateColumnShield player_shot_x
    M_UpadteShiel player_shot_x, player_shot_y
    
fin_colision:
    pop ax
    RET
    
colision_invader endp

updateInvadersState proc
push ax bx si dx
    
    mov bx,10
    mov ax,state_row
    mul bx
    mov si,ax
    add si,state_col
    mov al,0
    lea bx,invaders_state
    mov [bx][si], al
pop dx si bx ax 
    RET
updateInvadersState endp
activeColision proc
push ax bx dx  
    mov ax,state_col
    mov bx,16
    mul bx 
    add ax,invaderA_x
    mov impacter_x,ax
    
    mov ax,state_row
    mov bx,12
    mul bx 
    add ax,invaderA_y
    mov impacter_y,ax
    
    mov invader_impacter_timer,5
pop dx bx ax   
RET
activeColision endp

drawColision proc
push ax
    cmp isInvaderImpacter, 0
    je is_draw_impacter
    dec invader_impacter_timer
    mov al,invader_impacter_timer
    cmp al,0
    je not_draw_impacter
    dibujar_matriz HIT, impacter_x, impacter_y, 12, 8, 0Eh
    jmp is_draw_impacter
    
not_draw_impacter:
    mov isInvaderImpacter,0
is_draw_impacter:
pop ax   
    RET
drawColision endp

invaderShoot proc
push ax bx cx dx si 
    cmp isInvaderShotActive,1
    jne udpate_inv_shot
    jmp not_shoot
udpate_inv_shot:
    ramdon 0,50
    mov si,dx
    mov ax,dx
    xor dx,dx
    xor bx,bx
    mov bx,10
    div bx
    
    mov invader_shot_x,dx
    mov invader_shot_y,ax
 
    lea bx,invaders_state
    mov al, [bx][si]
    cmp al,0
    je not_shoot

    xor dx,dx
    xor ax,ax
    xor bx,bx
    
    mov ax,16
    mul invader_shot_x
    add ax,invaderA_x;variable_De inicio
    add ax,5
    mov invader_shot_x,ax
    xor dx,dx
    xor ax,ax
    xor bx,bx
    mov ax,12
    mul invader_shot_y 
    add ax,invaderA_y
    add ax,9
    mov invader_shot_y,ax
    mov isInvaderShotActive,1
not_shoot:
    pop si dx cx bx ax   
ret
invaderShoot endp

drawInvaderShoot proc
push ax bx cx dx bp si di 

  cmp isInvaderShotActive,0
  jne avanza 
  jmp fin_mover_bala
avanza:
  add invader_shot_y, 3
  cmp invader_shot_y, 190
  jge desactivar
  jmp seguiir_shoot
desactivar:
  jmp desactivar_bala

seguiir_shoot: 
             mov ax,SEG BUFFSEG
             mov es,ax
             calcular_posicion invader_shot_x, invader_shot_y
             mov al,es:[di]             
             cmp al,[PLAYER_COLOR]
             je colisionPlayer
             cmp al,[SHIELD_COLOR]
             je colisionEscudo   
             jmp fin_mover_bala
             
             
            colisionPlayer:
                cmp al, PLAYER_COLOR
                jne desactivar_bala_inv
                mov isPlayerImpacter,1
                mov player_impacter_timer, 5
                dec lives
            desactivar_bala_inv:
                jmp desactivar_bala
            colisionEscudo:
                M_CalculateColumnShield invader_shot_x
                M_UpadteShiel invader_shot_x, invader_shot_y
                
                desactivar_bala:
                mov isInvaderShotActive, 0
                    
                       
            fin_mover_bala:
                    cmp isInvaderShotActive, 1
                    jne jmp_draw_shoot
                dibujar_matriz_negativo PLAYER_SHOT, invader_shot_x, invader_shot_y, 1, 3, 0dH
            jmp_draw_shoot:
pop di si bp dx cx bx ax
ret
drawInvaderShoot endp

drawColisionPlayer proc
push ax
    cmp isPlayerImpacter, 1
    jne not_draw_impacter_player
    dec player_impacter_timer
    mov al,player_impacter_timer
    cmp al,0
    je update_is_impacter 
    dibujar_matriz HIT, player_x, player_y, 12, 8, 0Eh
update_is_impacter :
    mov isPlayerImpacter, 0
    not_draw_impacter_player:
pop ax
    RET
drawColisionPlayer endp

calcular_columna proc
push bx ax dx 
    mov ax, player_shot_x
    sub ax, invaderA_x
    xor dx,dx
    mov bx, 16
    div bx    ; AX = columna (0-9)
    mov state_col,ax
    
    pop dx ax bx
    ret
calcular_columna endp

calcular_fila proc
push bx ax dx
    mov ax, player_shot_y
    sub ax, invaderA_y
    xor dx,dx
    mov bx, 12
    div bx         ; AX = fila  (0-4)
    mov state_row,ax
    cmp ax,0
    jne sigueee
sigueee:
    pop dx ax bx
    ret
calcular_fila endp

drawInvadersA proc
push ax bx cx dx si

    mov cx,10

    lea si,invaders_state
    mov ax,invaderA_x
    mov dx,invaderA_y

    loop_invader_A:
        mov bl,[si]
        cmp bl,1
        jne invaderA_eliminado
        dibujar_matriz INVADER_A, invaderA_x, invaderA_y, 12, 8, COLOR_A
        
        invaderA_eliminado:
            inc si
            add invaderA_x,16
            loop loop_invader_A
            mov invaderA_x,ax
            mov invaderA_y,dx
pop si dx cx bx ax    
    RET
drawInvadersA endp

drawInvadersB proc
push ax bx cx dx si

    mov cx,20

    lea si,invaders_state
    add si,10
    mov ax,invaderB_x
    mov dx,invaderB_y

    loop_invader_B:
        mov bl,[si]
        cmp bl,1
        jne invaderB_eliminado
        dibujar_matriz INVADER_B, invaderB_x, invaderB_y, 12, 8, COLOR_B
        
        invaderB_eliminado:
            inc si
            add invaderB_x,16
            cmp cx,11
            jne renglonB1
            add invaderB_y, 12
            mov invaderB_x,ax
        renglonB1:
            loop loop_invader_B
            
            mov invaderB_x,ax
            mov invaderB_y,dx
    
pop si dx cx bx ax    
        RET
drawInvadersB endp

drawInvadersC proc
push ax bx cx dx si

    mov cx,20

    lea si, invaders_state
    add si, 30
    mov ax, invaderC_x
    mov dx, invaderC_y

    loop_invader_C:
        mov bl,[si]
        cmp bl,1
        jne invaderC_eliminado
        dibujar_matriz INVADER_C, invaderC_x, invaderC_y, 12, 8, COLOR_C
        
        invaderC_eliminado:
            inc si
            add invaderC_x,16
            cmp cx,11
            jne renglonC1
            add invaderC_y, 12
            mov invaderC_x,ax
        renglonC1:
            loop loop_invader_C
            mov invaderC_x,ax
            mov invaderC_y,dx
pop si dx cx bx ax    
        RET
drawInvadersC endp

drawShields proc

    dibujar_matriz shields[0],   shield1_x, shield_y, 17, 12, SHIELD_COLOR 
    dibujar_matriz shields[204], shield2_x, shield_y, 17, 12, SHIELD_COLOR
    dibujar_matriz shields[408], shield3_x, shield_y, 17, 12, SHIELD_COLOR
    dibujar_matriz shields[612], shield4_x, shield_y, 17, 12, SHIELD_COLOR
    dibujar_matriz shields[816], shield5_x, shield_y, 17, 12, SHIELD_COLOR
    RET
drawShields endp

drawScore proc
push ax bx cx dx si
    
    mov ax, score
    mov temp_score, ax
    mov cx,0
loop_to_split:
    xor dx, dx
    mov ax, temp_score
    mov bx, 10
    div bx              ; AX = Cociente, DX = Residuo
    mov temp_score, ax 
    push dx              ; Guardamos el d?gito (0-9)
    inc cx
    cmp ax, 0
    jne loop_to_split
    
    cmp cx,4
    je draw_four_digits
push_zero:
        inc cx
        mov dx,0
        push dx
        cmp cx,04
        jne push_zero
        
    draw_four_digits:    
        mov bx, score_x        

loop_draw_score:
    pop si
    call drawDigit; Lo dibujamos usando el Offset calculado 
    add score_x, 8           ; Separaci?n de 10 p?xeles entre n?meros
    loop loop_draw_score
    
    mov score_x,bx
    
    
    pop si dx cx bx ax

    RET
drawScore endp

drawDigit proc
push ax dx     
    mov ax, 35
    mul si
    mov si,ax
    dibujar_matriz DIGIT_GLYPHS[si], score_x, score_y, 5, 7, SCORE_COLOR
pop dx ax 
    RET
drawDigit endp

drawLives proc
push ax cx dx
    mov ax,live_x
    xor cx,cx
    mov cl,lives
    cmp cl,0
    je not_draw_lives
    
loop_draw_lives:
    dibujar_matriz PLAYER, live_x, live_y, 11, 8, PLAYER_COLOR
    add live_x,15
    loop loop_draw_lives
    mov live_x,ax
    
not_draw_lives:
pop dx cx ax    
    RET
drawLives endp

updateDisplay proc
    push ds es cx si di ax
    call wait_vsync
    mov ax,SEG BUFFSEG
    mov ds, ax
    xor si,si
    
    mov ax, 0A000h
    mov es,ax
    xor di, di              ; Empezamos en el p?xel 0,0

    mov cx, 32000           
    cld                     
    rep movsw               
    pop ax di si cx es ds 
    RET
updateDisplay endp


handleInput proc
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
        call playerShoot     
    jmp set_anterior
    
    no_disparo:
        cmp tecla_actual, 4Bh
        jne no_izq
        call leftShiftPlayer
        jmp set_anterior
        no_izq:
            cmp tecla_actual, 4Dh
            jne salida
            call rightShiftPlayer

set_anterior:
    mov bl,tecla_actual
    mov tecla_anterior, bl

sin_tecla:
    mov tecla_anterior, 0
salida:
    pop bx ax
    RET
handleInput endp



showMainMenu proc
push ax bx cx
    limpiar_modo_grafico
    limpiar_buffer
    call drawMenu
    call updateDisplay

    mostrar_puntero
    fijar_limites_verticales  190,0
    fijar_limites_horizontales  610,0
    mov ax,mouse_x
    shl ax,1
    mov mouse_aux_x,ax
    
    posicionar_puntero mouse_aux_x,mouse_y

    enmascarar_mouse mouse

    
rastrearMouse:   
    rastrear_mouse
            shr cx, 1
            mov mouse_x,cx
            mov mouse_y,dx
            cmp bx,1h
            jne rastrearMouse
            mov cx,mouse_x
            mov dx,mouse_y
            verificar_area_click x_play,y_play,play_base,play_altura
            cmp al, 1
            je iniciar_play
            mov cx,mouse_x
            mov dx,mouse_y
            verificar_area_click x_exit,y_exit,exit_base,exit_altura
            cmp al,1
            je EXIT
            jmp rastrearMouse
       
        EXIT:   
            ocultar_puntero
                limpiar_buffer
                habilitar_mouse 
                modo_video video_mode 
                ;call guardar_datos
                
                call exitToDos
                  
            iniciar_play:
                posicionar_puntero 0,0
                ocultar_puntero
                limpiar_buffer
                call updateDisplay
                call resetPlay
                retardo 04,60000
pop  cx bx ax 
    RET
showMainMenu endp

drawMenu proc

  dibujar_matriz SPACE_WORD, 110,30,33,7,0CH 
  dibujar_matriz INVADERS_WORD,152,30,54,7,0CH
  dibujar_matriz PLAY_WORD,146,60,26,7,0AH 
  ;invasorA
  dibujar_matriz INVADER_A,116,89,12,8,COLOR_A
  dibujar_matriz GLYPH_EQUAL,132,90,5,7,0EH
  dibujar_matriz DIGIT_GLYPHS[105],141,90,5,7,0EH
  dibujar_matriz DIGIT_GLYPHS,148,90,5,7,0EH
  dibujar_matriz POINTS_WORD,163,90,40,7,0EH
  
  ;invasorB
  dibujar_matriz INVADER_B,116,104,12,8,COLOR_B
  dibujar_matriz GLYPH_EQUAL,132,105,5,7,0EH
  dibujar_matriz DIGIT_GLYPHS[70],141,105,5,7,0EH
  dibujar_matriz DIGIT_GLYPHS,148,105,5,7,0EH
  dibujar_matriz POINTS_WORD,163,105,40,7,0EH
  ;invasorC
  dibujar_matriz INVADER_C,116,119,12,8,COLOR_C
  dibujar_matriz GLYPH_EQUAL,132,120,5,7,0EH
  dibujar_matriz DIGIT_GLYPHS[35],141,120,5,7,0EH
  dibujar_matriz DIGIT_GLYPHS,148,120,5,7,0EH
  dibujar_matriz POINTS_WORD,163,120,40,7,0EH
  
  dibujar_matriz EXIT_WORD,146,140,26,7,0dH  

  RET
drawMenu endp

resetPlay proc

mov video_mode, 0

;------Coordenadas ------
;?+
mov invaderA_x, 82
mov invaderA_y, 40  
mov invaderB_x, 82
mov invaderB_y, 52
mov invaderB2_y, 64
mov invaderC_x, 82
mov invaderC_y, 76  
mov invaderC2_y, 88 
mov player_x, 154
mov player_y, 180

mov player_shot_x, 159
mov player_shot_y, 176
mov invader_shot_x, 0
mov invader_shot_y, 0





mov impacter_x, 0
mov impacter_y, 0



mov invader_actual_y, 0 

;+

; ------- Flags --------

mov isRightShift,1
mov isInvaderShotActive, 0
mov isPlayerImpacter, 0
mov isLimitY, 0
mov isInvaderImpacter, 0
mov isPlayerShotActive, 0
;--------- count and other variables
mov num_shift, 12
mov score, 0
mov temp_score, 0
mov lives, 3
mov num_invaders, 50
mov player_impacter_timer, 0
mov invader_impacter_timer, 0
mov position_shield, 0
mov num_col_shield, 0
mov last_row, 4
mov num_loops, 100
mov limit_y, 141
mov state_row, 0
mov state_col, 0




;keys
call initInvaders
call initShields
mov tecla_actual, 0
mov tecla_anterior, 0

RET
resetPlay endp

initShields proc
push es ds si di cx

    push ds
    pop es
    lea di,shields
    mov cx,5
    copy_shield:
    push cx
    lea si,SHIELD
    mov cx,204
    cld
    rep movsb
    pop cx
    loop copy_shield
pop cx di si ds es
RET
initShields endp

initInvaders proc
push es ds  di cx


push ds
pop es
    lea di,invaders_state
    mov al,1
    mov cx,50
    cld 
    rep stosb

pop cx di  ds es
RET
initInvaders endp

registerUser proc
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
registerUser endp

saveData proc
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
    call convertir_score_a_texto
    copiar_cadena_con score_str

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

   
    ;imprimir_cadena msg_exito
    imprimir_cadena salto_linea
    jmp exit

error:
    imprimir_cadena msg_error
    imprimir_cadena salto_linea

exit:
    pop es ds dx cx bx ax
        ret
saveData endp

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

convertir_score_a_texto proc
push ax bx dx si

    mov ax, score         
    mov bx, 10             
    
    
    lea si, score_str
    add si, 3             

loop_conversion_txt:
    xor dx, dx             
    div bx                 
    
    add dl, 30h            
    mov [si], dl           
    
    dec si                 
    
    cmp ax, 0              ; ¿Ya terminamos de dividir todo el número?
    jne loop_conversion_txt 

 

pop si dx bx ax
    RET
convertir_score_a_texto endp

exitToDos proc
push ax
    mov ah,4CH  
    INT 21h
pop ax
    RET
exitToDos endp

CODESG ENDS

END PRINCI
