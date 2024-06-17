// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:front_end/database/models/Equipament.dart';
import 'package:front_end/database/services/EquipamentService.dart';
import 'package:front_end/views/screens/EquipmentInfoScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({super.key});

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Equipament> equipamentsList = [];

  Future<void> getEquipaments() async {
    List<dynamic> equipaments = await getReadAll();
    equipamentsList = equipaments.map((e) => Equipament.fromJson(e)).toList();
    setState(() {
      equipamentsList = equipamentsList;
      equipaments = equipaments;
    });
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
        isAdmin: true,
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
                "Equipamentos",
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
                itemCount: equipamentsList.length,
                itemBuilder: (context, index) {
                  return CardRoom(
                    equipamentsList[index].name.toUpperCase(),
                    equipamentsList[index].currentRoom.toUpperCase(),
                    equipamentsList[index].patrimonio,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
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


  Widget CardRoom(String name, String room, String patrimonio) {
  TextEditingController _editController = TextEditingController(text: name);
  
  return Card(
    color: Colors.white,
    shadowColor: Colors.blue,
    elevation: 2,
    child: ListTile(
      title: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Editar Nome do Equipamento'),
                content: TextField(
                  controller: _editController,
                  decoration: InputDecoration(hintText: "Novo Nome"),
                ),
                actions: [
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      setState(() {
                        // Atualizar o nome do equipamento
                        name = _editController.text;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          name,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 129, 223),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      subtitle: Text(
        "Última vez visto: Sala $room",
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
