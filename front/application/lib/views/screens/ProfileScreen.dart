import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/UserService.dart';
import 'package:front_end/views/widgets/Appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _registerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Supondo que `getUser` seja uma função no `UserService` que retorna os dados do usuário logado
    var user = await getUser();
    setState(() {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _registerController.text = user.register;
    });
  }

  void _updateUser() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String register = _registerController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('As senhas não coincidem'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        register.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      updateUser(name, email, password, register).then(
        (result) {
          if (result == 'Success') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Sucesso',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 129, 223),
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: Text(
                    'Perfil atualizado com sucesso.',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 129, 223),
                          fontFamily: GoogleFonts.josefinSans().fontFamily,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'ERRO',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 129, 223),
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: Text(
                    'Erro ao atualizar perfil. Por favor, tente novamente.',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 129, 223),
                          fontFamily: GoogleFonts.josefinSans().fontFamily,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isRoom: false,
        isAdmin: false,
        hasBackButton: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Perfil",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 129, 223),
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField("Nome", "Nome", _nameController, false),
                _buildTextField("Email", "Email", _emailController, false),
                _buildTextField("Senha", "Senha", _passwordController, true),
                _buildTextField("Confirmar Senha", "Confirmar Senha",
                    _confirmPasswordController, true),
                _buildTextField(
                    "Registro", "Registro", _registerController, false),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateUser,
                  child: Text(
                    'Atualizar Perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 129, 223),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String title, String hint,
      TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 0, 129, 223),
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          fontSize: 17,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 129, 223),
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
