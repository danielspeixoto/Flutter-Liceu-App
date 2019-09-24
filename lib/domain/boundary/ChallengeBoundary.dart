import 'package:app/domain/aggregates/Challenge.dart';

abstract class IChallengeRepository {
  Future<Challenge> get(String accessToken);
  Future<Challenge> challengeSomeone(String accessToken, String challengedId);
  Future<void> submitResult(
      String accessToken, String challengeId, List<String> answers);
}

abstract class IGetChallengeUseCase {
  Future<Challenge> run();
}

abstract class IChallengeSomeoneUseCase {
  Future<Challenge> run(String challengedId);
}

abstract class ISubmitChallengeAnswersUseCase {
  Future<void> run(String challengeId, List<String> answers);
}
