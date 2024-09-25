import 'package:cloud_firestore/cloud_firestore.dart';

class OmelettesUser {
  final String id;
  final String name;
  final String lastname;
  final double omelettePaid; // Cambiado a double
  final int group;

  OmelettesUser({
    required this.id,
    required this.name,
    required this.lastname,
    required this.omelettePaid,
    required this.group,
  });

  factory OmelettesUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return OmelettesUser(
      id: doc.id,
      name: data['name'] ?? 'Unknown',
      lastname: data['lastname'] ?? 'Unknown',
      omelettePaid: (data['omelettePaid'] ?? 0).toDouble(), // Asegúrate de que sea double
      group: data['group'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'lastname': lastname,
      'omelettePaid': omelettePaid,
      'group': group,
    };
  }

  OmelettesUser copyWith({
    String? id,
    String? name,
    String? lastname,
    double? omelettePaid,
    int? group,
  }) {
    return OmelettesUser(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      omelettePaid: omelettePaid ?? this.omelettePaid,
      group: group ?? this.group,
    );
  }


  @override
  String toString() {
    return 'OmelettesUser(id: $id, name: $name, lastname: $lastname, omelettePaid: $omelettePaid, group: $group)';
  }
}
