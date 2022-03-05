; keypad.bas 
; based on keypad_test.bas by Michael Rideout (SeaGtGruff)
; modified by Curtis F Kaylor (CurtisP)
; read keypad controllers in batari Basic

keypad_read SUBROUTINE

 ifconst keypad_left
   LDX #%11100000
 else
 ifconst keypad_right
   LDX #%00001110
 else
   LDX #%11101110
 endif
 endif
   STX SWCHA

   LDX #93	;2
.keyloop1
   DEX		;2
   BNE .keyloop1 ;3

   LDA #0
   LDY #0

 ifnconst keypad_right

   LDX INPT0
   BMI .check_left_2

   LDA #1

 endif

.check_left_2

 ifnconst keypad_right

   LDX INPT1
   BMI .check_left_3

   LDA #2

  endif

.check_left_3

 ifnconst keypad_right

   LDX INPT4
   BMI .check_right_1

   LDA #3

 endif

.check_right_1

 ifnconst keypad_left

   LDX INPT2
   BMI .check_right_2

   LDY #16

 endif

.check_right_2

 ifnconst keypad_left

   LDX INPT3
   BMI .check_right_3

   LDY #32

 endif

.check_right_3

 ifnconst keypad_left

   LDX INPT5
   BMI .check_left_4

   LDY #48

 endif

.check_left_4

 ifconst keypad_left
   LDX #%11010000
 else
 ifconst keypad_right
   LDX #%00001101
 else
   LDX #%11011101
 endif
 endif
   STX SWCHA

   LDX #93	;2
.keyloop2
   DEX		;2
   BNE .keyloop2 ;3

 ifnconst keypad_right

   LDX INPT0
   BMI .check_left_5

   LDA #4

 endif

.check_left_5

 ifnconst keypad_right

   LDX INPT1
   BMI .check_left_6

   LDA #5

 endif

.check_left_6

 ifnconst keypad_right

   LDX INPT4
   BMI .check_right_4

   LDA #6

 endif

.check_right_4

 ifnconst keypad_left

   LDX INPT2
   BMI .check_right_5

   LDY #64

 endif

.check_right_5

 ifnconst keypad_left

   LDX INPT3
   BMI .check_right_6

   LDY #80

 endif

.check_right_6

 ifnconst keypad_left

   LDX INPT5
   BMI .check_left_7

   LDY #96

  endif

.check_left_7

 ifconst keypad_left
   LDX #%10110000
 else
 ifconst keypad_right
   LDX #%00001011
 else
   LDX #%10111011
 endif
 endif
   STX SWCHA

   LDX #93	;2
.keyloop3
   DEX		;2
   BNE .keyloop3 ;3

 ifnconst keypad_right

   LDX INPT0
   BMI .check_left_8

   LDA #7

 endif

.check_left_8

 ifnconst keypad_right

   LDX INPT1
   BMI .check_left_9

   LDA #8

 endif

.check_left_9

 ifnconst keypad_right

   LDX INPT4
   BMI .check_right_7

   LDA #9

 endif

.check_right_7

 ifnconst keypad_left

   LDX INPT2
   BMI .check_right_8

   LDY #112

 endif

.check_right_8

 ifnconst keypad_left

   LDX INPT3
   BMI .check_right_9

   LDY #128

 endif

.check_right_9

 ifnconst keypad_left

   LDX INPT5
   BMI .check_left_10

   LDY #144

 endif

.check_left_10

 ifconst keypad_left
   LDX #%01110000
 else
 ifconst keypad_right
   LDX #%00000111
 else
   LDX #%01110111
 endif
 endif
   STX SWCHA

   LDX #93	;2
.keyloop4
   DEX		;2
   BNE .keyloop4 ;3

 ifnconst keypad_right

   LDX INPT0
   BMI .check_left_11

   LDA #10

 endif

.check_left_11

 ifnconst keypad_right

   LDX INPT1
   BMI .check_left_12

   LDA #11

 endif

.check_left_12

 ifnconst keypad_right

   LDX INPT4
   BMI .check_right_10

   LDA #12

 endif

.check_right_10

 ifnconst keypad_left

   LDX INPT2
   BMI .check_right_11

   LDY #160

 endif

.check_right_11

 ifnconst keypad_left

   LDX INPT3
   BMI .check_right_12

   LDY #176

 endif 

.check_right_12

 ifnconst keypad_left

   LDX INPT5
   BMI keypad_store

   LDY #192

 endif

keypad_store SUBROUTINE

; 
   LDX #%11111111
   STX SWCHA
;   
   STA keypads
   TYA
   ORA keypads
   STA keypads

   RTS

0.keypad_setup
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
   RTS
