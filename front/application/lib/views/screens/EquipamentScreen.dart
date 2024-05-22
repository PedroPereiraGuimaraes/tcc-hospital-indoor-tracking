// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipamentScreen extends StatefulWidget {
  final String equipamentName;
  const EquipamentScreen({Key? key, required this.equipamentName})
      : super(key: key);

  @override
  State<EquipamentScreen> createState() => _EquipamentScreenState();
}

class _EquipamentScreenState extends State<EquipamentScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isAdmin: false,
        hasBackButton: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _buildTextField(
              "PESQUISAR",
              _searchController,
              Icons.search,
              false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Equipamento",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 129, 223),
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  CardEquipament("Equipamento 1", DateTime.now()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      IconData icon, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
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

  Widget CardEquipament(String equipamentName, DateTime lastMaintenance) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              equipamentName,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Últimas vez visto: ${lastMaintenance.day}/${lastMaintenance.month}/${lastMaintenance.year}",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ultima vez calibrado:",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // card azul com a informação de ultima vez calibrado
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 129, 223),
              borderRadius: BorderRadius.zero,
            ),
            child: Text(
              "24/02/2024",
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Próxima atualização: ",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 129, 223),
              borderRadius: BorderRadius.zero,
            ),
            child: Text(
              "5.1",
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tombo: ",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 129, 223),
              borderRadius: BorderRadius.zero,
            ),
            child: Text(
              "1234567890",
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 129, 223),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Calibrar",
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // o icone tem q estar dentro de um circulo azul

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
