import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class GetQuestionsUseCase implements IGetENEMQuestionsUseCase {

  final ILocalRepository _localRepository;
  final IENEMQuestionRepository _questionRepository;

  GetQuestionsUseCase(this._localRepository, this._questionRepository);

  @override
  Future<List<ENEMQuestion>> run(int amount, [List<QuestionDomain> domains]) async {
    final accessToken = await this._localRepository.getCredentials();
    if(domains == null) {
      domains = <QuestionDomain>[];
    }
    final questions = await this._questionRepository.random(accessToken, amount, domains);
    return questions;
  }

}