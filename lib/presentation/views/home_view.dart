import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torti_app/presentation/widgets/home_groups.dart';
import 'package:torti_app/presentation/widgets/sidebar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = []; // Lista para almacenar los usuarios

  @override
  void initState() {
    super.initState();
    loadDataOmelettes(); // Carga los datos al iniciar el widget
  }

  Future<void> loadDataOmelettes() async {
    // Carga el archivo JSON desde los assets
    final jsonString =
        await rootBundle.loadString('assets/jsons/users_omelettes.json');
    setState(() {
      users =
          json.decode(jsonString); // Decodifica el JSON y actualiza el estado
    });
  }

  String getUserWithMoreOmelettes(List<dynamic> users) {
    if (users.isEmpty) return 'No hay usuarios';

    final dynamic topUser =
        users.reduce((a, b) => a['omelettePaid'] > b['omelettePaid'] ? a : b);

    return '${topUser['name']} ${topUser['lastname']} ${topUser['omelettePaid']}';
  }

  String getUserWithLessOmelettes(List<dynamic> users) {
    if (users.isEmpty) return 'No hay usuarios';

    final dynamic lastUser =
        users.reduce((a, b) => a['omelettePaid'] < b['omelettePaid'] ? a : b);

    return '${lastUser['name']} ${lastUser['lastname']} ${lastUser['omelettePaid']}';
  }

  //Función para incrementar omelette pagadas
  void incrementOmelettePaid(int group, int index, double amount) {
    setState(() {
      users.where((user) => user['grupo'] == group).toList()[index]
          ['omelettePaid'] += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar grupos
    final List<dynamic> group0 =
        users.where((user) => user['grupo'] == 0).toList();
    final List<dynamic> group1 =
        users.where((user) => user['grupo'] == 1).toList();
    final List<dynamic> group2 =
        users.where((user) => user['grupo'] == 2).toList();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo-torti-app.png',
          fit: BoxFit.contain,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: Padding(
        
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            //^ Lista del Grupo 0
            HomeGroups(
                users: group0,
                colors: const Color(0xFFE9FFF3),
                image: 'assets/images/trophy.png',
                titleText: 'Más tortillas pagadas',
                subheading: getUserWithMoreOmelettes(users),
                incrementOmelettePaid: incrementOmelettePaid),
            //^ GRUPO 1
            HomeGroups(
                users: group1,
                colors: const Color(0xFFFFE9E9),
                image: 'assets/images/sad-man.png',
                titleText: 'Te toca ir pagando',
                subheading: getUserWithLessOmelettes(users),
                incrementOmelettePaid: incrementOmelettePaid),
            //^ GRUPO 2
            HomeGroups(
                users: group2,
                colors: const Color(0xFFFFFCE9),
                image: 'assets/images/roulette.png',
                titleText: 'Ruleta',
                subheading: 'Prueba suerte',
                incrementOmelettePaid: incrementOmelettePaid),
        
            const SideBar(),
          ],
        ),
      ),
    );
  }
}
