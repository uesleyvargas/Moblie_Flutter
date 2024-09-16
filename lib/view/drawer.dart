import 'package:appadsgp1/view/home_page.dart';
import 'package:appadsgp1/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:appadsgp1/view/feriado_page.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              child: Text('Menu'),          
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Cursos'),
            onTap: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ),
              },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Feriados'),
            onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeriadoPage(),
                  ),
                );
              },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('sair'),
            onTap: () => {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                ),
              },
          ),
        ],
      ),
    );
  }
}