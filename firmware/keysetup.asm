 ifconst keypad_left
   LDA #%11110000
 else
 ifconst keypad_right
   LDA #%00001111
 else
   LDA #%11111111
 endif
 endif
   STA SWACNT

