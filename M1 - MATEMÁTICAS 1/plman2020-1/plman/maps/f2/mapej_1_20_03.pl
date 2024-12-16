%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prolog Code for Map-file generated from map3-038.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.1).
load_behaviour(magicWand).
map([
'#######################',	
'### WAND SPELL (2) ####',
'#######################',
'# #####################',
'# ......... ..........#',
'#######################',
'# Use aLoHoM0rA Spell #',
'#######################',
' use(aLoHoM0rA,right)  '
]).
map_size(23, 8).
num_dots(19).
pacman_start(1, 4).
initMap:- 
	addSolidObject('#'), 

	createGameEntity(OID_MagicWand, '!', object, 1, 3, inactive, norule, 
		[name(magicWand), solid(false), static(false), use_rule(magicWand), 
			description('Magic wand'), appearance(attribs(bold, cyan, default))]),
	magicWand(init(OID_MagicWand, [])),
	magicWand(newSpell(OID_MagicWand, 1636996084, 1, 'pl-man':open)),
	
  
  createGameEntity(_, '|', object, 11, 4, inactive, norule, 
    [name(door_unpushable), solid(true), static(true), use_rule(norule), magic_locked(true),
			description('Unpushable door'), appearance(attribs(normal, yellow, black)), pushable(false)]).
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