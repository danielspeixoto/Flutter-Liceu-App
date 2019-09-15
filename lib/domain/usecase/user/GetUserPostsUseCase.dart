import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class GetUserPostsUseCase implements IGetUserPostsUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  GetUserPostsUseCase(this._localRepository, this._userRepository);

  @override
  Future<List<Post>> run(String userId) async {
    final accessToken = await this._localRepository.getCredentials();
    final posts = await this._userRepository.posts(accessToken, userId);
    return posts;
  }
}
