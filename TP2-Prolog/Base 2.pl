%Base 2
% Pacientes
paciente(dni(10000100), nombre("Carlos", "Gómez"), tiempo_espera(24)).
paciente(dni(10000200), nombre("Lucía", "Fernández"), tiempo_espera(14)).
paciente(dni(10000300), nombre("Tomás", "Ramírez"), tiempo_espera(6)).
paciente(dni(10000400), nombre("Sofía", "Acosta"), tiempo_espera(12)).
paciente(dni(10000500), nombre("Mateo", "Benítez"), tiempo_espera(9)).
paciente(dni(10000600), nombre("Valentina", "Domínguez"), tiempo_espera(20)).

% Donantes
donante(dni(20000100), nombre("Raúl", "Gómez"), dni_paciente(10000100)).
donante(dni(20000200), nombre("Marina", "Fernández"), dni_paciente(10000200)).
donante(dni(20000300), nombre("Javier", "Ramírez"), dni_paciente(10000300)).
donante(dni(20000400), nombre("Elena", "Acosta"), dni_paciente(10000400)).
donante(dni(20000500), nombre("Pablo", "Benítez"), dni_paciente(10000500)).
donante(dni(20000600), nombre("Clara", "Domínguez"), dni_paciente(10000600)).

% Compatibilidades
compatibilidad(20000100, 10000200, 75.0).
compatibilidad(20000200, 10000300, 80.0).
compatibilidad(20000300, 10000400, 70.0).
compatibilidad(20000400, 10000500, 85.0).
compatibilidad(20000500, 10000600, 90.0).
compatibilidad(20000600, 10000100, 88.0).

% Compatibilidades extra (opciones secundarias)
compatibilidad(20000100, 10000400, 65.0).
compatibilidad(20000300, 10000100, 60.0).
compatibilidad(20000500, 10000200, 55.0).

% Factor delta
delta(2.0).

