import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class SubmitChallengeAnswersUseCase implements ISubmitChallengeAnswersUseCase {

  final IChallengeRepository _challengeRepository;
  final ILocalRepository _localRepository;

  SubmitChallengeAnswersUseCase(this._localRepository, this._challengeRepository);

  @override
  Future<void> run(String challengeId, List<String> answers) async {
    final cred = await _localRepository.getCredentials();
    _challengeRepository.submitResult(cred, challengeId, answers);
  }
}