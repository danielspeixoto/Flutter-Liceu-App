import 'package:app/domain/aggregates/User.dart';

import 'TriviaData.dart';

class ChallengeData {
  final String id;
  final User challenger;
  final User challenged;
  final List<TriviaData> questions;

  ChallengeData(
    this.id,
    this.questions,
    this.challenger,
    this.challenged,
  );
}
