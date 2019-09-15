import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class GetChallengeUseCase implements IGetChallengeUseCase {
  final IChallengeRepository _challengeRepository;
  final ILocalRepository _localRepository;

  GetChallengeUseCase(this._localRepository, this._challengeRepository);

  @override
  Future<Challenge> run() async {
    final cred = await _localRepository.getCredentials();
    final challenge = await _challengeRepository.get(cred);
    return challenge;
  }
}
