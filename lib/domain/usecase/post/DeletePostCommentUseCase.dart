import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class DeletePostCommentUseCase implements IDeletePostCommentUseCase {
  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  DeletePostCommentUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String postId, String commentId) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.deletePostComment(accessToken, postId, commentId);
  }
}
