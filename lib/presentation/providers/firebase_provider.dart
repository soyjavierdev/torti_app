import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/infrastructure/datasource/main_datasource.dart';

class UserNotifier extends StateNotifier<List<OmelettesUser>> {
  final LibraryDatasourceImpl libraryDatasource;

  UserNotifier(this.libraryDatasource) : super([]);

  Future<void> fetchUsers() async {
    final users = await libraryDatasource.getAllUsers();
    state = users;
  }

  Future<void> incrementOmelettePaid(String userId, double omelettePaid) async {
    await libraryDatasource.incrementOmelettePaid(userId, omelettePaid);
    await fetchUsers(); // Volver a cargar la lista de usuarios después de la actualización
  }
}

// Provider para el UserNotifier
final userNotifierProvider = StateNotifierProvider<UserNotifier, List<OmelettesUser>>((ref) {
  final libraryDatasource = LibraryDatasourceImpl();
  return UserNotifier(libraryDatasource);
});
