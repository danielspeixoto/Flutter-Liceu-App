import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class SubmitChallengeQuestionUseCase implements ISubmitChallengeQuestionUseCase {

  final IChallengeRepository _challengeRepository;
  final ILocalRepository _localRepository;

  SubmitChallengeQuestionUseCase(this._localRepository, this._challengeRepository);

  @override
  Future<void> run(String question, String correctAnswer,
      String wrongAnswer, List<String> tags) async {
    final cred = await _localRepository.getCredentials();
    await _challengeRepository.submitQuestion(cred, question,
        correctAnswer, wrongAnswer, tags);
  }


}