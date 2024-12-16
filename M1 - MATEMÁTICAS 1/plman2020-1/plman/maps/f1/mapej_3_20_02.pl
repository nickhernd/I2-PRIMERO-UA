load_behaviour(enemyBasicMovement).
load_behaviour(basicDoorKey).
map_format_version(1.1).

map([
'###################################',
'# ...................#............#',
'#       ###          #............#',
'#....................########## ###',
'#...............................  #',
'###################################'
]).
map_size(37, 6).
num_dots(94).
pacman_start(1, 1).
initMap:-
 	addSolidObject('#'),

	createGameEntity(EID_0, 'E', mortal, 4 , 4, active, enemyBasicMovement, 
      [appearance(attribs(normal, red, default))]),
      enemyBasicMovement(init, EID_0, right-left, ['#']),

	createGameEntity(OID_D1, '-', object, 31, 3, inactive, norule, 
      [name(blue_door), solid(true), static(true), use_rule(norule),
      description('Blue door'), appearance(attribs(normal, black, cyan))]),

	createGameEntity(OID_K, 'a', object, 1, 2, inactive, norule, 
      [name(blue_key), solid(false), static(false), use_rule(basicDoorKey),
      description('Blue key'), appearance(attribs(bold, cyan, default))]), 
	
   basicDoorKey(init, OID_D1, [ 'pl-man':destroyGameEntity(OID_D1) ], [ OID_K ]).

norule(_). 
