import 'package:app/domain/aggregates/Challenge.dart';

abstract class IChallengeRepository {
  Future<void> submitQuestion(String accessToken, String question,
      String correctAnswer, String wrongAnswer, List<String> tags);
  Future<Challenge> get(String accessToken);
  Future<void> submitResult(
      String accessToken, String challengeId, List<String> answers);
}

abstract class IGetChallengeUseCase {
  Future<Challenge> run();
}

abstract class ISubmitChallengeQuestionUseCase {
  Future<void> run(String question,
      String correctAnswer, String wrongAnswer, List<String> tags);
}

abstract class ISubmitChallengeAnswersUseCase {
  Future<void> run(String challengeId, List<String> answers);
}