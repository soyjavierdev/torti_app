import 'package:torti_app/domain/entities/omelettes_user.dart';

Map<String, dynamic>? calculateProbabilities(List<OmelettesUser> participants) {
  final double totalPayments = participants.fold(
      0, (acc, participant) => acc + participant.omelettePaid);

  final allParticipants = participants.map((participant) {
    final weight = totalPayments - participant.omelettePaid + 1;
    return {
      'id': participant.id,
      'weight': weight,
    };
  }).toList();

  return selectRandom(allParticipants);
}

// --

Map<String, dynamic>? selectRandom(List<Map<String, dynamic>> participants) {
  final double sumWeights =
      participants.fold(0, (sum, p) => sum + p['weight']!);
  double random =
      (sumWeights * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000);

  for (var participant in participants) {
    random -= participant['weight'];
    if (random <= 0) {
      return participant;
    }
  }
  return null; // Por si no se encuentra ningún participante
}
