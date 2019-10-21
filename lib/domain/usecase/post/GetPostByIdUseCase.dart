

import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';

class GetPostByIdUseCase implements IGetPostByIdUseCase {
  final ILocalRepository _localRepository;
  final IPostRepository _postRepository;
  final IUserRepository _userRepository;

  GetPostByIdUseCase(this._localRepository, this._postRepository, this._userRepository);

  @override
  Future<Post> run(String postId) async {
    final accessToken = await this._localRepository.getCredentials();
    Post post = await this._postRepository.id(accessToken, postId);
    for(var i = 0; i < post.comments.length; i++) {
      final comment = post.comments[i];
      final user = await this._userRepository.id(accessToken, comment.userId);

      post.comments[i].user = user;
    }
    return post;
  }
}