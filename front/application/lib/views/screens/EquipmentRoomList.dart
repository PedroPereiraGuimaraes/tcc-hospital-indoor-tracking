// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/EquipamentInfoScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipmentRoomList extends StatefulWidget {
  final String roomName;
  const EquipmentRoomList({Key? key, required this.roomName}) : super(key: key);
  @override
  State<EquipmentRoomList> createState() => _EquipmentRoomListState();
}

class _EquipmentRoomListState extends State<EquipmentRoomList> {
  final TextEditingController _searchController = TextEditingController();
  List<String> EquipamentNames =
      List.generate(10, (index) => "Equipamento $index");
  //print(EquipamentNames);

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
              'PESQUISAR',
              _searchController,
              Icons.search,
              false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Equipamentos da Sala ${widget.roomName}",
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
              child: ListView.builder(
                itemCount: EquipamentNames.length,
                itemBuilder: (context, index) {
                  final EquipamentName = EquipamentNames[index].toLowerCase();
                  final searchQuery = _searchController.text.toLowerCase();
                  return EquipamentName.contains(searchQuery)
                      ? CardEquipament(EquipamentNames[index], "Sala 1", "1234",
                          DateTime.now())
                      : SizedBox.shrink();
                },
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 129, 223),
          ),
        ),
      ),
    );
  }

  Widget CardEquipament(
      String name, String room, String patrimonio, DateTime time) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.blue,
      elevation: 2,
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 129, 223),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "Última vez visto: ${time.day}/${time.month}/${time.year}",
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 15,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 0, 129, 223),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EquipamentScreen(
                equipamentName: name,
                roomName: room,
                patrimonio: patrimonio,
              ),
            ),
          );
        },
      ),
    );
  }
}
