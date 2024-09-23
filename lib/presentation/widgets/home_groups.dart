import 'package:flutter/material.dart';
import 'package:torti_app/presentation/widgets/home_stat_widget.dart';

class HomeGroups extends StatelessWidget {
  const HomeGroups(
      {super.key,
      required this.users,
      required this.colors,
      required this.titleText,
      required this.subheading,
      required this.incrementOmelettePaid,
      required this.image});

  final List<dynamic> users;
  final Color colors;
  final String image;
  final String titleText;
  final String subheading;
  final Function incrementOmelettePaid;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeStat(
              color: colors,
              image: image,
              titleText: titleText,
              subheading: subheading,
            ),
            const SizedBox(height: 18),


            
            Text(
              'Grupo ${users.first['grupo']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var e = users[index];
                  return Center(
                    // Center the ListTile
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Adjust size to fit content
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              incrementOmelettePaid(
                                  e['grupo'], index, 1); // Increment by 1
                            },
                            tooltip: 'Agregar 1 Tortilla',
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              incrementOmelettePaid(
                                  e['grupo'], index, 0.5); // Increment by 0.5
                            },
                            tooltip: 'Agregar 0.5 Tortilla',
                          ),
                        ],
                      ),
                      title:
                          Center(child: Text('${e['name']} ${e['lastname']}')),
                      subtitle: Center(
                          child:
                              Text('Tortillas Pagadas: ${e['omelettePaid']}')),
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
}
