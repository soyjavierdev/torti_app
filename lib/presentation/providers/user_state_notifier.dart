import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/infrastructure/datasource/main_datasource.dart';

class UserStateNotifier extends StateNotifier<List<OmelettesUser>> {
  UserStateNotifier() : super([]);

  final LibraryDatasourceImpl _libraryDatasource = LibraryDatasourceImpl();

  // Método para cargar los usuarios
  Future<void> loadUsers() async {
    state = await _libraryDatasource.getAllUsers();
  }

  // Método para incrementar tortillas pagadas
  Future<void> incrementOmelettePaid(String userId, double increment) async {
    final index = state.indexWhere((user) => user.id == userId);
    if (index != -1) {
      // Incrementar el conteo en la base de datos
      await _libraryDatasource.incrementOmelettePaid(userId, increment);
      
      // Actualizar el estado local
      final updatedUser = state[index].copyWith(
        omelettePaid: state[index].omelettePaid + increment,
      );

      // Actualizar el estado con el nuevo usuario
      state = [
        ...state.sublist(0, index),
        updatedUser,
        ...state.sublist(index + 1),
      ];
    }
  }
}

// Crear un proveedor para el UserStateNotifier
final userStateProvider = StateNotifierProvider<UserStateNotifier, List<OmelettesUser>>((ref) {
  return UserStateNotifier();
});
