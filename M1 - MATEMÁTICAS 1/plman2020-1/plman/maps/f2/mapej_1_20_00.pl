load_behaviour(entitySequentialMovement).
load_behaviour(basicDoorKey).

map_format_version(1.1).
map([
'###############',
'#             #',
'# ########### #',
'# #.........# #',
'# #.........# #',
'# #.........# #',
'# #.........# #',
'# ##### ##### #',
'#             #',
'################'
]).
map_size(16, 9).
num_dots(36).
pacman_start(7, 8).
initMap:-
 	addSolidObject('#'),

	createGameEntity(OID_K, 'k', object, 1, 1, inactive, norule, 
	[ name(llave), solid(false), static(false), use_rule(basicDoorKey), 
	description('Llave roja'), appearance(attribs(normal, red, default)) ]),

	createGameEntity(OID_D, '-', object, 7, 7, inactive, norule, 
	[ name(puerta), solid(true), static(true), use_rule(norule), 
	description('Puerta roja'), appearance(attribs(bold, red, green)) ]),

   basicDoorKey(init, OID_D, [ 'pl-man':destroyGameEntity(OID_D)  ], [ OID_K ]).


norule(_). 
