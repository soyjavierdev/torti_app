import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/infrastructure/datasource/main_datasource.dart';

class UserNotifier extends StateNotifier<UserState> {
  final LibraryDatasourceImpl libraryDatasource;

  UserNotifier(this.libraryDatasource) : super(UserState.initial());

  Future<void> fetchUsers() async {
    final users = await libraryDatasource.getAllUsers();
    state = state.copyWith(users: users);
  }

  Future<void> incrementOmelettePaid(String userId, double omelettePaid) async {
    await libraryDatasource.incrementOmelettePaid(userId, omelettePaid);
    await fetchUsers(); // Volver a cargar la lista de usuarios después de la actualización
  }

  Future<void> loadUsersPhoto() async {
    String jsonString = await rootBundle.loadString('/jsons/users_photos.json');

    final jsonData = json.decode(jsonString);
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(jsonData);

    state = state.copyWith(usersPhoto: dataList);
  }

  String loadPhotoFromId(String userId) {
    log(userId);
    // Recorre la lista de mapas para encontrar el usuario con el id que coincida
    final usersPhoto = state.usersPhoto;
    for (var element in usersPhoto) {
      if (element.keys.first == userId) {
        log(element.values.first);
        return element.values.first;
      }
    }

    return '';
  }

  Future<void> updateSelectedUser(OmelettesUser? user) async {

    await Future.delayed(const Duration(microseconds: 500));
    
    state = state.copyWith(selectedUser: user);
  }



void updateTab(int index) {
  List<bool> updatedTabs = List.from(state.selectedGroups); // Crear una copia de la lista

  // Cambiar el estado de solo el índice seleccionado
  updatedTabs[index] = !updatedTabs[index];

  // Filtrar los usuarios basados en los grupos seleccionados
  final users = state.users.where((e) => updatedTabs[e.group]).toList();

  // Actualizar el estado
  state = state.copyWith(selectedGroups: updatedTabs, usersFiltered: users);
}
}

// Provider para el UserNotifier
final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  final libraryDatasource = LibraryDatasourceImpl();
  return UserNotifier(libraryDatasource);
});

class UserState {
  final List<OmelettesUser> users;
  final List<OmelettesUser> usersFiltered;
  final List<Map<String, dynamic>> usersPhoto;
  final List<bool> selectedGroups;
  final OmelettesUser? selectedUser;

  UserState(
      {required this.users,
      required this.usersPhoto,
      required this.selectedGroups,
      required this.usersFiltered,
      this.selectedUser});

  factory UserState.initial() {
    return UserState(
        users: [],
        usersPhoto: [],
        selectedGroups: [false, false, false],
        usersFiltered: [],
        selectedUser: null);
  }

  UserState copyWith(
      {List<OmelettesUser>? users,
      List<Map<String, dynamic>>? usersPhoto,
      List<OmelettesUser>? usersFiltered,
      OmelettesUser? selectedUser,
      List<bool>? selectedGroups}) {
    return UserState(
        users: users ?? this.users,
        usersPhoto: usersPhoto ?? this.usersPhoto,
        selectedGroups: selectedGroups ?? this.selectedGroups,
        usersFiltered: usersFiltered ?? this.usersFiltered,
        selectedUser: selectedUser ?? this.selectedUser);
  }
}
