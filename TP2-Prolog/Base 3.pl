%Base 3
% Pacientes
paciente(dni(40000100), nombre("Julia", "López"), tiempo_espera(10)).
paciente(dni(40000200), nombre("Martín", "Suárez"), tiempo_espera(18)).
paciente(dni(40000300), nombre("Carla", "Pereyra"), tiempo_espera(14)).
paciente(dni(40000400), nombre("Diego", "Morales"), tiempo_espera(9)).
paciente(dni(40000500), nombre("Santiago", "Navarro"), tiempo_espera(16)).
paciente(dni(40000600), nombre("Luz", "Silva"), tiempo_espera(22)).
paciente(dni(40000700), nombre("Emilia", "Torres"), tiempo_espera(7)).
paciente(dni(40000800), nombre("Franco", "Molina"), tiempo_espera(20)).

% Donantes
donante(dni(50000100), nombre("Hugo", "López"), dni_paciente(40000100)).
donante(dni(50000200), nombre("Nadia", "Suárez"), dni_paciente(40000200)).
donante(dni(50000300), nombre("Gonzalo", "Pereyra"), dni_paciente(40000300)).
donante(dni(50000400), nombre("Rocío", "Morales"), dni_paciente(40000400)).
donante(dni(50000500), nombre("Andrés", "Navarro"), dni_paciente(40000500)).
donante(dni(50000600), nombre("Patricia", "Silva"), dni_paciente(40000600)).
donante(dni(50000700), nombre("Ignacio", "Torres"), dni_paciente(40000700)).
donante(dni(50000800), nombre("Camila", "Molina"), dni_paciente(40000800)).

% Compatibilidades
compatibilidad(50000100, 40000200, 85.0).
compatibilidad(50000200, 40000300, 90.0).
compatibilidad(50000300, 40000400, 75.0).
compatibilidad(50000400, 40000500, 88.0).
compatibilidad(50000500, 40000600, 80.0).
compatibilidad(50000600, 40000700, 70.0).
compatibilidad(50000700, 40000800, 95.0).
compatibilidad(50000800, 40000100, 92.0).

% Compatibilidades adicionales (para más alternativas)
compatibilidad(50000100, 40000400, 60.0).
compatibilidad(50000300, 40000600, 68.0).
compatibilidad(50000500, 40000200, 65.0).
compatibilidad(50000700, 40000300, 72.0).

% Factor delta
delta(2.0).

