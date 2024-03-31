// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/AdminScreen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
                fontSize: 20,
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
              title: Text('Idioma',
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
                // Navegar para a tela de seleção de idioma
              },
            ),
            ListTile(
              title: Text('Privacidade',
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
                // Navegar para a tela de configurações de privacidade
              },
            ),
            ListTile(
              title: Text('Sobre',
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
                // Navegar para a tela de informações sobre o aplicativo
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}
