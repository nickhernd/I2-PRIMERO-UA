%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prolog Code for Map-file generated from map2-013.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.1).
load_behaviour(enemyBasicMovement).
load_behaviour(entitySequentialMovement).
load_behaviour(magicWand).
map([
'###########################',
'# ....................... #',
'# ########### ########### #',
'# #                     # #',
'# # ................... # #',
'# # .  .  .  .  .  .  . # #',
'# # .  .  .  .  .  .  . # #',
'# # .  .  .     .  .  . # #',
'# # .  .  .  .  .  .  . # #',
'# # .  .  .  .  .  .  . # #',
'# # ................... # #',
'# #                     # #',
'# ####################### #',
'#............ ............#',
'#.                       .#',
'#.........................#',
'###########################',
'# Use   aLoHoM0rA   Spell #',
'# Use aV4dA_keDaVra Spell #',
'###########################'
]).
map_size(27, 20).
num_dots(146).
pacman_start(13, 7).
initMap:- 
	addSolidObject('#'), 
	
	createGameEntity(OID_MagicWand, '!', object, 13, 11, inactive, norule, 
		[name(magicWand), solid(false), static(false), use_rule(magicWand), 
			description('Magic wand'), appearance(attribs(bold, cyan, default))]),
	magicWand(init(OID_MagicWand, [])),
	magicWand(newSpell(OID_MagicWand, 1636996084, 1, 'pl-man':open)),
	magicWand(newSpell(OID_MagicWand, 788458969, 1, 'pl-man':killEnemyE)),
	
	createGameEntity(_, '-', object, 13, 2, inactive, norule, 
    [name(door_unpushable), solid(true), static(true), use_rule(norule), magic_locked(true),
			description('Unpushable door'), appearance(attribs(normal, yellow, black)), pushable(false)]),	

	createGameEntity(_, '|', object, 13, 13, inactive, norule, 
    [name(door_unpushable), solid(true), static(true), use_rule(norule), magic_locked(true),
			description('Unpushable door'), appearance(attribs(normal, yellow, black)), pushable(false)]),

	createGameEntity(EID_0, 'E', mortal, 3, 3, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]), 
	entitySequentialMovement(init, EID_0, [d,d,d,d,d,d,d,d,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,u,u,u,u,u,u,u,u,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l], [ ]),
	createGameEntity(EID_1, 'E', mortal, 5, 5, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]), 
	entitySequentialMovement(init, EID_1, [d,d,d,d,n,n,n,n,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,n,n,n,n,u,u,u,u,n,n,n,n,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,n,n,n,n], [ ]),

	createGameEntity(EID_2, 'E', mortal, 9, 5, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]), 
	entitySequentialMovement(init, EID_2, [d,d,d,d,u,u,u,u], [ ]),
	createGameEntity(EID_3, 'E', mortal, 17, 9, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]),
	entitySequentialMovement(init, EID_3, [u,u,u,u,d,d,d,d], [ ]),

	createGameEntity(EID_4, 'E', mortal, 13, 14, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]),
	enemyBasicMovement(init, EID_4, left-right, ['#']),
	
	createGameEntity(EID_5, 'E', mortal, 7, 14, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]),
	enemyBasicMovement(init, EID_5, up-down, ['#']),
	createGameEntity(EID_9, 'E', mortal, 19, 14, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]),
	enemyBasicMovement(init, EID_9, up-down, ['#']),
	
	createGameEntity(_, 'E', mortal, 1, 12, inactive, norule, [appearance(attribs(normal, red, default))]),
	createGameEntity(_, 'E', mortal, 25, 12, inactive, norule, [appearance(attribs(normal, red, default))]).
norule(_).
norule(_,_,_,_,_).


%%%
%%% Open Spell
%%%
open(_, _, X, Y, [ DIR ]):-
	'pl-man':seeEntities(first, X, Y, DIR, L_ENT), !,
	open(openEntities(L_ENT, DIR)).

open(openEntities(           [],   _)) :- !.
open(openEntities([EID | L_ENT], DIR)) :- 
	open(entityIsNotOpenable(EID)), !,
	open(openEntities(L_ENT, DIR)).
open(openEntities([EID | L_ENT], DIR)) :- 
	'pl-man':makeObjectNotSolid(EID),
	'pl-man':invertEntityColors(EID),
	'pl-man':changeEntityAppearance(EID, ' ', _, _, _),
	'pl-man':dynamicProperties(setOrAdd(EID, magic_locked(false))),
	open(openEntities(L_ENT, DIR)).
open(entityIsNotOpenable(EID)) :-
	not('pl-man':solidEntity(EID))                                ;
	not('pl-man':dynamicProperties(get(EID, magic_locked(true)))) ;
	'pl-man':dynamicProperties(get(EID, avoid_magic(true))).


%%%
%%% Kill Spell
%%%
killEnemyE(_, EID, X, Y, [ DIR ]):-
  see(EID, list, DIR, SEELIST),
  member(AIM, SEELIST),
  member(AIM, ['E']), !, 
	nth0(DIST, SEELIST, AIM),
	p_calculateEntityXY(DIR, DIST, X, Y, EX, EY),
	entityLocation(DEST_EID,EX,EY,AIM), 
  destroyGameEntity(DEST_EID),
  maplist(user:write, ['MAGICWAND: Enemy pulverized!', '\n']).

killEnemyE(_,_,_,_,_):-
  maplist(user:write, ['MAGICWAND: Spell failed...', '\n']).

% Calculate X,Y location of the entity we are seeing
p_calculateEntityXY(left, DIST, X, Y, NX, Y):- NX is X-DIST.
p_calculateEntityXY(right, DIST, X, Y, NX, Y):- NX is X+DIST.
p_calculateEntityXY(up, DIST, X, Y, X, NY):- NY is Y-DIST.
p_calculateEntityXY(down, DIST, X, Y, X, NY):- NY is Y+DIST.