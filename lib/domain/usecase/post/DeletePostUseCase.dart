import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class DeletePostUseCase implements IDeletePostUseCase {
  final IPostRepository _postRepository;
  final ILocalRepository _localRepository;

  DeletePostUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String postId) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.delete(accessToken, postId);
  }
}
