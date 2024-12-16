load_behaviour(entitySequentialMovement).

map_format_version(1.1).
map([
'############################',
'###........# ............. #',
'#...###....#...########....#',
'#...###....#...########....#',
'#...###....#...########....#',
'#.......... ...............#',
'############################'
]).
map_size(27, 6).
num_dots(88).
pacman_start(26, 1).
initMap:-
 	addSolidObject('#'),

	createGameEntity(EID_0, 'E', mortal, 18, 5, active, entitySequentialMovement,
	  [ appearance(attribs(normal, red, default))]), 

	createGameEntity('k', object, 12, 1, inactive, norule, 
	  [ name(key), solid(false), static(false), use_rule(llaveUsoRule), 
	  description('Red key'), appearance(attribs(normal, red, default)) ]),

	createGameEntity('|', object, 11, 5, inactive, norule, 
	  [ name(door), solid(true), static(true), use_rule(llaveUsoRule), 
	  description('Red door'), appearance(attribs(bold, red, green)) ]),

	entitySequentialMovement(init, EID_0, [l,l,l,l,l,u,u,u,u,d,d,d,d,r,r,r,r,r,r,r,l,l ], []).


	llaveUsoRule(LlaveId,_, X, Y, _):-
     entityLocation(PtaEID,X,Y,'|'),
	  changeEntityAppearance(PtaEID,'_',_),
	  makeObjectNotSolid(PtaEID),
	  changeObjectName(PtaEID,opened_door,door),
	  destroyGameEntity(LlaveId),
	  msgWindowWriteln('Red door opened!'), !.
	llaveUsoRule(_,_, _, _, _):-
	  msgWindowWriteln('Red key cannot be used here!'), !.


norule(_). 
