// ignore_for_file: file_names, unused_import, unused_local_variable, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front_end/database/models/Equipament.dart';
import 'package:front_end/database/models/Historic.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:front_end/database/services/HistoricService.dart';
import 'package:intl/intl.dart';

class HistoricScreen extends StatefulWidget {
  const HistoricScreen({Key? key}) : super(key: key);

  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<EquipmentWithHistory> historicList = [];

  Future<void> getHistoric() async {
    List<dynamic> historicData = await getEquipamentWithHistoric();
    historicList =  historicData.map((e) {
  if (e.containsKey('historic')) {
    return EquipmentWithHistory.fromJson(e);
  } else {
    return EquipmentWithHistory(
      name: e['name'],
      patrimonio: e['patrimonio'],
      historic: [], // ou null, dependendo do que faz sentido para sua aplicação
    );
  }
}).toList();
    setState(() {
      historicList = historicList;
    });
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
                  return CardRoom(historicList[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 2),
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

  Widget CardRoom(EquipmentWithHistory equipment) {
    List<HistoricEntry> historyList = equipment.historic;
    return Card(
      child: ExpansionTile(
        title: Text(
          equipment.name.toUpperCase(),
          style: TextStyle(
            color: Color.fromARGB(255, 0, 129, 223),
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "Patrimônio: ${equipment.patrimonio}",
          style: TextStyle(
            color: Colors.grey,
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            fontSize: 15,
          ),
        ),
        children: historyList.asMap().entries.map((entry) {
          int index = entry.key;
          HistoricEntry history = entry.value;

          return Column(
            children: [
              ListTile(
                title: Text(
                  "Sala ${history.room}",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  "${DateFormat('dd/MM/yyyy (HH:mm)').format(history.inicialDate)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    fontSize: 15,
                  ),
                ),
              ),
              if (index < historyList.length - 1)
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
