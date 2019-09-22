import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class ChallengeSomeoneUseCase implements IChallengeSomeoneUseCase {
  final IChallengeRepository _challengeRepository;
  final ILocalRepository _localRepository;

  ChallengeSomeoneUseCase(this._localRepository, this._challengeRepository);

  @override
  Future<Challenge> run(String challengedId) async {
    final cred = await _localRepository.getCredentials();
    final challenge =
        await _challengeRepository.challengeSomeone(cred, challengedId);
    return challenge;
  }
}
