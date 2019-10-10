

import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class GetPostByIdUseCase implements IGetPostByIdUseCase {
  final ILocalRepository _localRepository;
  final IPostRepository _postRepository;

  GetPostByIdUseCase(this._localRepository, this._postRepository);

  @override
  Future<Post> run(String postId) async {
    final accessToken = await this._localRepository.getCredentials();
    final post = await this._postRepository.id(accessToken, postId);
    return post;
  }
}