import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SayHello extends StatefulWidget {
  const SayHello({super.key});
  @override
  _SayHelloState createState() => _SayHelloState();
}

class _SayHelloState extends State<SayHello> {
  String nombre = ''; // Aquí se almacena el estado del nombre
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Say Hello'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Añade padding para espacio
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
          children: [
            // Campo de texto para ingresar el nombre
            TextField(
              controller: _controller, // Controlador del campo de texto
              decoration: InputDecoration(
                labelText: 'Inserta tu nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaciado entre campo de texto y botón

            // Botón de enviar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Color del botón
                foregroundColor: Colors.white, // Color del texto
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0, // Ancho del botón
                  vertical: 15.0,   // Altura del botón
                ),
              ),
              onPressed: () {
                setState(() {
                  // Validación: Si el campo está vacío, muestra un mensaje por defecto
                  nombre = _controller.text.isNotEmpty ? _controller.text : 'desconocido';
                });
              },
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 20), // Espacio entre botón y texto de salida

            // Texto para mostrar el saludo con el nombre
            Text(
              'Hola, $nombre!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30), // Espacio antes del botón de GitHub
          ],
        ),
      ),
    );
  }
}
