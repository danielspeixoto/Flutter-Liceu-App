import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/domain/aggregates/exceptions/CreateTriviaExceptions.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/TriviaBoundary.dart';

class CreateTriviaUseCase implements ICreateTriviaUseCase {
  final ITriviaRepository _triviaRepository;
  final ILocalRepository _localRepository;

  CreateTriviaUseCase(this._localRepository, this._triviaRepository);

  @override
  Future<void> run(String question, String correctAnswer, String wrongAnswer,
      List<TriviaDomain> domains) async {

    if(domains.length == 0){
      throw CreateTriviaTagNullException();
    } else if(question.length < 20 || question.length > 300){
      throw CreateTriviaQuestionBoundaryException();
    } else if(correctAnswer.length < 1 || correctAnswer.length > 200){
      throw CreateTriviaCorrectAnswerBoundaryException();
    } else if(wrongAnswer.length < 1 || wrongAnswer.length > 200) {
      throw CreateTriviaWrongAnswerBoundaryException();
    }
    
    final cred = await _localRepository.getCredentials();
    await _triviaRepository.create(
        cred, question, correctAnswer, wrongAnswer, domains);
  }
}
