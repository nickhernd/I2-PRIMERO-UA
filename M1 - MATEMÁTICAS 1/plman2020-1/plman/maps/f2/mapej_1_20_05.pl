%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prolog Code for Map-file generated from map3-038.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.1).
load_behaviour(magicWand).
map([
'###########################',	
'##### WAND SPELL (4) ######',
'###########################',
'# #########################',
'# ........................#',
'###########################',
'# Use aV4dA_keDaVra Spell #',
'###########################',
' use(aV4dA_keDaVra, right) '
]).
map_size(27, 9).
num_dots(24).
pacman_start(1, 4).
initMap:- 
	addSolidObject('#'), 

	createGameEntity(OID_MagicWand, '!', object, 1, 3, inactive, norule, 
		[name(magicWand), solid(false), static(false), use_rule(magicWand), 
			description('Magic wand'), appearance(attribs(bold, cyan, default))]),
  magicWand(init(OID_MagicWand, [])),
  magicWand(newSpell(OID_MagicWand, 788458969, 1, 'pl-man':killEnemyE)),

	createGameEntity(_, 'E', mortal, 6, 4, inactive, norule, [appearance(attribs(normal, red, default))]),
  createGameEntity(_, 'E', mortal, 15, 4, inactive, norule, [appearance(attribs(normal, red, default))]).
norule(_).
norule(_,_,_,_,_).

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