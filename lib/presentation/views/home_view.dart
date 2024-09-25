
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
  List<dynamic> users = []; // Lista para almacenar los usuarios

  @override
  void initState() {
    super.initState();
  }

  String getUserWithMoreOmelettes(List<OmelettesUser> users) {
    if (users.isEmpty) return 'No hay usuarios';

    // Asegúrate de que ambos parámetros son de tipo OmelettesUser
    final topUser = users.reduce((OmelettesUser a, OmelettesUser b) =>
        a.omelettePaid > b.omelettePaid ? a : b);

    return '${topUser.name} ${topUser.lastname} ${topUser.omelettePaid}';
  }

  String getUserWithLessOmelettes(List<OmelettesUser> users) {
    if (users.isEmpty) return 'No hay usuarios';

    // Asegúrate de que ambos parámetros son de tipo OmelettesUser
    final lastUser = users.reduce((OmelettesUser a, OmelettesUser b) =>
        a.omelettePaid < b.omelettePaid ? a : b);

    return '${lastUser.name} ${lastUser.lastname} ${lastUser.omelettePaid}';
  }


  @override
   Widget build(BuildContext context) {
    final userOmeletteAsyncValue = ref.watch(userOmeletteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo-torti-app.png',
          fit: BoxFit.contain,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: userOmeletteAsyncValue.when(
        data: (List<OmelettesUser> users) {
          final List<OmelettesUser> group0 = users.where((user) => user.group == 0).toList();
          final List<OmelettesUser> group1 = users.where((user) => user.group == 1).toList();
          final List<OmelettesUser> group2 = users.where((user) => user.group == 2).toList();

          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                HomeGroups(
                  users: group0,
                  colors: const Color(0xFFE9FFF3),
                  image: 'assets/images/trophy.png',
                  titleText: 'Más tortillas pagadas',
                  subheading: getUserWithMoreOmelettes(users),
                  incrementOmelettePaid: (userId, omelettePaid) {
                    ref.read(incrementOmeletteProvider({
                      'id': userId,
                      'omelettePaid': omelettePaid,
                    }));
                  },
                ),
                HomeGroups(
                  users: group1,
                  colors: const Color(0xFFFFE9E9),
                  image: 'assets/images/rat.png',
                  titleText: 'Te toca ir pagando',
                  subheading: getUserWithLessOmelettes(users),
                  incrementOmelettePaid: (userId, omelettePaid) {
                    ref.read(incrementOmeletteProvider({
                      'id': userId,
                      'omelettePaid': omelettePaid,
                    }));
                  },
                ),
                HomeGroups(
                  users: group2,
                  colors: const Color(0xFFFFFCE9),
                  image: 'assets/images/roulette.png',
                  titleText: 'Ruleta',
                  subheading: 'Prueba suerte',
                  incrementOmelettePaid: (userId, omelettePaid) {
                    ref.read(incrementOmeletteProvider({
                      'id': userId,
                      'omelettePaid': omelettePaid,
                    }));
                  },
                ),
                const SideBar(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
