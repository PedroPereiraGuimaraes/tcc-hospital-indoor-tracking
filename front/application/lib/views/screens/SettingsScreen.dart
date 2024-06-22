// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/AdminScreen.dart';
import 'package:front_end/views/screens/ProfileScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _logout() {
    // Adicione aqui a lógica de logout, como limpar o token de autenticação e redirecionar para a tela de login.
    Navigator.of(context).pushReplacementNamed('/login'); // Supondo que '/login' seja a rota para a tela de login.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isRoom: false,
        isAdmin: false,
        hasBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CONFIGURAÇÕES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                color: Color.fromARGB(255, 0, 129, 223),
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Ativar notificações',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    color: Colors.grey[800],
                  )),
              value: _notificationsEnabled,
              activeColor: Color.fromARGB(255, 0, 129, 223),
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            ListTile(
              title: Text('Administrador',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    color: Colors.grey[800],
                  )),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 0, 129, 223),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Perfil',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    color: Colors.grey[800],
                  )),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 0, 129, 223),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            Spacer(), // Adiciona espaço flexível entre os itens e o botão de logout
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 129, 223), // Cor de fundo do botão
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _logout,
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}
