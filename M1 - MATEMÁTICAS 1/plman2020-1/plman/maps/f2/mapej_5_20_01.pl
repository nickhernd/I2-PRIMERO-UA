%5
map_format_version(1.1).
load_behaviour(cauldron).
load_behaviour(basicTeletransport).
load_behaviour(enemyBasicMovement).


map([
'#################',
'## ..... ..... ##',
'##...... ......##',
'##.............##',
'##......#......##',
'##......#......##',
'##......#......##',
'## .... # .... ##', 
'#################',
'##.............##',
'##.............##',
'#################',
'### ##  ## ######',
'#-1 m > w   #####',
'# 2 ?? ^ ?m CP 1#',
'## ## ##  #### ##',
'#################'
]).


map_size(17, 17).
num_dots(105).
pacman_start(8, 2).

initMap:- 
	addSolidObject('#'),
  maplist(write, 
    ['You have entered the Pharaoh Pyramid, everything is dark. A hieroglyphic ',
     'in the stonewall tells you how to brew up a torch-appearing potion.',
     'Complete the three gaps in order by adding ingredients to the cauldron.\n']),

  createGameEntity(EID2, 'E', mortal, 4, 7, active, enemyBasicMovement,[appearance(attribs(normal,red,default))]), 
  enemyBasicMovement(init, EID2, down-up, ['#']),
  createGameEntity(EID3, 'E', mortal, 13, 1, active, enemyBasicMovement,[appearance(attribs(normal,red,default))]), 
  enemyBasicMovement(init, EID3, up-down, ['#']),

	createGameEntity(_, 'w', object, 9, 7, inactive, norule, 
                [name(wart), solid(true), static(false), appearance(attribs(normal, green, default)),
                description('nether wart')]),
	createGameEntity(_, '¬', object, 2, 1, inactive, norule, 
                [name(melon), solid(true), static(false), appearance(attribs(normal, yellow, default)),
                description('Shimmering watermelon')]),
  createGameEntity(_, 'r', object, 14, 7, inactive, norule, 
               [name(redstone), solid(true), static(false), appearance(attribs(normal, red, default)),
                description('redstone')]),
  createGameEntity(_, 'c', object, 14, 1, inactive, norule, 
               [name(magma), solid(true), static(false), appearance(attribs(normal, white, default)),
                description('magma cream')]),
  createGameEntity(_, '¬', object, 2, 7, inactive, norule, 
                [name(sugar), solid(true), static(false), appearance(attribs(normal, magenta, default)),
                description('sugar')]),
  createGameEntity(_, 'f', object, 7, 7, inactive, norule, 
                [name(fermented), solid(true), static(false), appearance(attribs(normal, white, default)),
                description('fermented Spider Eye')]),

  createGameEntity(EID_P1, '?', object, 4, 14, inactive, norule, 
               [name(?), solid(true), static(false), appearance(attribs(normal, black, yellow)),
                description('part 1')]),    
  createGameEntity(EID_P2, '?', object, 5, 14, inactive, norule, 
               [name(?), solid(true), static(false), appearance(attribs(normal, black, yellow)),
                description('part 2')]), 
  createGameEntity(EID_P3, '?', object, 9, 14, inactive, norule, 
               [name(?), solid(true), static(false), appearance(attribs(normal, black, yellow)),
                description('part 3')]), 
  cauldron(create(OID_C, 8, 1, [])),
  dynamicProperties(set(OID_C, static(false))),
  cauldron(newRecipe(OID_C,  1368581278  ,  1, [ 'pl-man':cauldronFinish(OID_C, EID_P1, EID_P2, EID_P3, 1) ])),
  hieroglyphic(create(OID_C, [EID_P1, EID_P2, EID_P3])).
      

cauldronFinish(OID_C, EID_P1, EID_P2, EID_P3, 1) :- 
  cauldron(destroy(OID_C)),      
  destroyGameEntity(OID_C),

  changeEntityAppearance(EID_P1, '¬', bold, white, cyan),
  changeEntityAppearance(EID_P2, 'w', bold, white, cyan),
  changeEntityAppearance(EID_P3, '¬', bold, white, cyan),

  createGameEntity(OID_TT, '?', object, 8, 1, active, basicTeletransport, 	
      [name(teletransporte), solid(false), static(true), use_rule(norule),
      description('Teletransporte'), appearance(attribs(normal,black,green))]),
  basicTeletransport(init, OID_TT, from(8,1), to(2,9), ['@'], [viceversa]).

:- dynamic d_hieroglyphic/5.
hieroglyphic(init, EID_S, EID_C, L_PARTS) :-
    retractall(d_hieroglyphic(_,_,_,_,_))
  , assert(d_hieroglyphic(EID_S, EID_C, L_PARTS, _, _)).

hieroglyphic(init, EID_S, EID_C, L_PARTS, OID_ING, AP_ING) :-
    retractall(d_hieroglyphic(_,_,_,_,_))
  , assert(d_hieroglyphic(EID_S, EID_C, L_PARTS, OID_ING, AP_ING)).

hieroglyphic(ingredient_dropped, _, _, _, _, []) :- !.
hieroglyphic(ingredient_dropped, _, EID_C, OID_ING, _, _) :-
    not(aliveEntity(OID_ING))
  , entityLocation(EID_C, XC, YC, _)
  , entityType(EID_PLMAN, pacman)
  , entityLocation(EID_PLMAN, XP, YP, _)
  , DX is abs(XP - XC)
  , DX > 1
  , DY is abs(YP - YC)
  , DY > 1
  , !.
hieroglyphic(ingredient_dropped, EID_S, EID_C, _, AP_ING, [EID_P1 | L_PARTS]) :-
    hieroglyphic(init, EID_S, EID_C, L_PARTS)
  , aliveEntity(EID_C)
  , changeEntityAppearance(EID_P1, AP_ING, bold, white, black).

hieroglyphic(update, _, _, [], _, _) :- !.
hieroglyphic(update, EID_S, EID_C, L_PARTS, OID_ING, AP_ING) :- 
    number(OID_ING)
  , !
  , not(isObjectGot(OID_ING))
  , hieroglyphic(init, EID_S, EID_C, L_PARTS)
  , hieroglyphic(ingredient_dropped, EID_S, EID_C, OID_ING, AP_ING, L_PARTS).
hieroglyphic(update, EID_S, EID_C, L_PARTS, OID_ING, _) :- 
    var(OID_ING)
  , isObjectGot(OID_ING)
  , entityLocation(OID_ING, _, _, Ap)
  , hieroglyphic(init, EID_S, EID_C, L_PARTS, OID_ING, Ap).

hieroglyphic(create(EID_C, L_PARTS)) :-
    createGameEntity(EID_S, '', object, 0, 0, active, hieroglyphic, 
        [name(hieroglyphic), solid(true), static(true), appearance(attribs(normal, black, yellow)),
         description('Hieroglyphic supervisor')])
  , hieroglyphic(init, EID_S, EID_C, L_PARTS).

hieroglyphic(EID) :-
    d_hieroglyphic(EID, EID_C, L_PARTS, OID_ING, AP_ING)
  , hieroglyphic(update, EID, EID_C, L_PARTS, OID_ING, AP_ING).
  