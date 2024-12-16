%2
map_format_version(1.1).
load_behaviour(enemyBasicMovement).
load_behaviour(basicDoorKey).
load_behaviour(password).

map([
'#############',
'# ....#.....p',
'#.....#.....a',
'#.....#.....s',
'#.....##### a',
'# ..........#',
'########## ##',
'1....      .4',
'#...........#',
'#    . .....#',
'#...........#',
'#...........#',
'#2#########3#'
]).

map_size(13,13).
num_dots(86).
pacman_start(1, 1).
initMap:- 
	addSolidObject('#'), 
    addSolidObject('p'), 
    addSolidObject('a'), 
    addSolidObject('s'), 
    addSolidObject('a'), 

	createGameEntity(EID_6, 'E', mortal, 5, 7, active, enemyBasicMovement,
        [appearance(attribs(normal,red,default))]), 
	enemyBasicMovement(init, EID_6, up-down, ['#','|']), 

    createGameEntity(OID_K2, 'k', object, 1, 5, inactive, norule, 
	   [ name(key), solid(false), static(false), use_rule(basicDoorKey), 
	   description('white key'), appearance(attribs(normal, white, default)) ]),
    createGameEntity(OID_D3, '-', object, 10, 6, inactive, norule, 
	   [ name(door), solid(true), static(true), use_rule(norule), 
	   description('white door'), appearance(attribs(bold, white, default)) ]),
    basicDoorKey(init, OID_D3, [ 'pl-man':destroyGameEntity(OID_D3)  ], [ OID_K2 ]),

    createGameEntity(OID_K3, 'l', object, 6, 9, inactive, norule, 
	   [ name(key), solid(false), static(false), use_rule(basicDoorKey), 
	   description('white key'), appearance(attribs(normal, red, default)) ]),
    createGameEntity(OID_D2, '-', object, 11, 4, inactive, norule, 
	   [ name(door), solid(true), static(true), use_rule(norule), 
	   description('white door'), appearance(attribs(bold, red, default)) ]),
    basicDoorKey(init, OID_D2, [ 'pl-man':destroyGameEntity(OID_D2)  ], [ OID_K3 ]),

    createGameEntity(_, '1', object, 0, 7, inactive, norule, 
        [ name(pw_digit_changer_1), solid(false), static(false), use_rule(basicDoorKey), 
        description('Password Digit Changer (1)'), appearance(attribs(normal, black, white)) ]),
    createGameEntity(_, '2', object, 1, 12, inactive, norule, 
        [ name(pw_digit_changer_2), solid(false), static(false), use_rule(basicDoorKey), 
        description('Password Digit Changer (2)'), appearance(attribs(normal, black, white)) ]),
    createGameEntity(_, '3', object, 11, 12, inactive, norule, 
        [ name(pw_digit_changer_3), solid(false), static(false), use_rule(basicDoorKey), 
        description('Password Digit Changer (3)'), appearance(attribs(normal, black, white)) ]),
    createGameEntity(_, '4', object, 12,  7, inactive, norule, 
        [ name(pw_digit_changer_4), solid(false), static(false), use_rule(basicDoorKey), 
        description('Password Digit Changer (4)'), appearance(attribs(normal, black, white)) ]),

	createGameEntity(EID_0, '#', object, 1, 0, active, passwordChecker, []),
	createGameEntity(EID_1, ' ', object, 10, 1, active, passwordDigit, 
                [name(digit1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Switchable digit 1')]),
	createGameEntity(EID_2, ' ', object, 10, 2, active, passwordDigit, 
                [name(digit2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Switchable digit 2')]),
	createGameEntity(EID_3, ' ', object, 10, 3, active, passwordDigit, 
                [name(digit1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Switchable digit 3')]),
	createGameEntity(EID_4, ' ', object, 10 , 4, active, passwordDigit, 
                [name(digit2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Switchable digit 4')]),

	
        passwordDigit(init, EID_1, [ digits([p]), switchPos(1,7) ]),
        passwordDigit(init, EID_2, [ digits([a]), switchPos(1,11) ]),
        passwordDigit(init, EID_3, [ digits([s]), switchPos(11,11) ]),
        passwordDigit(init, EID_4, [ digits([a]), switchPos(11,7) ]),
        passwordChecker(init, EID_0, [ passwordDigits([EID_1, EID_2, EID_3, EID_4]), password(1871557837),
                                       action('pl-man':destroyGameEntity(EID_1)) ] ).
 
