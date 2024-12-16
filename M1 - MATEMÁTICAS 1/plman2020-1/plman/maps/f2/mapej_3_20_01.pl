%prueba3
map_format_version(1.1).
load_behaviour(cauldron).
load_behaviour(basicTeletransport).


map([
'############################',
'# .....# .... .....  #.... #',
'# .....  .... .....  ..... #',
'# .... # .... .....  #.... #',
'############################',
'#.... #    # ....#   #.....#',
'#... # #   #.....## ##.....#',
'#...#####  #.....# # #.....#',
'#  #     # ##### #   #.... #', 
'############################'
]).


map_size(28, 10).
num_dots(97).
pacman_start(13, 1).

initMap:- 
	addSolidObject('#'),
   maplist(write, ['Brew up the many teleports potion by droping '
                  ,'ingredients into the cauldron in the appropriate order.\n']),
	createGameEntity(_, 'a', object, 13, 3, inactive, norule, 
                [name(water), solid(true), static(false), appearance(attribs(normal, white, default)),
                description('water')]),
	createGameEntity(_, 'm', object, 26, 1, inactive, norule, 
                [name(honey), solid(true), static(false), appearance(attribs(normal, red, default)),
                description('honey')]),
        createGameEntity(_, 'l', object, 26, 3, inactive, norule, 
                [name(yeast), solid(true), static(false), appearance(attribs(normal, green, default)),
                description('yeast')]),

        cauldron(create(OID_C, 13, 2, [])),
        dynamicProperties(set(OID_C, static(false))),
        cauldron(newRecipe(OID_C,  2066720247,  1, [ 'pl-man':cauldronFinish(OID_C, 1) ])).
      


cauldronFinish(OID, 1) :-
       cauldron(destroy(OID)), 
       destroyGameEntity(OID),
       createGameEntity(OID_T, '?', object, 26, 1, active, basicTeletransport, 	
	 [name(teletransporte), solid(false), static(true), use_rule(norule),
	  description('teleport'), appearance(attribs(normal,cyan,default))]),
	basicTeletransport(init, OID_T, from(26,1), to(1,1), ['@'], [viceversa]), 

        createGameEntity(OID_T2, '?', object, 6, 3, active, basicTeletransport, 	
	 [name(teletransporte), solid(false), static(true), use_rule(norule),
	  description('teleport'), appearance(attribs(normal,cyan,default))]),
	basicTeletransport(init, OID_T2, from(6,3), to(1,8), ['@'], [viceversa]),

        createGameEntity(OID_T3, '?', object, 5, 5, active, basicTeletransport, 	
	 [name(teletransporte), solid(false), static(true), use_rule(norule),
	  description('teleport'), appearance(attribs(normal,cyan,default))]),
	basicTeletransport(init, OID_T3, from(5,5), to(8,5), ['@'], [viceversa]), 

        createGameEntity(OID_T4, '?', object, 10, 8, active, basicTeletransport, 	
	 [name(teletransporte), solid(false), static(true), use_rule(norule),
	  description('teleport'), appearance(attribs(normal,cyan,default))]),
	basicTeletransport(init, OID_T4, from(10,8), to(12,5), ['@'], [viceversa]), 

        createGameEntity(OID_T5, '?', object, 16, 8, active, basicTeletransport, 	
	 [name(teletransporte), solid(false), static(true), use_rule(norule),
	  description('teleport'), appearance(attribs(normal,cyan,default))]),
	basicTeletransport(init, OID_T5, from(16,8), to(26,8), ['@'], [viceversa]). 
