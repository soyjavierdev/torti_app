import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torti_app/presentation/widgets/home_stat_widget.dart';
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

  // Función para sumar tortillas pagadas
  void incrementOmelettePaid(int group, int index, double amount) {
    setState(() {
      // Filtra a los usuarios del grupo específico y suma
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
      body: Row(
        children: [
          //^ Lista del Grupo 0
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeStat(
                    color: Colors.red,
                    titleText: 'Más tortillas pagadas',
                    subheading: ' ${getUserWithMoreOmelettes(users)}',
                  ),
                  const Text(
                    'Grupo 0',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Use ListView to allow scrolling
                  Expanded(
                    child: ListView.builder(
                      itemCount: group0.length,
                      itemBuilder: (context, index) {
                        var e = group0[index];

                        return Center(
                          // Center the ListTile
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Adjust size to fit content
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    incrementOmelettePaid(
                                        0, index, 1.0); // Increment by 1
                                  },
                                  tooltip: 'Agregar 1 Tortilla',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle),
                                  onPressed: () {
                                    incrementOmelettePaid(
                                        0, index, 0.5); // Increment by 0.5
                                  },
                                  tooltip: 'Agregar 0.5 Tortilla',
                                ),
                              ],
                            ),
                            title: Center(
                                child: Text('${e['name']} ${e['lastname']}')),
                            subtitle: Center(
                                child: Text(
                                    'Tortillas Pagadas: ${e['omelettePaid']}')),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          //^ GRUPO 1
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeStat(
                    color: Colors.blue,
                    titleText: 'Te toca ir pagando...',
                    subheading: ' ${getUserWithLessOmelettes(users)}',
                  ),
                  const Text(
                    'Grupo 1',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Use ListView to allow scrolling
                  Expanded(
                    child: ListView(
                      children: group1.map((e) {
                        return Center(
                          // Center the ListTile
                          child: ListTile(
                            title: Center(
                                child: Text('${e['name']} ${e['lastname']}')),
                            subtitle: Center(
                                child: Text(
                                    'Tortillas Pagadas: ${e['omelettePaid']}')),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //^ GRUPO 2
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HomeStat(
                    color: Colors.yellow,
                    titleText: 'Ruleta',
                    subheading: 'ee',
                  ),
                  const Text(
                    'Grupo 2',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Use ListView to allow scrolling
                  Expanded(
                    child: ListView(
                      children: group2.map((e) {
                        return Center(
                          // Center the ListTile
                          child: ListTile(
                            title: Center(
                                child: Text('${e['name']} ${e['lastname']}')),
                            subtitle: Center(
                                child: Text(
                                    'Tortillas Pagadas: ${e['omelettePaid']}')),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
          const SideBar(),
        ],
      ),
    );
  }

  Widget buildGroupList(List<dynamic> group, Color color, String title, String subheading) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 4),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeStat(
            color: color,
            titleText: title,
            subheading: subheading,
          ),
          const SizedBox(height: 8),
          const Text(
            'Grupo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: group.length,
              itemBuilder: (context, index) {
                var e = group[index];

                return Center(
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            incrementOmelettePaid(e['grupo'], index, 1.0);
                          },
                          tooltip: 'Agregar 1 Tortilla',
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: () {
                            incrementOmelettePaid(e['grupo'], index, 0.5);
                          },
                          tooltip: 'Agregar 0.5 Tortilla',
                        ),
                      ],
                    ),
                    title: Center(child: Text('${e['name']} ${e['lastname']}')),
                    subtitle: Center(child: Text('Tortillas Pagadas: ${e['omelettePaid']}')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
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
    body: Row(
      children: [
        // Grupo 0
        buildGroupList(
          group0,
          Colors.red,
          'Más tortillas pagadas',
          ' ${getUserWithMoreOmelettes(users)}',
        ),

        // Grupo 1
        buildGroupList(
          group1,
          Colors.blue,
          'Te toca ir pagando...',
          ' ${getUserWithLessOmelettes(users)}',
        ),

        // Grupo 2
        buildGroupList(
          group2,
          Colors.yellow,
          'Ruleta',
          'ee',
        ),

        const SideBar(),
      ],
    ),
  );
}

}
