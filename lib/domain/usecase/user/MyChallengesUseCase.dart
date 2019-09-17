import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class MyChallengesUseCase implements IMyChallengesUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  MyChallengesUseCase(this._localRepository, this._userRepository);

  @override
  Future<List<Challenge>> run() async {
    final accessToken = await this._localRepository.getCredentials();
    final userId = await this._localRepository.getId();
    final challenges =
    await this._userRepository.challenges(accessToken, userId);
    return challenges;
  }
}
