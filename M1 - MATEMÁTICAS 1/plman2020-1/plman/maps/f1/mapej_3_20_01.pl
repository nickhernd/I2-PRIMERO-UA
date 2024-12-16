%3
map_format_version(1.1).
load_behaviour(password).
load_behaviour(enemyBasicMovement).
map([
'#######################',
'###..............#....#',
'# #..............#....#',
'#..####    ###...#....#',
'#...........##........#',
'#...........######....#',
'#######################'
]).

map_size(23,7).
num_dots(79).
pacman_start(1, 3).
initMap:- 
	addSolidObject('#'), 
    maplist(write,  ['Complete the password at PPPP to open the door. '
                    ,'Digits change when an entity or an object is in front.\n']),
	createGameEntity(EID_6, 'E', mortal, 10, 2, active, enemyBasicMovement,
        [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_6, left-right, ['#','|']), 

	createGameEntity(EID_0, '#', object, 0, 0, active, passwordChecker, []),
	createGameEntity(EID_1, 'P', object, 7, 3, active, passwordDigit, 
                [name(digit1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Modifiable Digit 1')]),
	createGameEntity(EID_2, 'P', object, 8, 3, active, passwordDigit, 
                [name(digit2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Modifiable Digit 2')]),
	createGameEntity(EID_3, 'P', object, 9, 3, active, passwordDigit, 
                [name(digit3), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Modifiable Digit 3')]),
	createGameEntity(EID_4, 'P', object, 10 , 3, active, passwordDigit, 
                [name(digit4), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Modifiable Digit 4')]),
	
        passwordDigit(init, EID_1, [ digits([o]), switchPos(7,4) ]),
        passwordDigit(init, EID_2, [ digits([p]), switchPos(8,4) ]),
        passwordDigit(init, EID_3, [ digits([e]), switchPos(9,4) ]),
        passwordDigit(init, EID_4, [ digits([n]), switchPos(10,4) ]),
        passwordChecker(init, EID_0, [ passwordDigits([EID_1, EID_2, EID_3, EID_4]), password(1465401285),
                                       action('pl-man':destroyGameEntity(EID_4)) ] ).
 
