 rem    ___            _      _             _   _    _                  _
 rem   |   \ _  _ __ _| |  _ | |___ _  _ __| |_(_)__| |__  __ _ _ _  __| |
 rem   | |) | || / _` | | | || / _ \ || (_-<  _| / _| / / / _` | ' \/ _` |
 rem   |___/ \_,_\__,_|_|  \__/\___/\_, /__/\__|_\__|_\_\ \__,_|_||_\__,_|
 rem    _  __         _             |__/     _   _          _             
 rem   | |/ /___ _  _| |__  ___  __ _ _ _ __| | | |_ ___ __| |_ ___ _ _   
 rem   | ' </ -_) || | '_ \/ _ \/ _` | '_/ _` | |  _/ -_|_-<  _/ -_) '_|  
 rem   |_|\_\___|\_, |_.__/\___/\__,_|_| \__,_|  \__\___/__/\__\___|_|    
 rem             |__/                                                     
 rem
 rem   Danjovic 2022 
 rem   Written to support the Wolf and Hammer dual joystick adapters
 rem 

 set tv ntsc
 set romsize 4k 

   macro setplayer0xy
   player0x={1}
   player0y={2}
end

   def p0xy=callmacro setplayer0xy

   macro setplayer1xy
   player1x={1}
   player1y={2}
end

   def p1xy=callmacro setplayer1xy


 rem    _____ _ _   _       ___                      
 rem   |_   _(_) |_| |___  / __| __ _ _ ___ ___ _ _  
 rem     | | | |  _| / -_) \__ \/ _| '_/ -_) -_) ' \ 
 rem     |_| |_|\__|_\___| |___/\__|_| \___\___|_||_|
 rem   
titleScreen                                              

 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ................................
 ................................
 XXX.XXX.X.X.X.X.XXX..XXX.XXX.XXX
 ..X.X.X.X.X.X.X.X.X...X..X....X.
 X.X.X.X.XXX.XX..XX....X..XXX..X.
 X.X.X.X..X..X.X.X.X...X....X..X.
 XXX.XXX..X..X.X.XXX...X..XXX..X.
 ................................
 ................................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end


title

 COLUBK = $02
 COLUPF = $96
 scorecolor = $02
 
 drawscreen

 if switchselect then goto mainProgram
 goto title




 rem    __  __      _                                          
 rem   |  \/  |__ _(_)_ _    _ __ _ _ ___  __ _ _ _ __ _ _ __  
 rem   | |\/| / _` | | ' \  | '_ \ '_/ _ \/ _` | '_/ _` | '  \ 
 rem   |_|  |_\__,_|_|_||_| | .__/_| \___/\__, |_| \__,_|_|_|_|
 rem                        |_|           |___/                

mainProgram


 rem initialize variables and parameters

 dim x0           = a
 dim y0           = b
 dim x1           = c
 dim y1           = d
 dim rowNumber    = e
 dim mode         = f
 dim keypads      = g
 dim left_keypad  = h
 dim right_keypad = i
 
 
 missile0height   = 4
 missile1height   = 4
 
 inline keysetup.asm 


  player0:
  %00111100
  %01111110
  %01111110
  %00111100
end

  player1:
  %00111100
  %01111110
  %01111110
  %00111100
end

 rem use DIFFICULTY switches to select whether function to perform 
 mode = 0
 if switchleftb  then mode = mode + 2
 if switchrightb then mode = mode + 1
 rem if switchbw then mode = 5         : rem SNES
 
 on mode goto  __DrawJoyL_JoyR  __DrawJoyL_KeyR __DrawKeyL_JoyR __DrawKeyL_KeyR
 
 
 rem ******************* main loop ******************** 
main 

 COLUPF = $96 : rem playfield color
 COLUBK = $02 : rem background color 
 COLUP0 = $1c : COLUP1 = $30 : rem player/misile colors
 NUSIZ0 = $20 : NUSIZ1 = $20 : rem 4 pixel wide missiles  
 
 score = 0 : rem initialize score

 on mode gosub  __JoyL_JoyR  __JoyL_KeyR __KeyL_JoyR __KeyL_KeyR

 
 drawscreen
 
 if switchreset then goto titleScreen
 goto main




 rem            _                 _   _             
 rem    ____  _| |__ _ _ ___ _  _| |_(_)_ _  ___ ___
 rem   (_-< || | '_ \ '_/ _ \ || |  _| | ' \/ -_|_-<
 rem   /__/\_,_|_.__/_| \___/\_,_|\__|_|_||_\___/__/
 rem                                                

 rem ***************** Startup option ***************** 

__JoyL_JoyR 
  scorecolor = $b6 
  gosub  __Joystick0
  gosub  __Joystick1
  return

__JoyL_KeyR 
  scorecolor = $b6 
  gosub  __Joystick0
  gosub  __Keyboard1
  return
  
__KeyL_JoyR 
  scorecolor = $b6 
  gosub  __Keyboard0
  gosub  __Joystick1
  return
  
__KeyL_KeyR
  scorecolor = $02
  gosub  __Keyboard0
  gosub  __Keyboard1
  return



 rem ******************** Keyboard ******************** 

__Keyboard0
 rowNumber   = 0 : rem initialize keypad row number 
 left_keypad = keypads && %00001111

 missile0x = horz0[left_keypad] 
 missile0y = vert[left_keypad]

 return
 
__Keyboard1
 rowNumber   = 0 : rem initialize keypad row number
 right_keypad = keypads / 16
 
 missile1x = horz1[right_keypad] 
 missile1y = vert[right_keypad]
 
 return
 
 data horz0
 0, 32, 48, 64,  32, 48, 64,  32, 48, 64,  32, 48, 64 
end

 data horz1
 0, 96, 112, 128, 96, 112, 128, 96, 112, 128, 96, 112, 128
end


 data vert
 99, 22, 22, 22, 38, 38, 38, 54, 54, 54, 70, 70, 70 
end



 rem ******************** Joystick ********************

__Joystick0
     x0 = 48 :  y0 = 62 : rem initialize position
     
     if joy0up    then y0 = y0 - 10 : rem test the controller
     if joy0down  then y0 = y0 + 10 
     if joy0left  then x0 = x0 - 10
     if joy0right then x0 = x0 + 10
     
     missile0x = x0 :   missile0y = y0 : rem position the missile accordingly
     
     if ! joy0fire then score = score + 100000 : rem fire button
     if INPT1{7}   then score = score + 010000 : rem Booster (thumb) button 
     if INPT0{7}   then score = score + 001000 : rem Trigger button

     if joy0fire then  p0xy 30 46 else p0xy 0 0  
     if INPT1{7}  then  pfpixel  8 1 on  else pfpixel  8 1 off 
     if INPT0{7}  then  pfpixel 11 2 on  else pfpixel 11 2 off 

  return

__Joystick1
     x1 = 112 :  y1 = 62 : rem initialize position
     
     if joy1up    then y1 = y1 - 10 : rem test the controller
     if joy1down  then y1 = y1 + 10 
     if joy1left  then x1 = x1 - 10
     if joy1right then x1 = x1 + 10
     
     missile1x = x1 :   missile1y = y1 : rem position the missile accordingly
     
     if ! joy1fire then score = score + 000100 : rem fire button
     if INPT3{7}   then score = score + 000010 : rem Booster (thumb) button 
     if INPT2{7}   then score = score + 000001 : rem Trigger button

     if joy1fire then  p1xy 94 46 else p1xy 0 0 
     if INPT3{7}   then pfpixel 24 1 on  else pfpixel 24 1 off  
     if INPT2{7}   then pfpixel 27 2 on  else pfpixel 27 2 off 

  return


 rem ******************* Playfields *******************

__DrawJoyL_JoyR
 playfield:
 ................................
 .......X.XXXX..........X.XXXX...
 .......XXXX.X..........XXXX.X...
 .......XXX.............XXX......
 .......XX..............XX.......
 ...XXX.XX.XXX......XXX.XX.XXX...
 ...X...XX...X......X...XX...X...
 ...X...XX...X......X...XX...X...
 ...X........X......X........X...
 ...XXXXXXXXXX......XXXXXXXXXX...
 ................................
 ................................
end
 goto main
 
__DrawJoyL_KeyR
 playfield: 
 ................................
 .......X.XXXX.....XXXXXXXXXXXX..
 .......XXXX.X.....X..XX..XX..X..
 .......XXX........XXXXXXXXXXXX..
 .......XX.........X..XX..XX..X..
 ...XXX.XX.XXX.....XXXXXXXXXXXX..
 ...X...XX...X.....X..XX..XX..X..
 ...X...XX...X.....XXXXXXXXXXXX..
 ...X........X.....X..XX..XX..X..
 ...XXXXXXXXXX.....XXXXXXXXXXXX..
 ................................
 ................................
end
 goto main

__DrawKeyL_JoyR
 playfield:
 ................................
 ..XXXXXXXXXXXX.........X.XXXX...
 ..X..XX..XX..X.........XXXX.X...
 ..XXXXXXXXXXXX.........XXX......
 ..X..XX..XX..X.........XX.......
 ..XXXXXXXXXXXX.....XXX.XX.XXX...
 ..X..XX..XX..X.....X...XX...X...
 ..XXXXXXXXXXXX.....X...XX...X...
 ..X..XX..XX..X.....X........X...
 ..XXXXXXXXXXXX.....XXXXXXXXXX...
 ................................
 ................................
end
 goto main

__DrawKeyL_KeyR
 playfield:
 ................................
 ..XXXXXXXXXXXX....XXXXXXXXXXXX..
 ..X..XX..XX..X....X..XX..XX..X..
 ..XXXXXXXXXXXX....XXXXXXXXXXXX..
 ..X..XX..XX..X....X..XX..XX..X..
 ..XXXXXXXXXXXX....XXXXXXXXXXXX..
 ..X..XX..XX..X....X..XX..XX..X..
 ..XXXXXXXXXXXX....XXXXXXXXXXXX..
 ..X..XX..XX..X....X..XX..XX..X..
 ..XXXXXXXXXXXX....XXXXXXXXXXXX..
 ................................
 ................................
end
 goto main



 rem        _    _           _   
 rem   __ _| |__| |__ _ _ _ | |__
 rem   \ V / '_ \ / _` | ' \| / /
 rem    \_/|_.__/_\__,_|_||_|_\_\
 rem                             
 vblank
 inline keyread.asm

 