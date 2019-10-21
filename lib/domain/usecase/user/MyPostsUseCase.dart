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
