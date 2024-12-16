%2
map_format_version(1.1).
load_behaviour(password).
map([
'##############',
'#...........##',
'########    ##',
'#            #',
'##############'
]).

map_size(14,5).
num_dots(11).
pacman_start(1, 3).
initMap:- 
	addSolidObject('#'), 
    maplist(write,  ['Complete the password at PPPP to open the door. '
                    ,'Digits change when an entity or an object is in front.\n']),
	createGameEntity(EID_0, '#', object, 0, 0, active, passwordChecker, []),
	createGameEntity(EID_1, 'P', object, 8, 2, active, passwordDigit, 
                [name(digit1), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Modifiable digit 1')]),
	createGameEntity(EID_2, 'P', object, 9, 2, active, passwordDigit, 
                [name(digit2), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Modifiable digit 2')]),
	createGameEntity(EID_3, 'P', object, 10, 2, active, passwordDigit, 
                [name(digit3), solid(true), static(true), appearance(attribs(normal, black, white)), 
                 description('Modifiable digit 3')]),
	createGameEntity(EID_4, 'P', object, 11 , 2, active, passwordDigit, 
                [name(digit4), solid(true), static(true), appearance(attribs(normal, black, white)),
                 description('Modifiable digit 4')]),
        passwordDigit(init, EID_1, [ digits([o]), switchPos(8,3) ]),
        passwordDigit(init, EID_2, [ digits([p]), switchPos(9,3) ]),
        passwordDigit(init, EID_3, [ digits([e]), switchPos(10,3) ]),
        passwordDigit(init, EID_4, [ digits([n]), switchPos(11,3) ]),
        passwordChecker(init, EID_0, [ passwordDigits([EID_1, EID_2, EID_3, EID_4]), password(1465401285),
                                       action('pl-man':destroyGameEntity(EID_4)) ] ).
 
