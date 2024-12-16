%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prolog Code for Map-file generated from map2-012.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.1).
load_behaviour(automaticArcher).
load_behaviour(magicWand).
map([
'#######################',
'################### ###',
'# ....############# ###',
'#.....#  ...........###',
'#####.##............###',
'# ....##.##########.###',
'#####..#............###',
'#......#.##########.###',
'#..#...#.##########.###',
'#..## .#............  #',
'#..##..#.##############',
'#..##. .............  #',
'#..##   ............  #',
'#######################',
'# Use flIpEnDO Spell  #',
'# Use aPAreC1uM Spell #',
'#######################'
]).
map_size(23, 17).
num_dots(118).
pacman_start(1, 2).
initMap:- 
	addSolidObject('#'), 

	createGameEntity(OID_MagicWand, '!', object, 1, 5, inactive, norule, 
		[name(magicWand), solid(false), static(false), use_rule(magicWand), 
			description('Magic wand'), appearance(attribs(bold, cyan, default))]),
	magicWand(init(OID_MagicWand, [])),
	magicWand(newSpell(OID_MagicWand, 739538581, 1, 'pl-man':push)),
	magicWand(newSpell(OID_MagicWand, 529120427, 1, 'pl-man':createBlock)),

	createGameEntity(OID_AR0, 'v', object, 19, 1, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Arquero automático del rey'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR0, ['@','>'], down, 1, [ bullet_appearance('¡', normal, red, default) ]),
	createGameEntity(OID_AR1, ')', object, 7, 3, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Arquero automático del rey'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR1, ['@'], right, 1, [ bullet_appearance('>', normal, red, default), continuous ]),
	createGameEntity(OID_AR2, '(', object, 21, 9, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Arquero automático del rey'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR2, ['@','¡'], left, 1, [ bullet_appearance('<', normal, red, default) ]),

	createGameEntity(OID_AR3, '(', object, 21, 11, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Arquero automático del rey'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR3, ['@'], left, 2, [ bullet_appearance('<', normal, red, default), continuous ]),
	createGameEntity(OID_AR4, '(', object, 21, 12, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Arquero automático del rey'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR4, ['@'], left, 2, [ bullet_appearance('<', normal, red, default), continuous ]).
norule(_).
norule(_,_,_,_,_).


%%%
%%% Push Spell
%%%
push(_, _, X, Y, [ DIR ]):-
	'pl-man':seeEntities(first, X, Y, DIR, L_ENT), !,
	push(moveEntities(L_ENT, DIR)).

push(moveEntities(           [],   _)) :- !.
push(moveEntities([EID | L_ENT], DIR)) :- 
	push(entityIsNotPushable(EID)), !,
	push(moveEntities(L_ENT, DIR)).
push(moveEntities([EID | L_ENT], DIR)) :- 
	'pl-man':getDMap(M),
	'pl-man':doEntityAction(EID, M, move(DIR)), !,
	push(moveEntities(L_ENT, DIR)).
push(entityIsNotPushable(EID)) :-
	'pl-man':dynamicProperties(get(EID, pushable(false))) ;
	'pl-man':dynamicProperties(get(EID, avoid_magic(true))).


%%%
%%% Block Spell
%%%
createBlock(_, _, X, Y, [_]):-
	% Check if there is a solid element
	( not(collision(X,Y)) ->
		% Check if there is an entity
		( 'pl-man':entityLocation(EID, X, Y, _) ->
			( 'pl-man':solidEntity(EID) ->
				maplist(user:write, ['Can\'t place blocks over solid entities!\n'])
				;
				maplist(user:write, ['There\'s already an entity there!\n'])
			)
			;
			'pl-man':createGameEntity(_, '%', object, X, Y, inactive, norule,	[name(magic_block), solid(true), static(true), use_rule(norule), description('Block pushable by magic'), appearance(attribs(bold, black, yellow))]),
			maplist(user:write, ['Block summoned in (',X,',',Y, ')\n'])
		)
		;
		maplist(user:write, ['Can\'t place blocks over solid elements!\n'])
	).