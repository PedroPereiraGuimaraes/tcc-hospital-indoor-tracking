// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField('EMAIL', 'user@gmail.com', _emailController,
                  Icons.email_outlined, false),
              const SizedBox(height: 20),
              _buildTextField('PASSWORD', '*****************',
                  _passwordController, Icons.remove_red_eye_outlined, true),
              const SizedBox(height: 20),
            ],
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
          fontSize: 15,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          fontSize: 18,
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
