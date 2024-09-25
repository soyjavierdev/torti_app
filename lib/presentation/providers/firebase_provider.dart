
// Provider que maneja la lógica de los usuarios de fireBase
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';
import 'package:torti_app/infrastructure/datasource/main_datasource.dart';

final userOmeletteProvider = FutureProvider<List<OmelettesUser>>((ref) async {
  final libraryDatasource = LibraryDatasourceImpl();
  return await libraryDatasource.getAllUsers();
});


// Provider para incrementar omelettePaid
final incrementOmeletteProvider = FutureProvider.family<void, Map<String, dynamic>>((ref, userData) async {
  final libraryDatasource = LibraryDatasourceImpl();
  final userId = userData['id'];
  final omelettePaid = userData['omelettePaid'];
  await libraryDatasource.incrementOmelettePaid(userId, omelettePaid);
});

