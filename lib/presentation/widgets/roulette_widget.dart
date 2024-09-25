import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/infrastructure/datasource/main_datasource.dart'; // Asegúrate de importar tu repositorio

// Define tu FutureProvider fuera del widget
final userOmeletteProvider = FutureProvider<List<OmelettesUser>>((ref) async {
  final libraryDatasource = LibraryDatasourceImpl();
  return await libraryDatasource.getAllUsers();
});

class RouletteWidget extends ConsumerStatefulWidget {
  const RouletteWidget({super.key});

  @override
  _RouletteWidgetState createState() => _RouletteWidgetState();
}

class _RouletteWidgetState extends ConsumerState<RouletteWidget> {
  final StreamController<int> _selected = StreamController<int>.broadcast(); // Se cambia a broadcast para permitir múltiples escuchas

  @override
  void dispose() {
    _selected.close(); // Cierra el Stream cuando el widget es destruido
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    final usersAsyncValue = ref.watch(userOmeletteProvider);

    return usersAsyncValue.when(
      data: (users) {
        final options = users.map((user) => user.name).toList(); 

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ruleta de la fortuna
            SizedBox(
              width: 350, 
              height: 350,
              child: FortuneWheel(
                selected: _selected.stream, // Escucha el stream para seleccionar el valor
                items: [
                  for (var option in options)
                    FortuneItem(
                      child: Text(option, style: const TextStyle(fontSize: 18)), // Personaliza el texto de cada item
                    ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (options.isNotEmpty) {
                  int selectedIndex = Random().nextInt(options.length); // Selecciona un índice aleatorio
                 _selected.add(selectedIndex);
                 print('HOLA $_selected'); // Agrega el valor seleccionado al Stream
                }
              },
              child: const Text('Girar la Ruleta'),
            ),    
          ],
        );
      },
      loading: () => const CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
      error: (error, stack) => Text('Error: $error'), // Manejo de errores
    );
  }
}
