import 'package:flutter/material.dart';
import 'package:torti_app/presentation/widgets/roulette_widget.dart'; // Asegúrate de tener importada la RouletteWidget

class RouletteDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 600, 
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¡Gira la ruleta!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Aquí mostramos la ruleta en lugar del texto "Hola"
                  const RouletteWidget(), // Este widget debe mostrar la ruleta
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
