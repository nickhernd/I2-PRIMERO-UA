%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prolog Code for Map-file generated from map3-038.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.1).
load_behaviour(enemyBasicMovement).
load_behaviour(magicWand).
map([
'######################',	
'### WAND SPELL (1) ###',
'######################',
'# ####################',
'# .................  #',
'######################',
'# Use flIpEnDO Spell #',
'######################',
' use(flIpEnDO, right) '
]).
map_size(22, 9).
num_dots(17).
pacman_start(1, 4).
initMap:- 
	addSolidObject('#'), 

	createGameEntity(OID_MagicWand, '!', object, 1, 3, inactive, norule, 
		[name(magicWand), solid(false), static(false), use_rule(magicWand), 
			description('Magic wand'), appearance(attribs(bold, cyan, default))]),
	magicWand(init(OID_MagicWand, [ setStandardSpells(true) ])),

	createGameEntity(_, '%', object, 5, 4, inactive, norule, 
		[name(block), solid(true), static(true), use_rule(norule),
			description('Magic heavy block'), appearance(attribs(bold, black, yellow))]),

	createGameEntity(EID_0, 'E', mortal, 7, 4, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]), 
  enemyBasicMovement(init, EID_0, left-right, ['#','%']).
norule(_).
norule(_,_,_,_,_).
