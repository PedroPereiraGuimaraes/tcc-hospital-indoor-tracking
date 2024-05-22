// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/database/services/EquipamentService.dart';
import 'package:front_end/views/screens/EquipmentListScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipamentScreen extends StatefulWidget {
  final String equipamentName;
  final String roomName;
  final String patrimonio;
  const EquipamentScreen({
    Key? key,
    required this.equipamentName,
    required this.roomName,
    required this.patrimonio,
  }) : super(key: key);

  @override
  State<EquipamentScreen> createState() => _EquipamentScreenState();
}

class _EquipamentScreenState extends State<EquipamentScreen> {
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
        child: Expanded(
          child: ListView(
            children: [
              CardEquipament(widget.equipamentName, DateTime.now()),
            ],
          ),
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
              "Ultima vez visto em: ",
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
              widget.roomName,
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
              "Patrimonio: ",
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
              widget.patrimonio,
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 129, 223),
                    padding: EdgeInsets.only(
                        top: 30, bottom: 30, left: 50, right: 50),
                  ),
                  child: Text(
                    "Atualizar",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      confirmAndDeleteEquipament(context,
                          int.parse(widget.patrimonio), equipamentName);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color.fromARGB(255, 124, 16, 16),
                      padding: EdgeInsets.only(
                          top: 30, bottom: 30, left: 10, right: 10),
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> confirmAndDeleteEquipament(
      BuildContext context, int patrimonio, String nome) async {
    TextEditingController textController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar exclusão',
            style: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.josefinSans().fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Você tem certeza que deseja excluir o equipamento $nome?',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Digite o nome do equipamento para confirmar',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Confirmar',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 129, 223),
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                String enteredName = textController.text.trim();
                if (enteredName.toLowerCase() == nome.toLowerCase()) {
                  deleteEquipament(patrimonio).then((result) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EquipmentListScreen(),
                      ),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao excluir equipamento!'),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nome do equipamento incorreto!'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
