import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetRequestScreen extends StatefulWidget {
  const GetRequestScreen({super.key});
  @override
  _GetRequestScreenState createState() => _GetRequestScreenState();
}

class _GetRequestScreenState extends State<GetRequestScreen> {
  Future<Map<String, dynamic>>? _responseData;

  // Función para realizar la solicitud GET
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, devuelve los datos decodificados
      return json.decode(response.body);
    } else {
      // Si la solicitud falla, lanza un error
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GET Request'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _responseData = fetchData();  // Realizar la solicitud cuando se presiona el botón
                });
              },
              child: Text('Extraer datos'),
            ),
            const SizedBox(height: 20),
            _responseData == null
                ? Text('Presiona el botón para obtener datos.')
                : FutureBuilder<Map<String, dynamic>>(
                    future: _responseData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();  // Muestra un indicador de carga mientras espera
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Text('Título: ${snapshot.data!['title']}');
                      } else {
                        return Text('No hay datos.');
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
