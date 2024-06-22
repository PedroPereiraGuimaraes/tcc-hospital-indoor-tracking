// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:front_end/database/models/User.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/UserService.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<String> _cargos = [
    'Administrador',
    'Colaborador',
  ];

  List<User> _users = [];

  void _fetchUsers() {
    getAllUsers().then((users) {
      setState(() {
        _users = users.map<User>((user) => User.fromJson(user)).toList();
      });
    }).catchError((error) {
      print('Failed to fetch users: $error');
    });
  }

  void _changeUserAdmin(String register, bool isAdmin) {
    changeUserAdmin(register, isAdmin).then((result) {
      if (result == 'Success') {
        _fetchUsers();
      } else {
        print('Failed to change user admin');
      }
    }).catchError((error) {
      print('Failed to change user admin: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _cargos = ['Administrador', 'Colaborador'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isRoom: false,
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
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 129, 223),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        _users[index].name.toString(),
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        _users[index].isAdmin == true
                            ? 'Administrador'
                            : _users[index].isAdmin == false
                                ? 'Colaborador'
                                : 'Cargo não definido',
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                      onTap: () => _showCargoSelectionDialog(context, index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCargoSelectionDialog(
      BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Selecione o Cargo',
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _cargos.map((cargo) {
              return ListTile(
                title: Text(
                  cargo,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _changeUserAdmin(
                        _users[index].registration.toString(), true);
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
