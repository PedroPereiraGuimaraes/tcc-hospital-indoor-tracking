// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/LoginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/UserServices.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _registerNumberController =
      TextEditingController();

  RegisterCheck() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String registerNumber = _registerNumberController.text;
    registerUser(name, registerNumber, password, email).then((result){
      if (result == 'Success') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Registro completo!',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 129, 223),
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              content: Text(
                'Obrigado por se registrar conosco. Faça login para continuar.',
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 129, 223),
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
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
                'Alguns dados estão incompletos. Por favor, tente novamente.',
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
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 110,
                    height: 110,
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Faça agora seu',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CADASTRO',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 129, 223),
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  'NAME',
                  'Nome completo',
                  _nameController,
                  Icons.person_3_outlined,
                  false,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'EMAIL',
                  'user@gmail.com',
                  _emailController,
                  Icons.email_outlined,
                  false,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'PASSWORD',
                  '*****************',
                  _passwordController,
                  Icons.vpn_key_outlined,
                  true,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                    'REGISTRATION NUMBER',
                    '00000',
                    _registerNumberController,
                    Icons.confirmation_number_outlined,
                    false),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    RegisterCheck();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 129, 223),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Josefin Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Já tenho conta?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 129, 223),
                        fontFamily: GoogleFonts.josefinSans().fontFamily,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
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
      TextEditingController controller, IconData icon, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 0, 129, 223),
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          fontSize: 14,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          fontSize: 15,
        ),
        suffixIcon: Icon(
          icon,
          color: Color.fromARGB(255, 0, 129, 223),
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
