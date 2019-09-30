import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';

class GetChallengeByIdUseCase implements IGetChallengeByIdUseCase {
  final IChallengeRepository _challengeRepository;
  final ILocalRepository _localRepository;

  GetChallengeByIdUseCase(this._localRepository, this._challengeRepository);

  @override
  Future<Challenge> run(String id) async {
    final cred = await _localRepository.getCredentials();
    final challenge = await _challengeRepository.id(cred, id);
    return challenge;
  }
}
