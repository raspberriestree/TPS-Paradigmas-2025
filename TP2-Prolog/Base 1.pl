%Base 1
% Pacientes
paciente(dni(23100200), nombre("Juan", "Martínez"), tiempo_espera(18)).
paciente(dni(37123456), nombre("Ariel", "Lencina"), tiempo_espera(15)).
paciente(dni(27561894), nombre("Ana", "Ramos"), tiempo_espera(8)).
paciente(dni(25450295), nombre("Fernando", "Pérez"), tiempo_espera(20)).

% Donantes
donante(dni(25200100), nombre("Luis", "Martínez"), dni_paciente(23100200)).
donante(dni(33292500), nombre("Pedro", "Sánchez"), dni_paciente(37123456)).
donante(dni(26854963), nombre("María", "Ramos"), dni_paciente(27561894)).
donante(dni(24700600), nombre("Andrea", "Vera"), dni_paciente(25450295)).

% Compatibilidades
compatibilidad(25200100, 37123456, 80.0).
compatibilidad(25200100, 27561894, 55.0).
compatibilidad(25200100, 25450295, 75.0).
compatibilidad(33292500, 23100200, 90.0).
compatibilidad(33292500, 25450295, 58.0).
compatibilidad(26854963, 23100200, 60.0).
compatibilidad(26854963, 37123456, 72.0).
compatibilidad(26854963, 27561894, 20.0).
compatibilidad(26854963, 25450295, 65.0).
compatibilidad(24700600, 37123456, 70.0).
compatibilidad(24700600, 27561894, 85.0).

% Demas cosas
delta(2.0).
