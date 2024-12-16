
%4
map_format_version(1.1).
load_behaviour(enemyBasicMovement).
load_behaviour(basicDoorKey).
load_behaviour(password).
load_behaviour(gunBasic).

map([
'##################pa#sa########',
'# ...#..............#.........#',
'#....#........................#',
'#....#...... .................#',
'##.###........................#',
'#....#........................#',
'#...................#.........#',
'###############################'
]).

map_size(31,8).
num_dots(159).
pacman_start(13, 3).
initMap:- 
	addSolidObject('#'), 
   addSolidObject('p'), 
   addSolidObject('a'), 
   addSolidObject('s'), 
   addSolidObject('a'), 


    	createGameEntity(OID, '¬', object, 1, 1, inactive, norule, 
      	 [name(pistola), solid(false), static(false), use_rule(gunBasic), 
	  description('Derringer'), appearance(attribs(bold,cyan,default))]),
	gunBasic(init, OID, 4, ['E'], destroy),

	createGameEntity(EID_5, 'E', mortal, 20, 2, inactive, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_5, up-down, ['#','|']), 
	createGameEntity(EID_6, 'E', mortal, 20, 3, inactive, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_6, up-down, ['#','|']), 
	createGameEntity(EID_7, 'E', mortal, 20, 4, inactive, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_7, up-down, ['#','|']), 
	createGameEntity(EID_8, 'E', mortal, 20, 5, inactive, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_8, up-down, ['#','|']), 
	createGameEntity(EID_9, 'E', mortal, 24, 6, active, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_9, up-down, ['#','|']), 
	createGameEntity(EID_11, 'E', mortal, 28, 6, active, enemyBasicMovement,
      [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_11, up-down, ['#','|']), 


	createGameEntity(EID_0, '#', object, 1, 0, active, passwordChecker, []),
	createGameEntity(EID_1, ' ', object, 21, 2, active, passwordDigit, 
                [name(digito1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Digito modificable 1')]),
	createGameEntity(EID_2, ' ', object, 21, 3, active, passwordDigit, 
                [name(digito2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Digito modificable 2')]),
	createGameEntity(EID_3, ' ', object, 21, 4, active, passwordDigit, 
                [name(digito1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Digito modifica ble 3')]),
	createGameEntity(EID_4, ' ', object, 21 , 5, active, passwordDigit, 
                [name(digito2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Digito modificable 4')]),

	
        passwordDigit(init, EID_1, [ digits([p,2]), switchPos(20,2) ]),
        passwordDigit(init, EID_2, [ digits([1,a]), switchPos(20,3) ]),
        passwordDigit(init, EID_3, [ digits([s,2]), switchPos(20,4) ]),
        passwordDigit(init, EID_4, [ digits([1,a]), switchPos(20,5) ]),
        passwordChecker(init, EID_0, [ passwordDigits([EID_1, EID_2, EID_3, EID_4]), password(1871557837),
                                       action('pl-man':destroyGameEntity(EID_4)) ] ).
 
