import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torti_app/domain/datasources/omelette_user_datasource.dart';
import 'package:torti_app/domain/entities/omelettes_user.dart';

const String LIBRARY_COLLECTION = 'tortilleros';

//? Implementación de la interfaz que interactúa con Firestore.
class LibraryDatasourceImpl extends OmeletteUserDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<OmelettesUser> _libraryCollection;

  LibraryDatasourceImpl() {
    _libraryCollection = _firestore
        .collection(LIBRARY_COLLECTION)
        .withConverter<OmelettesUser>(
          fromFirestore: (snapshot, _) => OmelettesUser.fromFirestore(snapshot),
          toFirestore: (omeletteUser, _) => omeletteUser.toFirestore(),
        );
  }

  // Obtener todos los usuarios
  @override
  Future<List<OmelettesUser>> getAllUsers() async {
    try {
      final querySnapshot = await _libraryCollection.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Error al obtener los usuarios: $e");
    }
  }

  // Método para incrementar omelettePaid de un usuario
  Future<void> incrementOmelettePaid(String userId, double amount) async {
    try {
      // Referencia al documento del usuario por su ID
      final userDocRef = _libraryCollection.doc(userId);

      // Obtener el documento actual
      final docSnapshot = await userDocRef.get();

      // Comprobar si el documento existe
      if (docSnapshot.exists) {
        // Obtener los datos del usuario
        final currentUser = docSnapshot.data();

        // Asegúrate de que omelettePaid es un número
        final currentOmelettePaid = currentUser?.omelettePaid ?? 0.0;

        // Actualizar omelettePaid
        await userDocRef.update({
          'omelettePaid': currentOmelettePaid + amount,
        });
      } else {
        throw Exception("Usuario no encontrado");
      }
    } catch (e) {
      throw Exception("Error al incrementar omelettePaid: $e");
    }
  }
}
