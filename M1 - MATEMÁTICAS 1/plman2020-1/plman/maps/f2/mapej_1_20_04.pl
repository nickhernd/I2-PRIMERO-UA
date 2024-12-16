%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prolog Code for Map-file generated from map3-038.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.1).
load_behaviour(automaticArcher).
load_behaviour(magicWand).
map([
'#######################',	
'### WAND SPELL (3) ####',
'#######################',
'# ######### ###########',
'# ......... .........##',
'##########...##########',
'#######################',
'# Use aPAreC1uM Spell #',
'#######################',
' use(aPAreC1uM, right) '
]).
map_size(23, 10).
num_dots(21).
pacman_start(1, 4).
initMap:- 
	addSolidObject('#'), 

  createGameEntity(OID_MagicWand, '!', object, 1, 3, inactive, norule, 
		[name(magicWand), solid(false), static(false), use_rule(magicWand), 
			description('Magic wand'), appearance(attribs(bold, cyan, default))]),
	magicWand(init(OID_MagicWand, [])),
	magicWand(newSpell(OID_MagicWand, 529120427, 1, 'pl-man':createBlock)),

	createGameEntity(OID_AR0, 'v', object, 11, 3, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Arquero automático del rey'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR0, ['@'], down, 1, [ bullet_appearance('¡', normal, red, default), continuous]).
norule(_).
norule(_,_,_,_,_).

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