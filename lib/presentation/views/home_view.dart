import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/presentation/providers/firebase_provider.dart';
import 'package:torti_app/presentation/widgets/home_groups.dart';
import 'package:torti_app/presentation/widgets/sidebar_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar usuarios al iniciar
    ref.read(userNotifierProvider.notifier).fetchUsers();
    ref.read(userNotifierProvider.notifier).loadUsersPhoto();
  }

  String getUserWithMoreOmelettes(List<OmelettesUser> users) {
    if (users.isEmpty) return 'No hay usuarios';
    final topUser =
        users.reduce((a, b) => a.omelettePaid > b.omelettePaid ? a : b);
    return '${topUser.name} ${topUser.lastname} ${topUser.omelettePaid}';
  }

  String getUserWithLessOmelettes(List<OmelettesUser> users) {
    if (users.isEmpty) return 'No hay usuarios';
    final lastUser =
        users.reduce((a, b) => a.omelettePaid < b.omelettePaid ? a : b);
    return '${lastUser.name} ${lastUser.lastname} ${lastUser.omelettePaid}';
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(
        userNotifierProvider).users; // Escuchar cambios en la lista de usuarios

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo-torti-app.png',
          fit: BoxFit.contain,
       
          height: 60,
        ),
        centerTitle: true,
      ),
      body: users.isNotEmpty
          ? SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        HomeGroups(
                          users: users.where((user) => user.group == 0).toList(),
                          colors: const Color(0xFFE9FFF3),
                          image: 'assets/images/trophy.png',
                          titleText: 'Más tortillas pagadas',
                          subheading: getUserWithMoreOmelettes(users),
                          incrementOmelettePaid: (userId, omelettePaid) {
                            ref
                                .read(userNotifierProvider.notifier)
                                .incrementOmelettePaid(userId, omelettePaid);
                          },
                        ),
                        HomeGroups(
                          users: users.where((user) => user.group == 1).toList(),
                          colors: const Color(0xFFFFE9E9),
                          image: 'assets/images/rat.png',
                          titleText: 'Te toca ir pagando',
                          subheading: getUserWithLessOmelettes(users),
                          incrementOmelettePaid: (userId, omelettePaid) {
                            ref
                                .read(userNotifierProvider.notifier)
                                .incrementOmelettePaid(userId, omelettePaid);
                          },
                        ),
                        HomeGroups(
                          users: users.where((user) => user.group == 2).toList(),
                          colors: const Color(0xFFFFFCE9),
                          image: 'assets/images/roulette.png',
                          titleText: 'La ruleta de la suerte',
                          subheading: '¿Te atreves?',
                          incrementOmelettePaid: (userId, omelettePaid) {
                            ref
                                .read(userNotifierProvider.notifier)
                                .incrementOmelettePaid(userId, omelettePaid);
                          },
                        ),
                        const SideBar(),
                      ],
                    ),
                  ),
            const SizedBox(height: 30),

              ],
              
            ),
          )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
