%prueba2

load_behaviour(enemyBasicMovement).
map_format_version(1.1).

map([
'#################################',
'#.........       .............. #',
'#   ################  ..........#',
'#...................  #####.....#',
'#...................  ..........#',
'#################################'

]).
map_size(33, 6).
num_dots(86).
pacman_start(31, 1).
initMap:-
 	addSolidObject('#'),

	createGameEntity(EID_0, 'E', mortal, 3 , 3, active, enemyBasicMovement, 
	[appearance(attribs(normal, red, default))]),
    enemyBasicMovement(init, EID_0, right-left, ['#']).

norule(_). 
