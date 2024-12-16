load_behaviour(basicDoorKey).

map_format_version(1.1).
map([
'##########',
'#........#',
'########.#',
'# ...#...#',
'#....#...#',
'#....#...#',
'#........#',
'#.########',
'#....... #',
'##########'
]).
map_size(10, 10).
num_dots(45).
pacman_start(8, 8).
initMap:-
 	addSolidObject('#'),

   createGameEntity(OID_D, '-', object, 8, 2, inactive, norule, 
		[ name(door), solid(true), static(true), use_rule(norule), 
		description('Red door'), appearance(attribs(bold, red, default)) ]),
	createGameEntity(OID_K, 'k', object, 1, 3, inactive, norule, 
		[ name(key), solid(false), static(false), use_rule(basicDoorKey), 
		description('Red key'), appearance(attribs(normal, red, default)) ]),
   basicDoorKey(init, OID_D, [ 'pl-man':destroyGameEntity(OID_D)  ], [ OID_K ]).
	    
norule(_). 
