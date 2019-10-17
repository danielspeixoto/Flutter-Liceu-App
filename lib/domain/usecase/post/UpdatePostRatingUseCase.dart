import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class UpdatePostRatingUseCase implements IUpdatePostRatingUseCase {
  final ILocalRepository _localRepository;
  final IPostRepository _postRepository;

  UpdatePostRatingUseCase(this._localRepository, this._postRepository);

  @override
  Future<void> run(String postId) async {
    final accessToken = await this._localRepository.getCredentials();
    await this._postRepository.updateRating(accessToken, postId);
  
  }
}