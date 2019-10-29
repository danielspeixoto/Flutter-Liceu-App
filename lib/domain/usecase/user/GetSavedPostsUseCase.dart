import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class GetSavedPostsUseCase implements IGetSavedPostsUseCase {
  final ILocalRepository _localRepository;
  final IUserRepository _userRepository;
  final IPostRepository _postRepository;
  

  GetSavedPostsUseCase(this._localRepository, this._userRepository, this._postRepository);

  @override
  Future<List<Post>> run() async {
    final cred = await _localRepository.getCredentials();
    final userId = await _localRepository.getId();
    List<String> postsId = await _userRepository.getSavedPosts(cred, userId);
    List<Post> posts = new List<Post>();
    for(var i = 0; i < postsId.length; i++) {
      posts.add(await _postRepository.id(cred, postsId[i]));
    }
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
