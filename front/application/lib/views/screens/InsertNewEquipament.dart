// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/EquipmentListScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEquipamentList extends StatefulWidget {
  const AddEquipamentList({Key? key}) : super(key: key);

  @override
  State<AddEquipamentList> createState() => _AddEquipamentListState();
}

class _AddEquipamentListState extends State<AddEquipamentList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tomboController = TextEditingController();
  final TextEditingController _nextUpdateController = TextEditingController();
  final TextEditingController _lastCalibrationController =
      TextEditingController();
  final TextEditingController _lastSeenController = TextEditingController();
  @override
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
        child: Column(
          children: [
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
          fontSize: 14,
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
          _buildTextField(
            'Nome',
            'Nome do Equipamento',
            _nameController,
            false,
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Última vez visto',
            'Local que o equipamento está',
            _lastSeenController,
            false,
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Última vez calibrado',
            'Data da última calibração',
            _lastCalibrationController,
            false,
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Próxima atualização',
            'Número da versão do sistema',
            _nextUpdateController,
            false,
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Tombo',
            'Número do tombo',
            _tomboController,
            false,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentListScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 0, 129, 223),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'SALVAR',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Josefin Sans',
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
