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
    List<Post> posts =
        await this._userRepository.posts(accessToken, userId);
    for (var i = 0; i < posts.length; i++) {
      Post post = posts[i];
      for (var j = 0; j < post.comments.length; j++) {
        final comment = post.comments[j];
        final user = await this._userRepository.id(accessToken, comment.userId);

        posts[i].comments[j].user = user;
      }
    }
    return posts;
  }
}
