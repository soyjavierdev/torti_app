import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/presentation/providers/firebase_provider.dart';

class GroupTabs extends ConsumerWidget {
  const GroupTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(userNotifierProvider).selectedGroups;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          isSelected: groups,
          onPressed: (int index) {
            ref.read(userNotifierProvider.notifier).updateTab(index);
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Grupo 0'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Grupo 1'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Grupo 2'),
            ),
          ],
        ),
      ],
    );
  }
}
