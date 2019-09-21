import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/aggregates/ENEMVideo.dart';
import 'package:app/domain/aggregates/ENEMGame.dart';

abstract class IENEMQuestionRepository {
  Future<List<ENEMQuestion>> random(
      String accessToken, int amount, List<QuestionDomain> domains);

  Future<List<ENEMVideo>> videos(String accessToken, String id);
}

abstract class IGetENEMQuestionsUseCase {
  Future<List<ENEMQuestion>> run(int amount, [List<QuestionDomain> domains]);
}

abstract class IGetENEMQuestionsVideosUseCase {
  Future<List<ENEMVideo>> run(String id);
}

abstract class IENEMGameRepository {
  Future<void> submitGame(
      String accessToken, List<ENEMAnswer> answers, int timeSpent);
}

abstract class ISubmitGameUseCase {
  Future<void> run(List<ENEMAnswer> answers, int timeSpent);
}
