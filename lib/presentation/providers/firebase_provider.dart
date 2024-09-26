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
      if(element.keys.first == userId){

        log(element.values.first);
        return element.values.first;
      }
    }

    return '';
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
  final List<Map<String, dynamic>> usersPhoto;

  UserState({required this.users, required this.usersPhoto});

  factory UserState.initial() {
    return UserState(users: [], usersPhoto: []);
  }

  UserState copyWith(
      {List<OmelettesUser>? users, List<Map<String, dynamic>>? usersPhoto}) {
    return UserState(
        users: users ?? this.users, usersPhoto: usersPhoto ?? this.usersPhoto);
  }
}
