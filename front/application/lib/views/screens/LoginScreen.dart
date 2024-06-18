// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/database/services/UserService.dart';
import 'package:front_end/views/screens/RegisterScreen.dart';
import 'package:front_end/views/screens/RoomsScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:front_end/database/models/User.dart';
import 'package:front_end/database/models/SetUser.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _registerController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? token = "";

  void LoginCheck() {
    String register = _registerController.text;
    String password = _passwordController.text;
    authenticate(register, password).then((result) {
      if (result != null) {
        var user = Provider.of<SUser>(context, listen: false);
        user.setUser(result['name'], result['email'], register, result['isAdmin']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RoomsScreen(),
          ),
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
                'Email ou senha incorretos. Por favor, tente novamente.',
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
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Continue com seu',
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
                    'LOGIN',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 129, 223),
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField('EMAIL', 'EMAIL', _registerController,
                    Icons.email_outlined, false),
                const SizedBox(height: 20),
                _buildTextField('PASSWORD', '*****************',
                    _passwordController, Icons.remove_red_eye_outlined, true),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    LoginCheck();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 129, 223),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
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
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Não tenho conta?',
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
