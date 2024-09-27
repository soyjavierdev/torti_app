import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/presentation/providers/firebase_provider.dart';

class RouletteWidget extends ConsumerWidget {
  RouletteWidget({super.key});

  final StreamController<int> _selected = StreamController<int>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userNotifierProvider).usersFiltered.isEmpty
        ? ref.watch(userNotifierProvider).users
        : ref.watch(userNotifierProvider).usersFiltered;


    List<Color> colors = [
      const Color(0xFF2fddd4),
      const Color(0xFFffe66a),
      const Color(0xFFff3962),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
  
        SizedBox(
          width: 350,
          height: 350,
          child: FortuneWheel(
            onAnimationEnd: () async {
              // Para esperar a que se complete la actualización del estado
              await Future.delayed(const Duration(milliseconds: 300));

              // Volver a leer el usuario seleccionado después de la espera
              final updatedSelectedOption =
                  ref.read(userNotifierProvider).selectedUser;

              Confetti.launch(context,
                  options: const ConfettiOptions(
                      particleCount: 200, spread: 70, y: 0.6, ticks: 1000));

              if (updatedSelectedOption != null) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Center(child: Text('¡A pagar rata!')),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Eres el elegido: ${updatedSelectedOption.name}'),
                        const SizedBox(height: 20),
                        Image.network(
                          updatedSelectedOption.photoUrl.isNotEmpty
                              ? updatedSelectedOption.photoUrl
                              : 'assets/images/david.jpg',                      
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              }
            },
            selected: _selected.stream,
            animateFirst: false,
            onAnimationStart: () {
              ref.read(userNotifierProvider.notifier).updateSelectedUser(null);
            },
            items: [
              for (var option in users)
                FortuneItem(
                  style: FortuneItemStyle(
                    color: colors[users.indexOf(option) % colors.length],
                    borderColor: Colors.transparent,
                    borderWidth: 3,
                  ),
                  child: Text(
                    option.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        FilledButton(
          onPressed: () {
            if (users.isNotEmpty) {
              int selectedIndex = Random().nextInt(users.length);
              ref
                  .read(userNotifierProvider.notifier)
                  .updateSelectedUser(users[selectedIndex])
                  .then((_) {
                _selected.add(
                    selectedIndex); // Agrega el índice seleccionado al Stream
              });
            }
          },
          child: const Text('Girar la Ruleta'),
        ),
      ],
    );
  }
}
