%4prueba

map_format_version(1.1).
load_behaviour(cauldron).
load_behaviour(enemyBasicMovement).

map(['##########################################',
     '#..................# ....................#',
     '#..................#..   ###    #######..#',
     '#..................# ....................#',
     '##########################################'
	 
	 ]).

map_size(42, 5).
num_dots(98).
pacman_start(20, 1).

initMap:- 
	addSolidObject('#'),
    maplist(write,  ['Brew up a vanishing potion by dropping the ingredient into the cauldron.\n']),
	createGameEntity(_, 'w', object, 30, 2, inactive, norule, 
                [name(water), solid(true), static(false), appearance(attribs(normal, magenta, default)),
                description('A bucket full of common water')]),

    createGameEntity(EID2, 'E', mortal, 1,2, active, enemyBasicMovement, 
            [name(enemy), solid(false), static(true), appearance(attribs(normal, red, default)),
            description('Evil wanderer from hell')]),
            enemyBasicMovement(init, EID2, right-left, ['#']),
    createGameEntity(EID3, 'E', mortal, 10,1, active, enemyBasicMovement, 
            [name(enemy), solid(false), static(true), appearance(attribs(normal, red, default)),
            description('Evil wanderer from hell')]),
            enemyBasicMovement(init, EID3, left-right, ['#']),
    createGameEntity(EID4, 'E', mortal, 18,3, active, enemyBasicMovement, 
            [name(enemy), solid(false), static(true), appearance(attribs(normal, red, default)),
            description('Evil wanderer from hell')]),
            enemyBasicMovement(init, EID4, right-left, ['#']),

    cauldron(create(OID_C, 31, 2, [])),
    dynamicProperties(set(OID_C, static(false))),
    cauldron(newRecipe(OID_C, 1802326590, 10, [ 'pl-man':cauldronFinish(OID_C, 1) ])).
        

cauldronFinish(OID, 1) :-
    cauldron(destroy(OID)), 
    destroyGameEntity(OID),
    setDCellContent(19, 2, ' ').
    


 
