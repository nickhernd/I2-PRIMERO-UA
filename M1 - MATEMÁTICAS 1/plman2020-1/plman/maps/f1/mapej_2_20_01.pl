map_format_version(1.1).
load_behaviour(password).
map([
'###########',
'#.........#',
'#.#.#.#.#.#',
'#. ## ## .#',
'#.###.###.#',
'#.........#',
'#.#.#.#.#.#',
'#.........#',
'###########'
]).
map_size(11, 9).
num_dots(42).
pacman_start(5, 3).
initMap:- 
  addSolidObject('#'),   
  maplist(write,  ['Guess passwords to open steel walls. '
                  ,'Digits change when an entity or an object is in front.\n']),

	createGameEntity(EID_PASSCHECKER_0, '', non_interactive, 0, 0, active, passwordChecker, []),
	createGameEntity(EID_PASSCHECKER_1, '', non_interactive, 0, 0, active, passwordChecker, []),

	createGameEntity(EID_DIGIT_0, '0', object, 2, 3, active, passwordDigit, 
    [name(digit1), solid(true), static(true), use_rule(norule),
      description('Modifiable digit'),  appearance(attribs(normal, black, white))]),
  passwordDigit(init, EID_DIGIT_0, [ digits([1,2,3,4,5,6,7]), switchPos(1,3) ]),
	createGameEntity(EID_DIGIT_1, '0', object, 8, 3, active, passwordDigit, 
    [name(digit2), solid(true), static(true), use_rule(norule),
      description('Modifiable digit'),  appearance(attribs(normal, black, white))]),
  passwordDigit(init, EID_DIGIT_1, [ digits([1,2,3,4,5,6,7]), switchPos(9,3) ]),

	createGameEntity(EID_WALL_0, '#', object, 1, 4, inactive, norule, 
    [name(blocked_wall), solid(true), static(true), 
      description('Blocked wall with password'), appearance(attribs(bold, black, white))]),
	createGameEntity(EID_WALL_1, '#', object, 9, 2, inactive, norule, 
    [name(blocked_wall), solid(true), static(true), 
      description('Blocked wall with password'), appearance(attribs(bold, black, white))]),
  
  passwordChecker(init, EID_PASSCHECKER_0, 
  [ passwordDigits([EID_DIGIT_0]), password(25474526),
    action('pl-man':destroyGameEntity(EID_WALL_0)) 
  ]),
  passwordChecker(init, EID_PASSCHECKER_1, 
  [ passwordDigits([EID_DIGIT_1]), password(25474526),
    action('pl-man':destroyGameEntity(EID_WALL_1)) 
  ]).
norule(_).
norule(_,_,_,_,_).