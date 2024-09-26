import 'package:flutter/material.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/presentation/widgets/home_stat_widget.dart';
import 'package:torti_app/presentation/widgets/roulette_dialog_widget.dart';

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
          BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 4 ),
          
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
               onTap: () {
                if (titleText == 'La ruleta de la suerte') {
                  RouletteDialog.show(context);
                }
              },
              child: HomeStat(
                color: colors,
                image: image,
                titleText: titleText,
                subheading: subheading,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Grupo ${users.isNotEmpty ? users.first.group : 'N/A'}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 8),
                    ...users.asMap().entries.map((entry) {
                      OmelettesUser user = entry.value; 
                      return Center(
                        child: ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [                           
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () {
                                 incrementOmelettePaid(user.id, -0.5); 
                                },
                                tooltip: 'Restar media tortilla',
                              ),
                               IconButton(
                                icon: const Icon(Icons.add_circle),
                                onPressed: () {
                                 incrementOmelettePaid(user.id, 0.5);                                
                                },
                                tooltip: 'Agregar media tortilla',
                              ),
                            ],
                          ),
                          title: Text('${user.name} ${user.lastname}'),
                          subtitle: Text(
                              'Tortillas Pagadas: ${user.omelettePaid}'),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
