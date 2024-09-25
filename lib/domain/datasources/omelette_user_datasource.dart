//? Interfaz que define métodos para obtener y agregar la logica de usuarios.
import 'package:torti_app/domain/entities/omelettes_user.dart';

abstract class OmeletteUserDatasource {
 // Método para obtener todas los users.
  Future<List<OmelettesUser>> getAllUsers();

    Future<void> incrementOmelettePaid(String userId, double amount);

}