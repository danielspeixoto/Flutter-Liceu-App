import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class MyPostsUseCase implements IMyPostsUseCase {
  final IUserRepository _userRepository;
  final ILocalRepository _localRepository;

  MyPostsUseCase(this._localRepository, this._userRepository);

  @override
  Future<List<Post>> run() async {
    final accessToken = await this._localRepository.getCredentials();
    final userId = await this._localRepository.getId();
    final posts = await this._userRepository.posts(accessToken, userId);
    return posts;
  }

}
