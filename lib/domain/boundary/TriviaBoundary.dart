

import 'package:app/domain/aggregates/Trivia.dart';

abstract class ITriviaRepository {
  Future<void> create(String accessToken, String question, String correctAnswer,
      String wrongAnswer, List<TriviaDomain> domains);
}

abstract class ICreateTriviaUseCase {
  Future<void> run(String question, String correctAnswer, String wrongAnswer,
      List<TriviaDomain> domains);
}
