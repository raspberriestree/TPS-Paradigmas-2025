% ------------------------------------------------------------------------
registrado(Donante, Paciente) :-
  donante(dni(DniD), nombre(NombreD, ApellidoD), dni_paciente(DniP)), %Aca lo que hacemos es utilizar decirle al predicado que use la regla donante/3, entones Prolog buscara todos los hechos que empiecen con donante y tengan 3 variables
  paciente(dni(DniP), nombre(NombreP, ApellidoP), _Tiempo_espera), %Lo mismo que antes pero con paciente/3
  string_concat(NombreD, " ", TempD), %Lo que hace string_concat/3 es concatenar el primer argumento con el segundo y guardarlo en el tercero, osea concatena NombreD con " " y guarda todo en TempD
  string_concat(TempD, ApellidoD, NombreCompletoD),
  Donante = donante(DniD, NombreCompletoD),
  string_concat(NombreP, " ", TempP),
  string_concat(TempP, ApellidoP, NombreCompletoP),
  Paciente = paciente(DniP, NombreCompletoP).
    
%compatible(Donante, Paciente)
%Este predicado es exitoso cuando la compatibilidad entre Donante y Paciente es
%mayor o igual al 50%, lo cual significa que puede realizarse el trasplante. El Donante
%puede estar registrado para cualquier paciente.
compatible(Donante, Paciente) :-
  Donante = donante(DniD, NombreCompletoD),
  Paciente = paciente(DniP, NombreCompletoP),
  compatibilidad(DniD, DniP, Comp),
  Comp >= 50.0,
  donante(dni(DniD), nombre(NombreD, ApellidoD), _),
  string_concat(NombreD, " ", TempD),
  string_concat(TempD, ApellidoD, NombreCompletoD),
  paciente(dni(DniP), nombre(NombreP, ApellidoP), _),
  string_concat(NombreP, " ", TempP),
  string_concat(TempP, ApellidoP, NombreCompletoP).
  
%prioridad(Donante, Paciente, P)
%Este predicado permite obtener la prioridad P que tendrá la donación de un riñón de
%Donante a Paciente, de acuerdo a la fórmula indicada previamente y utilizando el
%valor ? definido en el programa. El predicado falla si Donante y Paciente no son compatibles.
prioridad(Donante, Paciente, P) :-
  compatible(Donante, Paciente),
  Donante = donante(DniD, _),
  Paciente = paciente(DniP, _),
  compatibilidad(DniD, DniP, Comp),
  delta(Delta),
  paciente(dni(DniP), _, tiempo_espera(TiempoMeses)),
  P is Comp + (Delta * (TiempoMeses/12)).  %Aca se usa el is en vez del = porque si pongo = se copia toda la operacion, con el is solo guarda el resultado
  
%lista_pacientes(Umbral, ListaPacientes)
%Permite obtener la lista de pacientes en la base de datos que tienen al menos Umbral
%meses de tiempo de espera.

lista_pacientes(Umbral, ListaPacientes) :-
    recolectar_pacientes(Umbral, [], ListaPacientes).

% Caso 1: hay un paciente con tiempo >= Umbral que aún no está en la lista acumulada
recolectar_pacientes(Umbral, Parcial, ListaFinal) :-
    paciente(dni(Dni), nombre(Nombre, Apellido), tiempo_espera(Tiempo)),
    Tiempo >= Umbral,
    string_concat(Nombre, " ", Temp),
    string_concat(Temp, Apellido, NombreCompleto),
    not(member(paciente(Dni, NombreCompleto), Parcial)), !,
    append(Parcial, [paciente(Dni, NombreCompleto)], NuevoParcial),
    recolectar_pacientes(Umbral, NuevoParcial, ListaFinal).

% Caso 2: no quedan más pacientes que cumplan la condición ? devolvemos la lista final
recolectar_pacientes(_, Lista, Lista).

% trasplantes(ListaPacientes, ListaTrasplantes)
%Permite hallar una cadena de asignación de trasplantes, representada por
%ListaTrasplantes, para los pacientes en ListaPacientes. Debe evitar la obtención de soluciones redundantes.

trasplantes([PrimerPaciente | RestoPacientes], ListaTrasplantes) :-
    registrado(DonanteInicial, PrimerPaciente),
    length([PrimerPaciente | RestoPacientes], CantPacientes),
    armar_cadena(DonanteInicial, [PrimerPaciente | RestoPacientes], [PrimerPaciente], ListaTrasplantes, PrimerPaciente, CantPacientes).

                            
% Caso base:
% Cuando se alcanzó la cantidad total de pacientes visitados
% y el último donante puede donar al primero (cadena cerrada).
armar_cadena(DonanteActual, _TodosPacientes, Visitados, [[DonanteActual, PrimerPaciente]], PrimerPaciente, CantPacientes) :-
    length(Visitados, CantPacientes),
    compatible(DonanteActual, PrimerPaciente).

% Caso recursivo:
% Buscar un paciente compatible que aún no haya sido trasplantado.
armar_cadena(DonanteActual, TodosPacientes, Visitados, [[DonanteActual, PacienteDestino] | RestoTrasplantes], PrimerPaciente, CantPacientes) :-
    member(PacienteDestino, TodosPacientes),
    not(member(PacienteDestino, Visitados)),
    compatible(DonanteActual, PacienteDestino),
    registrado(DonanteDestino, PacienteDestino),
    append(Visitados, [PacienteDestino], NuevosVisitados),
    armar_cadena(DonanteDestino, TodosPacientes, NuevosVisitados, RestoTrasplantes, PrimerPaciente, CantPacientes).
    
% prioridad_minima(ListaTrasplantes, Min)
% Obtiene la prioridad mínima dentro de una cadena de trasplantes.

prioridad_minima([[Donante, Paciente]], P) :- prioridad(Donante, Paciente, P).

prioridad_minima([[Donante, Paciente] | Resto], Min) :-
    prioridad(Donante, Paciente, P),
    prioridad_minima(Resto, MinResto),
    menor(P, MinResto, Min).
    
% Predicado auxiliar: menor/3
menor(X, Y, X) :- X < Y.
menor(X, Y, Y) :- X >= Y.

% cadena_trasplantes_optima(ListaPacientes, ListaTrasplantes)
% Devuelve una única cadena de trasplantes cuyo mínimo de prioridad sea máximo
% entre todas las cadenas posibles (se compromete con la primera candidata
% que resulta ser globalmente óptima).
cadena_trasplantes_optima(ListaPacientes, CadenaOptima) :-
    trasplantes(ListaPacientes, CadenaCand),
    prioridad_minima(CadenaCand, MinCand),
    % no debe existir otra cadena con prioridad mínima estrictamente mayor
    \+ ( trasplantes(ListaPacientes, OtraCad),
         prioridad_minima(OtraCad, MinOtra),
         MinOtra > MinCand
       ),
    !,
    CadenaOptima = CadenaCand.

% cadena_trasplantes_completa(Umbral, ListaTrasplantes)
% Obtiene una cadena de trasplantes óptima que incluye a todos los pacientes
% con al menos Umbral meses en lista de espera.

cadena_trasplantes_completa(Umbral, ListaTrasplantes) :-
    lista_pacientes(Umbral, ListaPacientes),
    cadena_trasplantes_optima(ListaPacientes, ListaTrasplantes).
    





                
