import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  void _launchURL() async {
    final Uri url = Uri.parse('https://github.com/C-Chanona/Moviles-Practica2');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> teamMembers = {
      'Miembro1': {
        'name': 'Carlos Eduardo Chanona Aquino',
        'id': '221233',
        'phone': '9614309361',
      },
    };

    final List<Widget> teamMembersList = teamMembers.entries.map((entry) {
      return Column(
        children: [
          // const SizedBox(height: 15), // Espacio entre foto y nombre
          Text(
            entry.value['name'] ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15), // Espacio entre nombre y matricula
          Text(
            entry.value['id'] ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15), // Espacio entre matricula y botones
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón de teléfono
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange.withOpacity(0.1),
                ),
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.phone),
                  onPressed: () async {
                    final phoneNumber =
                        Uri.parse('tel:${entry.value['phone']}');
                    if (await canLaunchUrl(phoneNumber)) {
                      await launchUrl(phoneNumber);
                    } else {
                      throw 'Could not launch $phoneNumber';
                    }
                  },
                ),
              ),
              const SizedBox(width: 20), // Separación entre botones
              // Botón de mensaje
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange.withOpacity(0.1),
                ),
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.message),
                  onPressed: () async {
                    final messageNumber =
                        Uri.parse('sms:${entry.value['phone']}');
                    if (await launchUrl(messageNumber)) {
                      await launchUrl(messageNumber);
                    } else {
                      throw 'Could not launch $messageNumber';
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Ajustar padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto de perfil
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/6.jpg'),
              ),
              const SizedBox(height: 20), // Espacio entre foto y nombre
              
              // Información de contacto (nombre y botones)
              ...teamMembersList,

              const SizedBox(height: 30), // Espacio antes del botón de GitHub

              // Botón para GitHub
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
                onPressed: _launchURL,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/octocat.png', width: 30, height: 30),
                    const SizedBox(width: 10),
                    const Text('Visitar Github'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
