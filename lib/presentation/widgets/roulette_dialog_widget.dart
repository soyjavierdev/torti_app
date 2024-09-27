import 'package:flutter/material.dart';
import 'package:torti_app/presentation/widgets/group_tabs.dart';
import 'package:torti_app/presentation/widgets/roulette_widget.dart';

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
              height: 650,
              width: 550,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¡Gira la ruleta!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const GroupTabs(),
                  const SizedBox(height: 20),
                   RouletteWidget(), // Este widget muestrala ruleta
                  const SizedBox(height: 20),
                  OutlinedButton(
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
