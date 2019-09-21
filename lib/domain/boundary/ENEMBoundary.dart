

import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/aggregates/ENEMVideo.dart';

abstract class IENEMQuestionRepository {
  Future<List<ENEMQuestion>> random(String accessToken, int amount, List<QuestionDomain> domains);
  Future<List<ENEMVideo>> videos(String accessToken, String id);
}

abstract class IGetENEMQuestionsUseCase {
  Future<List<ENEMQuestion>> run(int amount, [List<QuestionDomain> domains]);
}

abstract class IGetENEMQuestionsVideosUseCase {
  Future<List<ENEMVideo>> run(String id);
}