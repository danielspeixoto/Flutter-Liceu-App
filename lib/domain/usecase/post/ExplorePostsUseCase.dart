import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class ExplorePostsUseCase implements IExplorePostUseCase {
  final IExploreRepository _exploreRepository;
  final ILocalRepository _localRepository;
  final IUserRepository _userRepository;

  ExplorePostsUseCase(
      this._exploreRepository, this._localRepository, this._userRepository);

  @override
  Future<List<Post>> run(int amount) async {
    final accessToken = await this._localRepository.getCredentials();
    List<Post> posts =
        await this._exploreRepository.explore(accessToken, amount);
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
