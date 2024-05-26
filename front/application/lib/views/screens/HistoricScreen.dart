import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front_end/database/models/Historyc.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/HistorycService.dart';
import 'package:intl/intl.dart';

class HistoricScreen extends StatefulWidget {
  const HistoricScreen({Key? key}) : super(key: key);

  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Historic> historicList = [];

  Future<void> getHistoric() async {
    try {
      List<dynamic> historicData = await getEquipamentWithHistoric();
      print('Data received from API: $historicData'); // Verifica os dados recebidos
      setState(() {
        historicList = historicData.map((e) 
          => Historic.fromJson(e)).toList();
      });
      //var date = historicList[0].inicialDate!.date;
      //print('DATA: $date'); // Verifica se a lista está sendo preenchida corretamente
      print('Historic List: $historicList'); // Verifica se a lista está sendo preenchida corretamente
    } catch (error) {
      print('Error fetching historic data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getHistoric();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isRoom: false,
        isAdmin: false,
        hasBackButton: false,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              "PESQUISAR",
              _searchController,
              Icons.search,
              false,
            ),
            SizedBox(height: 20),
            Text(
              "Histórico de Equipamentos",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 129, 223),
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: historicList.length,
                itemBuilder: (context, index) {
                  final historic = historicList[index];
                  return CardRoom(
                    historicList[index].equipamentName!,
                    historicList[index].room!,
                    '2022-01-01',
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, IconData icon, bool isPassword) {
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

  Widget CardRoom(String equipamentName, String room, String inicialDate) {
    print('Equipament Name: $equipamentName, Room: $room, Date: $inicialDate');
    return Card(
      child: ExpansionTile(
        title: Text(
          equipamentName.toUpperCase(),
          style: TextStyle(
            color: Color.fromARGB(255, 0, 129, 223),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          ListTile(
            title: Text(
              "Room: $room",
              style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              "Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(inicialDate))}", // Formata a data como string ISO
              style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
