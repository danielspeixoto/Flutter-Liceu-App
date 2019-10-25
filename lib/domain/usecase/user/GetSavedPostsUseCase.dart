import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class GetSavedPostsUseCase implements IGetSavedPostsUseCase {
  final ILocalRepository _localRepository;
  final IUserRepository _userRepository;
  

  GetSavedPostsUseCase(this._localRepository, this._userRepository);

  @override
  Future<List<Post>> run() async {
    final cred = await _localRepository.getCredentials();
    final userId = await _localRepository.getId();
    List<Post> posts = await _userRepository.getSavedPosts(cred, userId);
    for (var i = 0; i < posts.length; i++) {
      Post post = posts[i];
      for (var j = 0; j < post.comments.length; j++) {
        final comment = post.comments[j];
        final user = await this._userRepository.id(cred, comment.userId);

        posts[i].comments[j].user = user;
      }
    }
    return posts;
  }
}
