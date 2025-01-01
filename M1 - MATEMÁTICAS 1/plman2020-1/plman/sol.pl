:-use_module('pl-man-game/main').
% Estados
:-dynamic estado/1.
estado(bajar).

% Cambio de estado con logging
cambiar(EST):- retractall(estado(_)), assert(estado(EST)), writeln(EST).

% Predicados de detección
fantasma_diagonal(up-right) :- see(list, [up,right], L), member('F', L).
fantasma_diagonal(up-left) :- see(list, [up,left], L), member('F', L).
fantasma_diagonal(down-right) :- see(list, [down,right], L), member('F', L).
fantasma_diagonal(down-left) :- see(list, [down,left], L), member('F', L).

% Principal
do(X):- estado(EST), do1(EST,X).

% ESTADO: BAJAR
% Si hay punto abajo y es seguro, bajar
do1(bajar, move(up)) :- see(normal, left, 'F'), see(normal, down-left, 'F'), writeln("bajar1").
do1(bajar, move(up)) :- see(list,right,[_,'F'|_]), see(normal, down-left, 'F'), writeln("bajar1").

do1(bajar, move(up)) :- see(normal, right, 'F'), see(normal, down-left, 'F'), not(see(normal, up, 'F')), writeln("bajar1").

do1(bajar, move(left)) :- see(normal, left, ' '), see(normal, right, 'F'), see(normal, down-right, 'F'), writeln("bajarasf").

do1(bajar, move(right)) :- see(normal, down, 'F'), writeln("bajar2").
do1(bajar, move(right)) :- see(normal, down-left, 'F'), writeln("bajar3").
do1(bajar, move(left)) :- see(normal, down, 'F'), see(normal, right, '#'), writeln("bajar4").
do1(bajar, move(up)) :- see(normal, down-left, 'F'), see(list,right,[_,'F'|_]), writeln("bajar5").
do1(bajar, move(none)) :- see(normal, down-right, 'F'), writeln("bajar6").

do1(bajar, move(down)):-
    see(normal,down,'.'),
    not(see(list,down,[_,'F'|_])),
    not(fantasma_diagonal(down-right)),
    not(fantasma_diagonal(down-left)),
    writeln('Bajo por punto').

% Evasión diagonal en bajada
do1(bajar, move(right)):-
    fantasma_diagonal(down-left),
    see(normal,right,'.'),
    not(see(list,right,[_,'F'|_])),
    writeln('Evade diagonal derecha').

do1(bajar, move(left)):-
    fantasma_diagonal(down-right),
    see(normal,left,'.'),
    not(see(list,left,[_,'F'|_])),
    writeln('Evade diagonal izquierda').

% Si hay fantasma abajo, moverse a los lados si hay puntos
do1(bajar, move(right)):-
    see(list,down,[_,'F'|_]),
    see(normal,right,'.'),
    not(see(list,right,[_,'F'|_])),
    writeln('Esquiva derecha punto').

do1(bajar, move(left)):-
    see(list,down,[_,'F'|_]),
    see(normal,left,'.'),
    not(see(list,left,[_,'F'|_])),
    writeln('Esquiva izquierda punto').

% Continuar bajando por espacio vacío si es seguro
do1(bajar, move(down)):-
    not(see(normal,down,'#')),
    not(see(list,down,[_,'F'|_])),
    not(fantasma_diagonal(down-right)),
    not(fantasma_diagonal(down-left)),
    writeln('Bajo seguro').

% Al llegar abajo, comenzar barrido
do1(bajar, move(right)):-
    see(normal,down,'#'),
    not(see(normal, right, 'F')),
    cambiar(derecha),
    writeln('Inicio derecha').

do1(bajar, move(up)):-
    see(normal,down,'#'),
    cambiar(derecha),
    writeln('Inicio derecha').

% ESTADO: DERECHA
% Si hay punto, intentar comerlo si es seguro
do1(derecha, move(right)) :- see(normal, down-right, 'F'), see(normal, up-left, 'F'), writeln("derecha1").

do1(derecha, move(up)) :- see(normal, left, 'F'), see(normal, down, '.'), see(list,down,[_,'F'|_]), writeln("derecha345").

do1(derecha, move(up)) :- see(list,left,[_,'F'|_]), see(normal, down, '.'), see(list,down,[_,'F'|_]), writeln("derecha345").

do1(derecha, move(up)) :- see(normal, left, 'F'), see(list,right,[_,'#'|_]), writeln("derecha1").

do1(derecha, move(right)) :- see(normal, down-right, '#'), see(normal, up-right, 'F'), see(normal, left, 'F'), writeln("derecha1").

do1(derecha, move(up)) :- see(normal, left, 'F'), see(list,right,[_,'F'|_]), writeln("derecha2234").

do1(derecha, move(right)) :- see(normal, left, 'F'), see(normal, down-right, 'F'), writeln("derecha2").
do1(derecha, move(left)) :- see(normal, right, 'F'), see(normal, up-right, 'F'), writeln("derecha3").
do1(derecha, move(down)) :- see(normal, up-right, 'F'), writeln("derecha4").
do1(derecha, move(right)) :- see(normal, down-right, 'F'), see(normal, up, 'F'), writeln("derecha4").
do1(derecha, move(up)) :- see(normal, down-right, 'F'), not(see(normal, left, 'F')), writeln("derecha5").
do1(derecha, move(down)) :- see(normal, right, 'F'), see(normal, up-left, 'F'), writeln("derecha6").
do1(derecha, move(up)) :- see(normal, down-left, 'F'), see(normal, down, '.'), see(list,right,[_,'F'|_]), writeln("derecha345").
do1(derecha, move(right)) :- see(normal, down-left, 'F'), see(normal, down, '.'), writeln("derecha7").
do1(derecha, move(right)) :- see(normal, down, '.'),see(normal, down-left, 'F'), see(list,down,[_,'F'|_]), writeln("derecha123").
do1(derecha, move(down)) :- see(normal, down, '.'), writeln("derecha8").

do1(derecha, move(right)):-
    see(normal,right,'.'),
    not(see(list,right,[_,'F'|_])),
    not(fantasma_diagonal(up-right)),
    not(fantasma_diagonal(down-right)),
    writeln('Derecha punto').

% Si hay fantasma, buscar puntos seguros alrededor
do1(derecha, move(down)) :- see(normal, up-right, 'F'),see(list,left,[_,'F'|_]), writeln("dere9").

do1(derecha, move(left)) :- see(normal, up-right, 'F'), writeln("dere10").

do1(derecha, move(left)) :- see(normal, up-left, 'F'), see(list,right,[_,'F'|_]), writeln("dere10").

do1(derecha, move(up)):-
    (see(list,right,[_,'F'|_]) ; fantasma_diagonal(down-right)),
    see(normal,up,'.'),
    not(see(list,up,[_,'F'|_])),
    not(fantasma_diagonal(up-right)),
    writeln('Escape arriba punto').

do1(derecha, move(down)):-
    (see(list,right,[_,'F'|_]) ; fantasma_diagonal(up-right)),
    see(normal,down,'.'),
    not(see(list,down,[_,'F'|_])),
    not(fantasma_diagonal(down-right)),
    writeln('Escape abajo punto').

% Si no hay puntos, mover por espacio seguro
do1(derecha, move(up)) :- see(normal, left, 'F'), see(normal, down-left, 'F'), see(normal, down-right, 'F'), writeln("dere11").
do1(derecha, move(up)) :- see(normal, right, 'F'), see(normal, down-right, 'F'), writeln("dere12").
do1(derecha, move(down)) :- see(normal, up-left, 'F'), see(list,left,[_,'F'|_]), writeln("dere13").
do1(derecha, move(up)) :- see(normal, up-right, 'F'), see(normal, left, 'F'), writeln("dere14").

do1(derecha, move(down)) :- see(normal, up-right, 'F'), see(normal, left, 'F'), see(normal, right, '#'), writeln("dere14").

do1(derecha, move(right)):-
    see(normal,right,' '),
    not(see(list,right,[_,'F'|_])),
    not(fantasma_diagonal(up-right)),
    not(fantasma_diagonal(down-right)),
    writeln('Derecha espacio').

% Cambio a izquierda
do1(derecha, move(left)) :- see(normal, right, 'F'),see(normal, down-left, 'F'), see(normal, up, 'F'), writeln("dere15").
do1(derecha, move(up)) :- see(normal, down-left, 'F'), writeln("dere15").

do1(derecha, move(left)):-
    see(normal,right,'#'), not(see(normal, left, 'F')), not(see(list,left,[_,'F'|_])),
    cambiar(izquierda),
    writeln('Cambio izquierda').

% ESTADO: IZQUIERDA
% Si hay punto, intentar comerlo si es seguro
do1(izquierda, move(left)) :- see(normal, left, 'F'), see(normal, up-left, 'F'), writeln("izq1asdf").
do1(izquierda, move(up)) :- see(normal, right, 'F'), see(list,down,[_,'F'|_]), see(normal, down, ' '), writeln("izq1asdf").
do1(izquierda, move(right)) :- see(normal, up-left, 'F'), see(normal, up-left, 'F'), see(normal, down, '#'), writeln("izq1asdf").
do1(izquierda, move(up)) :- see(normal, down-left, 'F'), see(normal, left, 'F'), writeln("izq1asdf").

do1(izquierda, move(right)) :- see(normal, down-left, 'F'), see(list,left,[_,'F'|_]), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, 'F'), see(normal, left, 'F'), see(normal, down, ' '), see(normal, up, '.'), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, 'F'), see(normal, up, 'F'), see(normal, down, ' '), not(see(normal,left, '#')), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, 'F'), see(normal, down-left, 'F'), see(normal, down, 'F'), see(normal, up, ' '), writeln("izq1asdf").

do1(izquierda, move(up)) :- see(normal, right, 'F'), see(normal, left, 'F'), see(normal, down-right, 'F'), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, ' '), see(normal, up-left, 'F'), see(normal, down, '#'), see(normal, up, 'F'), writeln("izq1asdf").

do1(izquierda, move(right)) :- see(normal, up-right, '#'), see(normal, up-left, 'F'), see(normal, down, ' '), see(normal, up, 'F'), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, 'F'), see(normal, up-left, ' '), see(normal, down, '#'), see(normal, up, ' '), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, 'F'), see(normal, up-left, ' '), see(normal, down, ' '), see(normal, up, ' '), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, up-right, 'F'), see(normal, up-left, ' '), see(normal, down, ' '), see(normal, up, '.'), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, right, 'F'), see(normal, up-left, 'F'), writeln("izq1asdf").

do1(izquierda, move(left)) :- see(normal, right, 'F'), see(normal, up-left, 'F'), writeln("izq1").
do1(izquierda, move(down)) :- see(normal, left, 'F'), see(normal, up, 'F'), see(normal, right, 'F'),see(normal, down, ' '), writeln("izq123").
do1(izquierda, move(right)) :- see(normal, left, 'F'), see(normal, up, 'F'), writeln("izq2").
do1(izquierda, move(up)) :- see(normal, right, 'F'), see(normal, down-right, 'F'),see(normal, down-left, 'F'), writeln("izq3").
do1(izquierda, move(down)) :- see(normal, down, 'F'), see(normal, down, '.'), see(normal, down-right, 'F'), writeln("izq4").

do1(izquierda, move(down)) :- see(normal, left, 'F'), see(list,right,[_,'F'|_]),see(normal, down, ' '), see(normal, up, 'F'), writeln("izq5234").

do1(izquierda, move(down)) :- see(normal, down-right, ' '), see(normal, down, ' '), see(normal, left, 'F'), see(normal, up, '#'), writeln("izq5").

do1(izquierda, move(up)) :- see(normal, down-right, 'F'), see(normal, down, 'F'),see(normal, left, 'F'), writeln("izq5").
do1(izquierda, move(down)) :- see(normal, up-left, 'F'), not(see(normal, down, '#')), writeln("izq6").
do1(izquierda, move(left)) :- see(normal, down-right, 'F'), see(normal, right, 'F'), writeln("izq7").

do1(izquierda, move(right)) :- see(normal, up, 'F'),see(normal, left, '#'), writeln("izq8").

do1(izquierda, move(left)) :- see(normal, down-right, 'F'), writeln("izq8").
do1(izquierda, move(down)) :- see(normal, down, '.'), writeln("izq9").
do1(izquierda, move(up)) :- see(normal, down-left, 'F'), see(normal, down, 'F'), writeln("izq10").
do1(izquierda, move(right)) :- see(normal, up-right, 'F'); see(nomal, up-left, 'F'), see(normal, left, 'F'), writeln("izq11").
do1(izquierda, move(left)) :- see(normal, down-left, 'F'), writeln("izq12").

do1(izquierda, move(left)):-
    see(normal,left,'.'),
    not(see(list,left,[_,'F'|_])),
    not(fantasma_diagonal(up-left)),
    not(fantasma_diagonal(down-left)),
    writeln('Izquierda punto').

% Si hay fantasma, buscar puntos seguros alrededor
do1(izquierda, move(left)) :- see(normal, up-right, 'F'), writeln("izq13").

do1(izquierda, move(up)):-
    (see(list,left,[_,'F'|_]) ; fantasma_diagonal(down-left)),
    see(normal,up,'.'),
    not(see(list,up,[_,'F'|_])),
    not(fantasma_diagonal(up-left)),
    writeln('Escape arriba punto').

do1(izquierda, move(down)):-
    (see(list,left,[_,'F'|_]) ; fantasma_diagonal(up-left)),
    see(normal,down,'.'),
    not(see(list,down,[_,'F'|_])),
    not(fantasma_diagonal(down-left)),
    writeln('Escape abajo punto').

% Si no hay puntos, mover por espacio seguro
do1(izquierda, move(down)) :- see(normal, left, 'F'), see(normal, up, 'F'), writeln("izq14").
do1(izquierda, move(down)) :- see(normal, left, 'F'), see(normal, up, '#'), writeln("izq15").
do1(izquierda, move(right)) :- see(normal, up, 'F'), see(normal, up-left, 'F'), writeln("izq16").
do1(izquierda, move(left)) :- see(normal, right, 'F'), see(normal, down-right, 'F'), writeln("izq17").
do1(izquierda, move(down)) :- see(normal, left, 'F'), see(normal, up-left, 'F'), see(normal, right, 'F'), writeln("izq18").
do1(izquierda, move(down)) :- see(normal, left, 'F'), see(normal, up, 'F'), writeln("izq19").
do1(izquierda, move(left)) :- see(normal, up, ' '), see(normal, up-right, 'F'), writeln("izq20").

do1(izquierda, move(down)) :- see(normal, up, 'F'), see(list,right,[_,'F'|_]), writeln("izq20").

do1(izquierda, move(left)):-
    see(normal,left,' '),
    not(see(list,left,[_,'F'|_])),
    not(fantasma_diagonal(up-left)),
    not(fantasma_diagonal(down-left)),
    writeln('Izquierda espacio').

% Subir nivel si es seguro
do1(izquierda, move(right)) :- see(normal, up, 'F'), see(normal, right, ' '), writeln("izq21").
do1(izquierda, move(right)) :- see(normal, up-right, 'F'), see(normal, right, ' '), writeln("izq22").
do1(izquierda, move(right)) :- see(normal, up, 'F'), see(normal, down-right, 'F'), writeln("izq23").

do1(izquierda, move(up)):-
    see(normal,left,'#'),
    not(see(normal,up,'#')),
    not(see(list,up,[_,'F'|_])),
    not(fantasma_diagonal(up-left)),
    not(fantasma_diagonal(up-right)),
    cambiar(derecha),
    writeln('Subir nivel').

% REGLAS DE ESCAPE MEJORADAS
% Escape preventivo si hay múltiples fantasmas cerca
do1(EST, move(DIR)):-
    member(EST,[derecha,izquierda]),
    member(DIR,[up,down,left,right]),
    see(normal,DIR,'.'),
    not(see(list,DIR,[_,'F'|_])),
    (fantasma_diagonal(up-right) ; fantasma_diagonal(up-left) ;
     fantasma_diagonal(down-right) ; fantasma_diagonal(down-left)),
    writeln('Escape preventivo punto').

% Buscar punto seguro en cualquier dirección
do1(EST, move(DIR)):-
    member(EST,[derecha,izquierda]),
    member(DIR,[up,down,left,right]),
    see(normal,DIR,'.'),
    not(see(list,DIR,[_,'F'|_])),
    writeln('Escape a punto').

% Si no hay movimiento seguro a punto, usar espacio
do1(EST, move(DIR)):-
    member(EST,[derecha,izquierda]),
    member(DIR,[up,down,left,right]),
    see(normal,DIR,' '),
    not(see(list,DIR,[_,'F'|_])),
    writeln('Escape a espacio').

% Si no hay movimiento seguro, esperar
do1(_, move(up)):-
    writeln('Espera segura').
