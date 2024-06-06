// ignore_for_file: prefer_const_constructors, ignore_for_file: file_names, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:front_end/database/models/EquipamentRoom.dart';
import 'package:front_end/database/services/RoomService.dart';
import 'package:front_end/views/screens/EquipamentInfoScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/models/Room.dart';

class EquipmentRoomList extends StatefulWidget {
  final String roomName;
  const EquipmentRoomList({Key? key, required this.roomName}) : super(key: key);
  @override
  State<EquipmentRoomList> createState() => _EquipmentRoomListState();
}

class _EquipmentRoomListState extends State<EquipmentRoomList> {
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> equipamentList = [];
  late final EquipamentName = '';

  Future<void> getEquipaments() async {
    String roomName = widget.roomName;
    List<dynamic> equipaments = await getReadOne(roomName);
    equipamentList =
        equipaments.map((e) => EquipamentRoom.fromJson(e)).toList();
    setState(() {
      equipamentList = equipamentList;
    });
    print(equipamentList[0].equipments[0].equipment);
  }

  @override
  void initState() {
    super.initState();
    getEquipaments();
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
            // COLOCAR AWAIT AQUI
            Expanded(
              child: ListView.builder(
                itemCount: equipamentList[0].equipments.length,
                itemBuilder: (context, index) {
                  final searchQuery = _searchController.text.toLowerCase();
                  return EquipamentName.contains(searchQuery)
                      ? CardEquipament(
                          equipamentList[0].equipments[index].equipment,
                          widget.roomName,
                          equipamentList[0].equipments[index].patrimonio,
                          DateTime.now(),
                        )
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
    String name,
    String room,
    String patrimonio,
    DateTime time,
  ) {
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
