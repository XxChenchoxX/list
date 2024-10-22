import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Persona {
  final String nombre;
  final String cuenta;
  
  Persona({
    required this.nombre,
    required this.cuenta,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Eliminamos la etiqueta de debug
      title: 'Listado de alumnos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Persona> _personas = [
    Persona(nombre: 'Ricardo Guadalupe', cuenta: '20101589'),
    Persona(nombre: 'Pedro Garcia', cuenta: '20155689'),
    Persona(nombre: 'Luis Perez', cuenta: '20143625'),
    Persona(nombre: 'Pablo Manzo', cuenta: '20152345'),
    Persona(nombre: 'Carlos Ruiz', cuenta: '20164578'),
  ];

  void _agregarPersona() {
    setState(() {
      _personas.add(
        Persona(
          nombre: 'Nuevo Alumno', 
          cuenta: '2024${_personas.length + 1000}'
        ),
      );
    });
  }

  void _eliminarPersona(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Eliminar persona',
            style: TextStyle(fontSize: 20),
          ),
          content: Text(
            '¿Estas seguro de eliminar a: ${_personas[index].nombre}?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _personas.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Borrar',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de alumnos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (context, index) {
          final persona = _personas[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                persona.nombre[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(persona.nombre),
            subtitle: Text(persona.cuenta),
            trailing: const Icon(Icons.chevron_right),
            onLongPress: () => _eliminarPersona(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarPersona,
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }
}