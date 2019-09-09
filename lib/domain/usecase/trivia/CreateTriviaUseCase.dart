import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class CreateTriviaUseCase implements ICreateTriviaUseCase {

  final ITriviaRepository _triviaRepository;
  final ILocalRepository _localRepository;

  CreateTriviaUseCase(this._localRepository, this._triviaRepository);

  @override
  Future<void> run(String question, String correctAnswer,
      String wrongAnswer, List<String> tags) async {
    final cred = await _localRepository.getCredentials();
    await _triviaRepository.create(cred, question,
        correctAnswer, wrongAnswer, tags);
  }


}