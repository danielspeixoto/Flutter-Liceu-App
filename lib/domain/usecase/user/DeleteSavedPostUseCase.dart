import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class DeleteSavedPostUseCase implements IDeleteSavedPostUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  DeleteSavedPostUseCase(this._localRepository, this._userRepository);

  Future<void> run(String postId) async {
    final accessToken = await this._localRepository.getCredentials();
    final userId = await this._localRepository.getId();

    await _userRepository.deleteSavedPost(accessToken, userId, postId);
  }
}
