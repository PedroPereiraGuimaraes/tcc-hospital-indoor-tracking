// ignore_for_file: prefer_const_constructors, ignore_for_file: file_names, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:front_end/database/models/EquipamentRoom.dart';
import 'package:front_end/database/services/RoomService.dart';
import 'package:front_end/views/screens/EquipmentInfoScreen.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/models/Room.dart';
import 'package:front_end/database/models/SetUser.dart';
import 'package:provider/provider.dart';

class EquipmentRoomList extends StatefulWidget {
  final String roomName;
  const EquipmentRoomList({Key? key, required this.roomName}) : super(key: key);
  @override
  State<EquipmentRoomList> createState() => _EquipmentRoomListState();
}

class _EquipmentRoomListState extends State<EquipmentRoomList> {
  final TextEditingController _searchController = TextEditingController();
  final _isAdmin = ValueNotifier<bool>(false);

  Future<List<EquipamentRoom>> getEquipaments() async {
    String roomName = widget.roomName;
    List<dynamic> equipaments = await getReadOne(roomName);
    return equipaments.map((e) => EquipamentRoom.fromJson(e)).toList();
  }
   @override
  void initState() {
    super.initState();
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
        isRoom: false,
        isAdmin: _isAdmin != null ? _isAdmin.value : false,
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
              child: FutureBuilder<List<EquipamentRoom>>(
                future: getEquipaments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar os dados'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhum equipamento encontrado'));
                  } else {
                    final equipamentList = snapshot.data!;
                    return ListView.builder(
                      itemCount: equipamentList[0].equipments?.length,
                      itemBuilder: (context, index) {
                        final equipmentName = equipamentList[0]
                            .equipments![index]
                            .equipment
                            ?.toLowerCase();
                        final searchQuery =
                            _searchController.text.toLowerCase();
                        return equipmentName!.contains(searchQuery)
                            ? CardEquipament(
                                equipamentList[0].equipments![index].equipment!,
                                widget.roomName,
                                equipamentList[0]
                                    .equipments![index]
                                    .patrimonio!,
                                DateTime.now(),
                              )
                            : SizedBox.shrink();
                      },
                    );
                  }
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
          name.toUpperCase(),
          style: TextStyle(
            color: Color.fromARGB(255, 0, 129, 223),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "$patrimonio \n ${time.day}/${time.month}/${time.year}",
          
          style: TextStyle(
            color: Color.fromARGB(255, 116, 122, 126),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
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
