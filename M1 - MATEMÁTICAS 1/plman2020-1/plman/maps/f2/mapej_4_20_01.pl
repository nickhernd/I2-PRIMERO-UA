map_format_version(1.1).
load_behaviour(cauldron).
load_behaviour(mineExplosion).
load_behaviour(basicTeletransport).
load_behaviour(enemyBasicMovement).


map([

'1w###############',
'#               #',
'# ..............#',
'#################',
'#.......# ..... #',
'#.......# ......#',
'#.......# ......#',
'#.......# ......#', 
'2s#############3l'
]).


map_size(17, 11).
num_dots(65).
pacman_start(15, 2).

initMap:- 
	addSolidObject('#'),
  addSolidObject('w'),
  addSolidObject('s'),
  addSolidObject('3'),
  maplist(write,  ['Brew up a VME (vanishing,mine & enemy) potion by dropping '
                  ,'ingredients into the cauldron in the right order\n']), 

	createGameEntity(_, 'w', object, 8, 1, inactive, norule, 
                [name(wart), solid(true), static(false), appearance(attribs(normal, green, default)),
                description('nether wart')]),
	createGameEntity(_, 's', object, 2, 1, inactive, norule, 
                [name(flame), solid(true), static(false), appearance(attribs(normal, red, default)),
                description('Shimmering watermelon')]),
  createGameEntity(_, 'l', object, 5, 1, inactive, norule, 
                [name(powder), solid(true), static(false), appearance(attribs(normal, yellow, default)),
                description('Luminous stone powder')]),
  createGameEntity(_, 'r', object, 11, 1, inactive, norule, 
               [name(redstone), solid(true), static(false), appearance(attribs(normal, magenta, default)),
                description('redstone')]),
  createGameEntity(_, 'o', object, 14, 1, inactive, norule, 
               [name(redstone), solid(true), static(false), appearance(attribs(normal, white, default)),
                description('oil')]),


  cauldron(create(OID_C, 1, 2, [])),
  dynamicProperties(set(OID_C, static(false))),
  cauldron(newRecipe(OID_C,  1889403882  ,  1, [ 'pl-man':cauldronFinish(OID_C, 1) ])).
      

cauldronFinish(OID_C, 1) :-
  cauldron(destroy(OID_C)),
  destroyGameEntity(OID_C),
  setDCellContent(15, 3, ' '),

  createGameEntity(EID, 'E', mortal, 9, 4, active, enemyBasicMovement,[appearance(attribs(normal,red,default))]), 
  enemyBasicMovement(init, EID, down-up, ['#']),

  createGameEntity(OID_MINE, '+', object, 15, 7, active, mine, 
      [name(mina), solid(false), static(false), use_rule(norule), 
      description('mine'), appearance(attribs(bold,cyan,default))]),
  mine(init, OID_MINE, 2, 1, [no_destroy(['.'])]).
