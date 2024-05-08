// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:front_end/database/models/User.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<User> _users = [
    // User(name: 'Pedro Pereira Guimarães', cargo: 'Administrador'),
    User(name: 'Maria da Silva'),
    User(name: 'João da Silva'),
    User(name: 'Felipe Arlindo'),
    User(name: 'Ana Maria'),
  ];

  List<String> _cargos = [
    'Administrador',
    'Colaborador',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isAdmin: false,
        hasBackButton: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'USUÁRIOS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  color: Color.fromARGB(255, 0, 129, 223),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _users[index].name.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.josefinSans().fontFamily,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        _users[index].isAdmin == true
                            ? 'Administrador'
                            : _users[index].isAdmin == false
                                ? 'Colaborador'
                                : 'Cargo não definido',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.josefinSans().fontFamily,
                          color: Colors.grey[500],
                        ),
                      ),
                      onTap: () => _showcargoSelectionDialog(context, index),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _showcargoSelectionDialog(
      BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Cargo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.josefinSans().fontFamily,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _cargos.map((cargo) {
              return ListTile(
                title: Text(
                  cargo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    color: Colors.grey[900],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _users[index].isAdmin = cargo == 'Administrador';
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
