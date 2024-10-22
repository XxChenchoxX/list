import 'package:flutter/material.dart';
import '../models/usuario.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  int _attempts = 0;

  void _validateAndLogin() {
    final login = _loginController.text;
    final password = _passwordController.text;

    // Validar campos vacíos
    if (login.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    setState(() {
      _attempts++;
    });

    // Buscar usuario
    final usuarioEncontrado = usuarios.firstWhere(
      (user) => user.login == login && user.password == password,
      orElse: () => Usuario(nombre: '', login: '', password: '', email: ''),
    );

    if (usuarioEncontrado.login.isNotEmpty) {
      // Usuario encontrado, ir a la pantalla de bienvenida
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(usuario: usuarioEncontrado),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Inicio de sesión',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                labelText: 'Login',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _validateAndLogin,
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 16),
            Text(
              'Intentos: $_attempts',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}