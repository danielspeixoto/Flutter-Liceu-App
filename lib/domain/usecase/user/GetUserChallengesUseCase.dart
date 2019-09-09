import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class GetUserChallengesUseCase implements IGetUserChallengesUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  GetUserChallengesUseCase(this._localRepository, this._userRepository);

  @override
  Future<List<Challenge>> run(String userId) async {
    final accessToken = await this._localRepository.getCredentials();
    final challenges =
        await this._userRepository.challenges(accessToken, userId);
    return challenges;
  }
}
