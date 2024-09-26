import 'package:cloud_firestore/cloud_firestore.dart';

class OmelettesUser {
  final String id;
  final String name;
  final String lastname;
  final double omelettePaid; // Cambiado a double
  final int group;
  final String photoUrl;

  OmelettesUser({
    required this.id,
    required this.name,
    required this.lastname,
    required this.omelettePaid,
    required this.group,
    required this.photoUrl
  });

  factory OmelettesUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return OmelettesUser(
      id: doc.id,
      name: data['name'] ?? 'Unknown',
      lastname: data['lastname'] ?? 'Unknown',
      omelettePaid: (data['omelettePaid'] ?? 0).toDouble(), // Asegúrate de que sea double
      group: data['group'] ?? 0,
      photoUrl: data['photoUrl'] ?? 'Unknown'
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'lastname': lastname,
      'omelettePaid': omelettePaid,
      'group': group,
      'photoUrl':photoUrl
    };
  }

  OmelettesUser copyWith({
    String? id,
    String? name,
    String? lastname,
    double? omelettePaid,
    int? group,
    String? photoUrl
  }) {
    return OmelettesUser(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      omelettePaid: omelettePaid ?? this.omelettePaid,
      group: group ?? this.group,
      photoUrl: photoUrl ?? this.photoUrl
    );
  }


  @override
  String toString() {
    return 'OmelettesUser(id: $id, name: $name, lastname: $lastname, omelettePaid: $omelettePaid, group: $group,  photoUrl $photoUrl)';
  }
}
