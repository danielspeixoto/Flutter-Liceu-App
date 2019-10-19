import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class UpdatePostCommentUseCase implements IUpdatePostCommentUseCase {
  final ILocalRepository _localRepository;
  final IPostRepository _postRepository;

  UpdatePostCommentUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String postId, String comment) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.updatePostComment(accessToken, postId, comment);
  
  }
}