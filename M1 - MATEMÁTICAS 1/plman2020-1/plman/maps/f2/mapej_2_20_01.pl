%prueba
map_format_version(1.1).
load_behaviour(cauldron).
load_behaviour(enemyBasicMovement).
load_behaviour(basicDoorKey).
map(['############',
     '#..........#',
     '#..........#',
     '#..........#',
     '#          #',
     '############',
     '#..........#',
     '############']).

map_size(12, 7).
num_dots(40).
pacman_start(1, 1).

initMap:- 

	addSolidObject('#'),
    maplist(write,  ['Brew up a vanishing potion by dropping '
                    ,'ingredients into the cauldron in the right order.\n']),
	createGameEntity(_, 'a', object, 10, 4, inactive, norule, 
                [name(ash), solid(true), static(false), appearance(attribs(normal, red, default)),
                description('ash')]),
	createGameEntity(_, 'b', object, 1, 4, inactive, norule, 
                [name(birch), solid(true), static(false), appearance(attribs(normal, magenta, default)),
                description('birch')]),
        cauldron(create(OID_C, 6, 4, [])),
        dynamicProperties(set(OID_C, static(false))),
        cauldron(newRecipe(OID_C,  432783429,  1, [ 'pl-man':cauldronFinish(OID_C, 2) ])),
        cauldron(newRecipe(OID_C, 287971734   , 10, [ 'pl-man':cauldronFinish(OID_C, 1) ])).
        
% One combination of ingredients
cauldronFinish(OID, 1) :-
    cauldron(destroy(OID)), 
    destroyGameEntity(OID),
    setDCellContent(6, 5, ' ').
    

% Another combination of ingredients
cauldronFinish(_, 2) :-
    createGameEntity(EID, 'E', mortal, rnd(1,4), rnd(1,4), active, enemyBasicMovement, 
                [name(enemigo), solid(false), static(true), appearance(attribs(normal, red, default)),
                description('Perseguidor del mal')]),
    enemyBasicMovement(init, EID, left-right, ['#']).
 
