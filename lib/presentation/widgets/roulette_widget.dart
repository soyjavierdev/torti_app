import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/presentation/providers/firebase_provider.dart';

class RouletteWidget extends ConsumerStatefulWidget {
  const RouletteWidget({super.key});

  @override
  _RouletteWidgetState createState() => _RouletteWidgetState();
}

class _RouletteWidgetState extends ConsumerState<RouletteWidget> {
  final StreamController<int> _selected = StreamController<
      int>.broadcast(); // Se cambia a broadcast para permitir múltiples escuchas

  @override
  void dispose() {
    _selected.close(); // Cierra el Stream cuando el widget es destruido
    super.dispose();
  }

  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> loadJsonData() async {
      String jsonString =
          await rootBundle.loadString('assets/users_photos.json');
      final jsonData = json.decode(jsonString);
      return jsonData;
    }

    final users = ref.watch(userNotifierProvider).users;
    final usersNoti = ref.watch(userNotifierProvider.notifier);

    final options = users.map((user) => user.name).toList();

    List<Color> colors = [
      const Color(0xFF2fddd4),
      const Color(0xFFffe66a),
      const Color(0xFFff3962),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ruleta de la fortuna
        SizedBox(
          width: 350,
          height: 350,
          child: FortuneWheel(
            onAnimationEnd: () {
              Confetti.launch(context,
                  options: const ConfettiOptions(
                      particleCount: 200, spread: 70, y: 0.6, ticks: 1000));

              if (_selected != null) {
                // print('HOLA ${users[selectedOption].id}');
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Center(child:  Text('¡A pagar rata!')),
                    content: Column(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        Text('Eres el elegido: ${options[selectedOption]}'),
                        const SizedBox(
                            height: 20), // Espacio entre el texto y la imagen
                        Image.network(usersNoti.loadPhotoFromId(users[selectedOption].id)
                            ), // Reemplaza con tu imagen
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Cerrar el cuadro de diálogo
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
            items: [
              for (var option in options)
                FortuneItem(
                  style: FortuneItemStyle(
                    color: colors[options.indexOf(option) % colors.length],
                    borderColor: Colors.transparent,
                    borderWidth: 3,
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            if (options.isNotEmpty) {
              int selectedIndex = Random().nextInt(options.length);
              setState(() {
                selectedOption = selectedIndex;
              });
              _selected.add(selectedIndex);
            }
          },
          child: const Text('Girar la Ruleta'),
        ),
      ],
    );
  }
}
