import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:app/domain/boundary/PostBoundary.dart';

class ExplorePostsUseCase implements IExplorePostUseCase {
  final IExploreRepository _exploreRepository;
  final ILocalRepository _localRepository;

  ExplorePostsUseCase(this._exploreRepository, this._localRepository);

  @override
  Future<List<Post>> run(int amount) async {
    final accessToken = await this._localRepository.getCredentials();
    final posts = await this._exploreRepository.explore(accessToken, amount);
    return posts;
  }
}
