:-use_module('pl-man-game/main').

:-dynamic estado/1.
estado(izq0).

cambiar(EST):-retractall(estado(_)),assert(estado(EST)).

espacio('.').
:-usemodule('pl-man-game/main').
% Estados
:-dynamic estado/1.
estado(bajar).
cambiar(EST):- retractall(estado()), assert(estado(EST)), writeln(EST).
% Principal
do(X):- estado(EST), do1(EST,X).
% ESTADO: BAJAR
% Si hay punto abajo y es seguro, bajar
do1(bajar, move(down)):-
    see(normal,down,'.'),
    not(see(list,down,[,'F'|])),
    writeln('Bajo por punto').
% Si hay fantasma abajo, moverse a los lados si hay puntos
do1(bajar, move(right)):-
    see(list,down,[,'F'|]),
    see(normal,right,'.'),
    not(see(list,right,[,'F'|])),
    writeln('Esquiva derecha punto').
do1(bajar, move(left)):-
    see(list,down,[,'F'|]),
    see(normal,left,'.'),
    not(see(list,left,[,'F'|])),
    writeln('Esquiva izquierda punto').
% Continuar bajando por espacio vacío si es seguro
do1(bajar, move(down)):-
    not(see(normal,down,'#')),
    not(see(list,down,[,'F'|])),
    writeln('Bajo seguro').
% Al llegar abajo, comenzar barrido
do1(bajar, move(right)):-
    see(normal,down,'#'),
    cambiar(derecha),
    writeln('Inicio derecha').
% ESTADO: DERECHA
% Si hay punto, intentar comerlo
do1(derecha, move(right)):-
    see(normal,right,'.'),
    not(see(list,right,[,'F'|])),
    writeln('Derecha punto').
% Si hay fantasma, buscar puntos seguros alrededor
do1(derecha, move(up)):-
    see(list,right,[,'F'|]),
    see(normal,up,'.'),
    not(see(list,up,[,'F'|])),
    writeln('Escape arriba punto').
do1(derecha, move(down)):-
    see(list,right,[,'F'|]),
    see(normal,down,'.'),
    not(see(list,down,[,'F'|])),
    writeln('Escape abajo punto').
% Si no hay puntos, mover por espacio
do1(derecha, move(right)):-
    see(normal,right,' '),
    not(see(list,right,[,'F'|])),
    writeln('Derecha espacio').
% Cambio a izquierda
do1(derecha, move(left)):-
    see(normal,right,'#'),
    cambiar(izquierda),
    writeln('Cambio izquierda').
% ESTADO: IZQUIERDA
% Si hay punto, intentar comerlo
do1(izquierda, move(left)):-
    see(normal,left,'.'),
    not(see(list,left,[,'F'|])),
    writeln('Izquierda punto').
% Si hay fantasma, buscar puntos seguros alrededor
do1(izquierda, move(up)):-
    see(list,left,[,'F'|]),
    see(normal,up,'.'),
    not(see(list,up,[,'F'|])),
    writeln('Escape arriba punto').
do1(izquierda, move(down)):-
    see(list,left,[,'F'|]),
    see(normal,down,'.'),
    not(see(list,down,[,'F'|])),
    writeln('Escape abajo punto').
% Si no hay puntos, mover por espacio
do1(izquierda, move(left)):-
    see(normal,left,' '),
    not(see(list,left,[,'F'|])),
    writeln('Izquierda espacio').
% Subir nivel
do1(izquierda, move(up)):-
    see(normal,left,'#'),
    not(see(normal,up,'#')),
    not(see(list,up,[,'F'|])),
    cambiar(derecha),
    writeln('Subir nivel').
% REGLAS DE ESCAPE
% Buscar punto seguro en cualquier dirección
do1(EST, move(DIR)):-
    member(EST,[derecha,izquierda]),
    member(DIR,[up,down,left,right]),
    see(normal,DIR,'.'),
    not(see(list,DIR,[,'F'|])),
    writeln('Escape a punto').
% Si no hay movimiento seguro a punto, usar espacio
do1(EST, move(DIR)):-
    member(EST,[derecha,izquierda]),
    member(DIR,[up,down,left,right]),
    see(normal,DIR,' '),
    not(see(list,DIR,[,'F'|])),
    writeln('Escape a espacio').
% Si no hay movimiento seguro, esperar
do1(_, move(none)):-
    writeln('Espera segura').espacio(' ').

blank(' ').
blank('l').

dir_D(up-left).
dir_D(up-right).
dir_D(down-left).
dir_D(down-right).

dir_valida(up).
dir_valida(down).
dir_valida(left).
dir_valida(right).

dir_updown(up).
dir_updown(down).

dir_leftright(left).
dir_leftright(right).



do(ACT):-estado(EST),do1(EST,ACT).


do1(izq, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).
do1(izq2, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).
do1(izq0, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).
do1(der, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).
do1(der0, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).
do1(der2, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).
do1(arriba, use(DIR)):-see(list,DIR,[_,'F']),havingObject,dir_valida(DIR).

do1(izq, move(none)):-see(normal,DIR,'F'),dir_D(DIR),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(izq2, move(none)):-see(normal,UD-LR,'F'),dir_updown(UD),dir_leftright(LR),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(izq0, move(none)):-see(normal,DIR,'F'),dir_D(DIR),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der, move(none)):-see(normal,DIR,'F'),dir_D(DIR),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der2, move(none)):-see(normal,DIR,'F'),dir_D(DIR),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der0, move(none)):-see(normal,DIR,'F'),dir_D(DIR),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(arriba, move(none)):-see(normal,DIR,'F'),dir_D(DIR),not(see(normal,DIR2,'F')),dir_valida(DIR2).


do1(izq, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(izq2, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(izq0, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der0, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der2, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(arriba, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(izq, get(DIR)):-see(normal,DIR,'l'),dir_valida(DIR),not(havingObject),not(see(normal,DIR2,'F')),dir_valida(DIR2).



do1(izq, use(left)):-see(normal,left,'F'),not(see(normal,left,'l')),havingObject.
do1(izq, use(right)):-see(normal,right,'F'),not(see(normal,right,'l')),havingObject.
do1(izq, use(up)):-see(normal,up,'F'),not(see(normal,up,'l')),havingObject.
do1(izq, use(down)):-see(normal,down,'F'),not(see(normal,down,'l')),havingObject.

do1(izq, move(right)):-see(list,left,['l','F']).

do1(der, use(left)):-see(normal,left,'F'),not(see(normal,left,'l')),havingObject.
do1(der, use(right)):-see(normal,right,'F'),not(see(normal,right,'l')),havingObject.
do1(der, use(up)):-see(normal,up,'F'),not(see(normal,up,'l')),havingObject.
do1(der, use(down)):-see(normal,down,'F'),not(see(normal,down,'l')),havingObject.

do1(izq2, use(left)):-see(normal,left,'F'),not(see(normal,left,'l')),havingObject.
do1(izq2, use(right)):-see(normal,right,'F'),not(see(normal,right,'l')),havingObject.
do1(izq2, use(up)):-see(normal,up,'F'),not(see(normal,up,'l')),havingObject.
do1(izq2, use(down)):-see(normal,down,'F'),not(see(normal,down,'l')),havingObject.

do1(der2, use(left)):-see(normal,left,'F'),not(see(normal,left,'l')),havingObject.
do1(der2, use(right)):-see(normal,right,'F'),not(see(normal,right,'l')),havingObject.
do1(der2, use(up)):-see(normal,up,'F'),not(see(normal,up,'l')),havingObject.
do1(der2, use(down)):-see(normal,down,'F'),not(see(normal,down,'l')),havingObject.


do1(izq, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq0, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq0, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq0, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq0, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).

do1(izq2, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq2, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq2, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(izq2, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).

do1(der0, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der0, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der0, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der0, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).

do1(der, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).

do1(arriba, move(none)):-see(normal,up-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(arriba, move(none)):-see(normal,up-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(arriba, move(none)):-see(normal,down-right,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(arriba, move(none)):-see(normal,down-left,'F'),not(see(normal,DIR,'F')),dir_valida(DIR).




do1(izq0, move(none)):-see(list,left,[_| ['F'|_] ]).
do1(izq0,move(up)):-see(normal,left,'F'),not(see(normal,up,'#')).
do1(izq0, move(up)):-see(normal,left,'.'),see(normal,up-left,'#'),see(normal,down,'#'),cambiar(der),write(der).
do1(izq0, move(left)):-see(normal,left,'.').
do1(izq0, move(left)):-see(normal,left,' ').
do1(izq0, move(left)):-see(normal,left,'l').
do1(izq0, move(right)):-not(see(normal,down,'#')),not(see(normal,right,'F')),cambiar(der0),write(der0).
do1(izq0,move(up)).


do1(der0,move(none)):-see(list,right,[_| ['F'|_] ]).
do1(der0,move(up)):-see(normal,right,'F'),not(see(normal,up,'#')).
do1(der0,move(none)):-see(normal,right,'F').
do1(der0, move(right)):-see(normal,right,'.').
do1(der0, move(right)):-see(normal,right,' ').
do1(der0, move(right)):-see(normal,right,'l').
do1(der0,move(none)):-see(list,down,[_| ['F'|_] ]).
do1(der0,move(none)):-see(normal,down-left,'F').
do1(der0, move(down)):-not(see(normal,down,'#')),not(see(normal,down,'F')),not(see(normal,up-right,'F')),cambiar(izq0),write(izq0).
do1(der0,move(left)).




do1(der2, move(right)):-see(list,right,['.','#']),see(normal,down,'#'),cambiar(arriba),write(arriba).
do1(der2, get(left)):-see(normal,left,'l'),not(havingObject),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, get(right)):-see(normal,right,'l'),not(havingObject),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, get(up)):-see(normal,up,'l'),not(havingObject),not(see(normal,DIR,'F')),dir_valida(DIR).
do1(der2, get(down)):-see(normal,down,'l'),not(havingObject),not(see(normal,DIR,'F')),dir_valida(DIR).




do1(arriba, use(left)):-see(normal,left,'F'),havingObject.
do1(arriba, use(right)):-see(normal,right,'F'),havingObject.
do1(arriba, use(up)):-see(normal,up,'F'),havingObject.
do1(arriba, use(down)):-see(normal,down,'F'),havingObject.
do1(arriba, move(none)):-see(list,up,[_| ['F'|_] ]).
do1(arriba, move(up)):-see(normal,up,'.').
do1(arriba, move(down)):-see(normal,up,'F'),not(see(normal,down,'#')).
do1(arriba,move(left)):-see(normal,down-left,'.'),cambiar(bajar),write(bajar).

do1(bajar, use(left)):-see(normal,left,'F'),havingObject.
do1(bajar, use(right)):-see(normal,right,'F'),havingObject.
do1(bajar, use(up)):-see(normal,up,'F'),havingObject.
do1(bajar, use(down)):-see(normal,down,'F'),havingObject.
do1(bajar, move(none)):-see(list,up,[_| ['F'|_] ]).
do1(bajar, move(down)):-see(normal,down,'.').
do1(bajar, move(up)):-see(normal,down,'F'),not(see(normal,up,'#')).
do1(bajar,move(left)):-see(normal,left,'.'),see(normal,down,' '),cambiar(izq3),write(izq3).


do1(izq3,move(left)):-see(normal,left,'.').
do1(izq3, move(left)):-see(normal,left,' ').
do1(izq3,move(up)):-see(normal,up,'.'),cambiar(der),write(der).

do1(izq,use(left)):-see(normal,left,'F'),not(see(normal,left,'l')),havingObject.
do1(izq,move(none)):-see(normal,up-right,'F'),see(normal,left,'#').
do1(izq, move(up)):-see(normal,up,' '),see(normal,up-right,'#'),see(normal,left,' ').
do1(izq,move(down)):-not(see(normal,down,'#')),see(normal,left,'F').
do1(izq, move(right)):-see(list,left,['l','F']),see(normal,right,' ').
do1(izq,move(none)):-see(list,left,[_| ['F'|_] ]).
do1(izq, move(down)):-not(see(normal,down,'#')),see(list,left,[_| ['F'|_] ]).
do1(izq, move(right)):-not(see(normal,right,'#')),see(list,left,[_| ['F'|_] ]).
do1(izq, move(none)):-see(normal,up-left,'F').
do1(izq, move(left)):-see(normal,left,'.').
do1(izq, move(left)):-see(normal,left,' ').
do1(izq, move(left)):-see(normal,left,'l').
do1(izq, move(right)):-not(see(normal,up,'#')),not(see(normal,right,'F')),cambiar(der),write(der).
do1(izq, move(down)):-see(normal,up,'#'),see(normal,left,'#'),see(normal,up-left,'#'),cambiar(der2),write(der2).

do1(der, move(none)):-see(list,right,[_| ['F'|_] ]).
do1(der,move(none)):-see(normal,up-left,'F').
do1(der,move(none)):-see(normal,down-right,'F').
do1(der, move(up)):-see(list,right,[' ','#']),see(list,up,[' ','#']),see(list,down,[' ','#']),cambiar(izq),write(izq),not(see(normal,DIR2,'F')),dir_valida(DIR2).
do1(der, move(right)):-see(normal,right,'.').
do1(der, move(right)):-see(normal,right,' ').
do1(der, move(right)):-see(normal,right,'l').
do1(der, move(up)):-not(see(normal,up,'#')),not(see(normal,up,'F')),not(see(normal,up-right,'F')),cambiar(izq),write(izq).

do1(der,move(left)).


do1(der2, move(up)):-see(list,right,['.','.']),see(normal,up-right,'#'),see(normal,down,'#'),see(normal,up,' '),cambiar(izq),write(izq).
do1(der2, move(left)):-not(see(normal,left,'#')),see(normal,up,'#'),see(normal,right,'#'),see(normal,down,' '),cambiar(izq2),write(izq2).
do1(der2, move(none)):-not(see(normal,up,'#')),see(list,right,['.'|['F'|_]]),havingObject.
do1(der2, move(none)):-not(see(normal,left,'#')),see(list,right,['.'|['F'|_]]),havingObject.
do1(der2,move(up)):-see(normal,up,'.'),see(normal,up-right,'#').
do1(der2, move(none)):-see(normal,down-right,'F').
do1(der2, move(none)):-see(list,right,[_|['F'|_]]).
do1(der2, move(right)):-see(normal,right,'.').
do1(der2,move(down)):-see(list,down,['.','.'|_]),see(normal,left,'#').
do1(der2,move(down)):-see(list,down,['.',' '|_]),see(normal,left,'#').
do1(der2,move(down)):-see(list,down,['.','#']),see(normal,left,'#').
do1(der2, move(right)):-see(normal,right,' ').
do1(der2, move(right)):-see(normal,right,'l').
do1(der2, move(down)):-see(normal,down,'.'),cambiar(izq2),write(izq2).
do1(der2, move(none)):-see(list,up,['.'|['F'|_]]),havingObject.
do1(der2,move(up)):-see(normal,up,'.').
do1(der2,move(up)):-see(normal,up,'l').
do1(der2,move(down)):-see(normal,right,'#'),see(normal,down,' '),see(normal,down-right,'.').
do1(der2,move(left)):-not(see(normal,left,'#')).
do1(der2, move(up)).

do1(izq2,move(up)):-see(normal,down,'F'),see(normal,left,'F'),see(normal,down-right,'F'),not(see(normal,up,'#')).
do1(izq2, move(up)):-see(list,up,['.','.','.'|_]),cambiar(der2),write(der2).
do1(izq2, move(none)):-not(see(normal,down,'#')),see(list,left,['.'|['F'|_]]),havingObject.
do1(izq2, move(none)):-not(see(normal,right,'#')),see(list,left,['.'|['F'|_]]),havingObject.
do1(izq2, move(right)):-see(normal,up-left,'#'),see(normal,left,'#'),see(list,right,V),member('.',V),cambiar(der2),write(der2).
do1(izq2, move(left)):-see(normal,left,'.').
do1(izq2, move(left)):-see(normal,left,' ').
do1(izq2,move(left)):-see(normal,left,'l').
do1(izq2, move(down)):-see(normal,down,'.'),cambiar(der2),write(der2).


