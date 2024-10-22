class Usuario {
  final String nombre;
  final String login;
  final String password;
  final String email;

  Usuario({
    required this.nombre,
    required this.login,
    required this.password,
    required this.email,
  });
}

// Lista de usuarios para prueba
final List<Usuario> usuarios = [
  Usuario(
    nombre: "ricardo contreras",
    login: "ricardo contreras",
    password: "1234",
    email: "ricardo@email.com",
  ),
  Usuario(
    nombre: "nacho",
    login: "nacho",
    password: "1234",
    email: "nacho@email.com",
  ),
];