map_format_version(1.1).
load_behaviour(automaticArcher).
load_behaviour(entitySequentialMovement).
load_behaviour(gunBasic).
load_behaviour(mineExplosion).
load_behaviour(password).
map([
'################',
'#              #',
'#######  #######',
'##  ........  ##',
'#   ........   #',
'##  ........  ##',
'#####......#####',
'#####......#####',
'################',
'####........####',
'# ##........## #',
'# ##........## #',
'#  ..........  #',
'######    ######',
'######help######'
]).
map_size(16, 15).
num_dots(70).
pacman_start(1, 10).
initMap:- 
  addSolidObject('#'),
  maplist(write,  ['Complete the password at PPPP to get some help. '
                  ,'Digits change when an entity or an object is in front.\n']),

	createGameEntity(EID_0, 'E', mortal, 2, 3, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]),
	entitySequentialMovement(init, EID_0, [d,d,n,u,u,n,d,d,n,u,u,n,r,r,r,r,r,r,r,r,r,r,r,d,d,n,u,u,n,d,d,n,u,u,n,l,l,l,l,l,l,l,l,l,l,l], [ ]),
	createGameEntity(EID_1, 'E', mortal, 13, 5, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]),
  entitySequentialMovement(init, EID_1, [u,u,n,d,d,n,u,u,n,d,d,n,l,l,l,l,l,l,l,l,l,l,l,u,u,n,d,d,n,u,u,n,d,d,n,r,r,r,r,r,r,r,r,r,r,r], [ ]),

  createGameEntity(EID_2, 'E', mortal, 7, 9, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]),
  entitySequentialMovement(init, EID_2, [d,r,u,l], [ ]),
 
	createGameEntity(OID_AR0, ')', object, 1, 4, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Automatic Archer'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR0, ['@'], right, 4, [ bullet_appearance('>', normal, red, default) ]),
	createGameEntity(OID_AR1, '(', object, 14, 4, active, automaticArcher, 
		[name(arqueroAutomatico), solid(false), static(true), use_rule(norule),
			description('Automatic Archer'), appearance(attribs(normal, yellow, default))]), 
	automaticArcher(init, OID_AR1, ['@'], left, 4, [ bullet_appearance('<', normal, red, default) ]),

	createGameEntity(EID_DIGIT_0, '0', object, 6, 13, active, passwordDigit, 
    [name(digit1), solid(true), static(true), use_rule(norule),
      description('Modifiable digit'),  appearance(attribs(normal, black, white))]),
  passwordDigit(init, EID_DIGIT_0, [ digits([f,g,h,i,j]), switchPos(6,12) ]),
	createGameEntity(EID_DIGIT_1, '0', object, 7, 13, active, passwordDigit, 
    [name(digit2), solid(true), static(true), use_rule(norule),
      description('Modifiable digit'),  appearance(attribs(normal, black, white))]),
  passwordDigit(init, EID_DIGIT_1, [ digits([c,d,e,f,g]), switchPos(7,12) ]),
	createGameEntity(EID_DIGIT_2, '0', object, 8, 13, active, passwordDigit, 
    [name(digit3), solid(true), static(true), use_rule(norule),
      description('Modifiable digit'),  appearance(attribs(normal, black, white))]),
  passwordDigit(init, EID_DIGIT_2, [ digits([j,k,l,m,n]), switchPos(8,12) ]),
  createGameEntity(EID_DIGIT_3, '0', object, 9, 13, active, passwordDigit, 
    [name(digit4), solid(true), static(true), use_rule(norule),
      description('Modifiable digit'),  appearance(attribs(normal, black, white))]),
  passwordDigit(init, EID_DIGIT_3, [ digits([n,o,p,q,r]), switchPos(9,12) ]),

	createGameEntity(EID_PASSCHECKER_0, '', non_interactive, 0, 0, active, passwordChecker, []),
  passwordChecker(init, EID_PASSCHECKER_0, 
  [ passwordDigits([EID_DIGIT_0,EID_DIGIT_1,EID_DIGIT_2,EID_DIGIT_3]), password(825795826),
    action('pl-man':createGameEntity(_, '', non_interactive, 0, 0, active, callHelp, [])) 
  ]),

	retractall(d_helpCalled(_,_)),
	assert(d_helpCalled(false,_)).
norule(_).
norule(_,_,_,_,_).

%%% SUBRULES

:- dynamic d_helpCalled/2.

%%% Destroy companion
callHelp(EID):-
  d_helpCalled(true,EID_Companion),

  entityLocation(EID_Companion, X, Y, _),
  X = 14, 
  Y = 10, !,
  destroyGameEntity(EID_Companion),
  destroyGameEntity(EID).

%%% Drop mine
callHelp(_):-
  d_helpCalled(true,EID_Companion),

  entityLocation(EID_Companion, X, _, _),
  X = 8, !,
  doAction(EID_Companion, drop(left)).

%%% Drop gun
callHelp(_):-
  d_helpCalled(true,EID_Companion),

  havingObject(EID_Companion, appearance('+')),
  entityLocation(EID_Companion, X, Y, _),
  X = 11,
  Y = 12, !,

	createGameEntity(OID_G0, '¬', object, 10, 12, inactive, norule, 
    [name('gun'), solid(false), static(false), use_rule(gunBasic),
			description('Gun with 2 bullets'), appearance(attribs(bold, cyan, default))]), 
  gunBasic(init, OID_G0, 2, ['E'], destroy).
  
callHelp(_):-
  d_helpCalled(false,_), !,

  maplist(user:write, ['🕴:—Incoming to help!\n']),  
	createGameEntity(EID_Companion, '🕴', object, 14, 11, active, entitySequentialMovement, 
		[name('companion'), solid(false), static(true), use_rule(norule),
			description('A PL-Man companion that brings a mine'), appearance(attribs(normal, green, default))]), 
  entitySequentialMovement(init, EID_Companion, [d,l,l,l,u,u,u,l,l,l,n,r,r,r,d,d,d,r,r,r,u,u], [ no_cycle ]),
  
  createGameEntity(OID_MINE, '+', object, 0, 0, active, mine, 
    [name(mine), solid(false), static(false), use_rule(norule), 
      description('programmable mine'), appearance(attribs(bold, cyan, default))]),
  mine(init, OID_MINE, 5, 1, [ no_destroy(['.']) ]),
  getObjectFrom(EID_Companion, 0, 0),

	retractall(d_helpCalled(_,_)),
  assert(d_helpCalled(true,EID_Companion)).