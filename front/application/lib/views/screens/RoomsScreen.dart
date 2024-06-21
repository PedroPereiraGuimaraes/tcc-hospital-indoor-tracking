// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/EquipmentRoomList.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/models/Room.dart';
import 'package:front_end/database/services/RoomService.dart';
import 'package:front_end/database/models/SetUser.dart';
import 'package:provider/provider.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _isAdmin = ValueNotifier<bool>(false);
  List<Room> roomsList = [];

  Future<void> getRooms() async {
    List<dynamic> rooms = await getReadAll();
    roomsList = rooms.map((e) => Room.fromJson(e)).toList();
   
    setState(() {
      roomsList = roomsList;
    });
  }

  @override
  void initState() {
    super.initState();
    getRooms();
    _loadUserData();
  }

   void _loadUserData() {
    var user = Provider.of<SUser>(context, listen: false);
    setState(() {
     
      _isAdmin.value = user.isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isRoom: true,
        isAdmin: _isAdmin != null ? _isAdmin.value : false,
        hasBackButton: false,
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
                "Salas Cadastradas",
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
                itemCount: roomsList.length,
                itemBuilder: (context, index) {
                  final roomName = roomsList[index].name!.toLowerCase();
                  final qEquipments = roomsList[index].equipments?.length ?? 0; 
                  final searchQuery = _searchController.text.toLowerCase();
                  
                  return roomName.contains(searchQuery)
                      ? CardRoom(roomName.toUpperCase(), qEquipments)
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

  Widget CardRoom(String name, int equipments) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.blue,
      elevation: 2,
      child: ListTile(
        title: Text(
          "Sala $name",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 129, 223),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "Equipamentos: $equipments",
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
          if (equipments == 0) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Informação'),
                  content: Text('A lista está vazia'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EquipmentRoomList(
                  roomName: name,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
