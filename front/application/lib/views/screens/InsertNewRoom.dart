import 'package:flutter/material.dart';
import 'package:front_end/views/screens/EquipmentListScreen.dart';
import 'package:front_end/views/screens/RoomsScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/RoomService.dart';

class AddRoomList extends StatefulWidget {
  const AddRoomList({Key? key}) : super(key: key);

  @override
  AddRoomListState createState() => AddRoomListState();
}

class AddRoomListState extends State<AddRoomList> {
  final TextEditingController _nameController = TextEditingController();

  void _addRoom() {
    String name = _nameController.text;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha o campo'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      createRoom(name).then((result) {
        if (result == 'Success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sala adicionada com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RoomsScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao adicionar sala'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isRoom: true,
        isAdmin: true,
        hasBackButton: true,
        // Adiciona um ícone à app bar
        
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        color: Colors.grey[200], // Adiciona uma cor de fundo suave
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Adicione a nova sala",
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 129, 223),
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField(_nameController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addRoom,
              child: Text(
                'Adicionar Sala',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ), backgroundColor: Colors.blue,
                elevation: 2,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }

  Widget _buildTextField(TextEditingController name) {
    return TextField(
      controller: name,
      decoration: InputDecoration(
        labelText: "Nome da Sala",
        labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: Icon(
          Icons.room,
          color: Color.fromARGB(255, 0, 129, 223),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget CardRoom(String name) {
    return Card(
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EquipmentListScreen(),
            ),
          );
        },
      ),
    );
  }
}
