%1
map_format_version(1.1).
load_behaviour(enemyBasicMovement).
load_behaviour(basicDoorKey).
load_behaviour(password).
load_behaviour(gunBasic).

map([
'########pasa#',
'# ... #.....#',
'p ....#.....#',
'# ....#.....#',
'# ....##    #',
'a ....     .#',
'# ...      .#',
'# ...      .#',
's ...      .#',
'# ...      .#',
'# ....      #',
'a ....      #',
'#############'
]).

map_size(13,13).
num_dots(59).
pacman_start(1, 1).
initMap:- 
	addSolidObject('#'), 
  addSolidObject('p'), 
  addSolidObject('a'), 
  addSolidObject('s'), 
  addSolidObject('a'), 
    	createGameEntity(OID, '¬', object, 5, 1, inactive, norule, 
      	 [name(pistola), solid(false), static(false), use_rule(gunBasic), 
	  description('Derringer'), appearance(attribs(bold,cyan,default))]),
	gunBasic(init, OID, 2, ['E'], destroy),

	createGameEntity(EID_6, 'E', mortal, 5, 7, active, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_6, up-down, ['#','|']), 
	createGameEntity(EID_7, 'E', mortal, 6, 5, active, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_7, left-right, ['#','2']), 
	createGameEntity(EID_8, 'E', mortal, 7, 8, active, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_8, left-right, ['#','3']), 
	createGameEntity(EID_9, 'E', mortal, 8, 11, active, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_9, left-right, ['#','4']), 

   createGameEntity(_, '1', object, 0, 2, inactive, norule,
                  [name(pw_digit_changer_1), solid(true), static(true), use_rule(norule), 
                  description('Password Digit Changer (1)'), appearance(attribs(normal,black,white))]),
   createGameEntity(_, '2', object, 0, 5, inactive, norule,
                  [name(pw_digit_changer_2), solid(true), static(true), use_rule(norule), 
                  description('Password Digit Changer (2)'), appearance(attribs(normal,black,white))]),
   createGameEntity(_, '3', object, 0, 8, inactive, norule,
                  [name(pw_digit_changer_3), solid(true), static(true), use_rule(norule), 
                  description('Password Digit Changer (3)'), appearance(attribs(normal,black,white))]),
   createGameEntity(_, '4', object, 0, 11, inactive, norule,
                  [name(pw_digit_changer_4), solid(true), static(true), use_rule(norule), 
                  description('Password Digit Changer (4)'), appearance(attribs(normal,black,white))]),

	createGameEntity(EID_0, '#', object, 0, 0, active, passwordChecker, []),
	createGameEntity(EID_1, ' ', object, 8, 4, active, passwordDigit, 
                [name(digito1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Digito modificable 1')]),
	createGameEntity(EID_2, ' ', object, 9, 4, active, passwordDigit, 
                [name(digito2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Digito modificable 2')]),
	createGameEntity(EID_3, ' ', object, 10, 4, active, passwordDigit, 
                [name(digito1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Digito modifica ble 3')]),
	createGameEntity(EID_4, ' ', object, 11 , 4, active, passwordDigit, 
                [name(digito2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Digito modificable 4')]),

	
        passwordDigit(init, EID_1, [ digits([p]), switchPos(1,2) ]),
        passwordDigit(init, EID_2, [ digits([a]), switchPos(1,5) ]),
        passwordDigit(init, EID_3, [ digits([s,1,2,3]), switchPos(1,8) ]),
        passwordDigit(init, EID_4, [ digits([a,2,3,4]), switchPos(1,11) ]),
        passwordChecker(init, EID_0, [ passwordDigits([EID_1, EID_2, EID_3, EID_4]), password(1871557837),
                                       action('pl-man':destroyGameEntity(EID_4)) ] ).
 
norule(_).