// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/database/models/EquipamentRoom.dart';
import 'package:front_end/views/screens/EquipmentListScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/RoomService.dart';
import 'package:intl/intl.dart';

class AddEquipamentList extends StatefulWidget {
  const AddEquipamentList({Key? key}) : super(key: key);

  @override
  State<AddEquipamentList> createState() => _AddEquipamentListState();
}

class _AddEquipamentListState extends State<AddEquipamentList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tomboController = TextEditingController();
  final TextEditingController _nextUpdateController = TextEditingController();
  final TextEditingController _lastCalibrationController = TextEditingController();
  final TextEditingController _lastSeenController = TextEditingController();
  
  List<String> _rooms = [];
  String? _selectedRoom;
  DateTime? _selectedLastCalibrationDate;
  DateTime? _selectedNextUpdateDate;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  void _loadRooms() async {
    List<dynamic> roomsJson = await getReadAll();
    List<String> rooms = roomsJson.map((e) => e['name'] as String).toList();
    
    setState(() {
      _rooms = rooms;
      if (_rooms.isNotEmpty) {
        _selectedRoom = _rooms[0];
      }
    });
  }

  Future<void> _selectDate(BuildContext context, bool isLastCalibration) async {
    DateTime initialDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

     if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        if (isLastCalibration) {
          _selectedLastCalibrationDate = pickedDate;
        } else {
          _selectedNextUpdateDate = pickedDate;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Selecione uma data';
    }
    return DateFormat('dd/MM/yyyy').format(date);
  }

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
                  CardEquipament(_nameController.text, DateTime.now()),
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Última vez visto',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 14,
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
            value: _selectedRoom,
            items: _rooms.map((String room) {
              return DropdownMenuItem<String>(
                value: room,
                child: Text(room),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedRoom = newValue!;
              });
            },
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text(
              'Última vez calibrado',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              _formatDate(_selectedLastCalibrationDate),
            ),
            trailing: Icon(Icons.calendar_today, color: Color.fromARGB(255, 0, 129, 223)),
            onTap: () => _selectDate(context, true),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text(
              'Próxima atualização',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              _formatDate(_selectedNextUpdateDate),
            ),
            trailing: Icon(Icons.calendar_today, color: Color.fromARGB(255, 0, 129, 223)),
            onTap: () => _selectDate(context, false),
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